"""Whole-source triage. Findings require review; this is not a Lua type checker."""
from pathlib import Path
import re,json,sys,collections
from source_index import sections
r=Path(__file__).resolve().parents[1]
cfg=json.loads((r/'project.json').read_text())
paths=cfg['header']+cfg['triggers']+[cfg['bootstrap']]
sources={p:(r/p).read_text(encoding='utf-8') for p in paths}
api='\n'.join(p.read_text() for p in (r/'tools/reference-api').glob('*.j'))
api_functions=set(re.findall(r'\b(?:native|function)\s+(\w+)\s+takes',api))
defined=set()
locals_=set()
for code in sources.values():
    defined.update(re.findall(r'\bfunction\s+([\w.]+)\s*\(',code))
    locals_.update(re.findall(r'\blocal\s+(\w+)',code))
    for params in re.findall(r'function(?:\s+[\w.]+)?\s*\(([^)]*)\)',code):locals_.update(re.findall(r'\w+',params))
    locals_.update(re.findall(r'\b(\w+)\s*=\s*function\b',code))
# Warcraft Lua/hidden native declarations are absent from the JASS fixtures.
# Eikonium's Lua API reference explicitly documents FourCC and UnitAlive.
stdlib={'FourCC','UnitAlive','assert','error','pcall','xpcall','type','tostring','tonumber','setmetatable','getmetatable','ipairs','pairs','next','select','print','rawget','rawset','collectgarbage','load','require','dofile'}
keywords={'if','elseif','while','for','return','not','and','or','function'}
unknown=collections.defaultdict(list); executes=[]; contexts=[]; waits=[]
strip=re.compile(r'--\[\[.*?\]\]|--[^\n]*|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'',re.S)
getter_events={'GetAttacker':{'EVENT_PLAYER_UNIT_ATTACKED'},'GetAttackedUnitBJ':{'EVENT_PLAYER_UNIT_ATTACKED'},
 'GetSoldItem':{'EVENT_PLAYER_UNIT_SELL_ITEM'},'GetBuyingUnit':{'EVENT_PLAYER_UNIT_SELL_ITEM','EVENT_PLAYER_UNIT_SELL'},
 'GetSoldUnit':{'EVENT_PLAYER_UNIT_SELL','EVENT_UNIT_SELL'},'GetManipulatedItem':{'EVENT_PLAYER_UNIT_PICKUP_ITEM','EVENT_PLAYER_UNIT_DROP_ITEM','EVENT_PLAYER_UNIT_USE_ITEM'}}
# Preserve the event-context check at its original trigger boundary. Combining
# unrelated event subscriptions in one file must not weaken this review.
audited=[(path,code) for path,code in sources.items() if path not in cfg['triggers']]
audited += [(entry['module']+'#'+entry['name'],entry['code']) for entry in sections(cfg)]
for path,code in audited:
    clean=strip.sub(lambda m:'\n'*m[0].count('\n'),code)
    for m in re.finditer(r'(?<![\w.:])([A-Za-z_]\w*)\s*\(',clean):
        name=m[1]
        if name not in api_functions|defined|locals_|stdlib|keywords:unknown[name].append(path+':'+str(clean[:m.start()].count('\n')+1))
    for m in re.finditer(r'\b(FE_\w+\.\w+)\s*\(',clean):
        if m[1] not in defined:unknown[m[1]].append(path+':'+str(clean[:m.start()].count('\n')+1))
    for name in re.findall(r'ExecuteFunc\("([^"\n]+)"\)',code):executes.append({'target':name,'defined':name in defined,'module':path})
    events=set(re.findall(r'\bEVENT_\w+',code))
    for getter,allowed in getter_events.items():
        if getter+'(' in clean and events and not events.intersection(allowed):contexts.append({'module':path,'getter':getter,'registered_events':sorted(events)})
    for m in re.finditer(r'(?ms)^function ([\w.]+)\([^\n]*\)\n(.*?)^end\s*$',code):
        body=strip.sub('',m[2]);cut=body.find('TriggerSleepAction(')
        if cut>=0:
            after=body[cut:]
            waits.append({'function':m[1],'module':path,'getters_after_wait':sorted(set(re.findall(r'\b(Get\w+)\s*\(',after))),
                'globals_after_wait':sorted(set(re.findall(r'\budg_\w+',after)))})
report={'active_modules':len(paths),'disabled_modules':len(cfg['disabled']),'function_definitions':len(defined),
        'reference_api_functions':len(api_functions),'unknown_direct_calls':unknown,'literal_ExecuteFunc_targets':executes,
        'event_context_review_candidates':contexts,'wait_review':waits,
        'limitations':'Lexical triage, not complete type/control-flow analysis. Current native engine behavior and multiplayer remain unverified.'}
(r/'reports/whole-source-triage.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({k:v for k,v in report.items() if k!='wait_review'},indent=2))
print('Wait functions recorded:',len(waits))


