"""Baseline audit: every source function body survives assembly without edits."""
from pathlib import Path
import json,re,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
import assemble_port as assembler
def functions(code):return {m[1]:m[0].strip() for m in re.finditer(r'(?ms)^function (\w+)\([^\n]*\)\n.*?^end\s*?(?=\n|$)',code)}
def main():
    code=(ROOT/'map/ForestExpansion.w3x/war3map.lua').read_text();actual=functions(code)
    entries=json.loads((ROOT/'build/converted/functions.json').read_text())
    for entry in entries:
        name=entry['name'];expected=assembler.rename((ROOT/'build/converted'/(name+'.lua')).read_text()).strip()
        if name=='main':
            cut=expected.index('    ExecuteFunc(')
            bootstrap='function InitTrig_FE_Bootstrap()\n'+expected[cut:expected.rfind('\nend')]+'\nend'
            assert actual['InitTrig_FE_Bootstrap']==bootstrap
            expected=expected[:cut]+'    InitTrig_FE_Bootstrap()\nend'
        output_name=next(iter(functions(expected)))
        assert actual[output_name]==expected,'Changed function body: '+name
    globals_=(ROOT/'src/globals.lua').read_text().split('\n',1)[1].strip()
    assert globals_==(ROOT/'build/converted/globals.lua').read_text().strip()
    # Conservative definite-assignment analysis: no default-initialized Lua local
    # can hide a source read of an uninitialized JASS local in this map.
    model=json.loads((ROOT/'build/reference-model.json').read_text());uninitialized=[]
    def refs(n):
        if isinstance(n,list):
            if n and n[0] in ['var','array']:yield n[1]
            for v in n:yield from refs(v)
    def walk(body,declared,assigned,fn):
        assigned=set(assigned)
        def check(n):
            for v in refs(n):
                if v in declared and v not in assigned:uninitialized.append((fn,v))
        for s in body:
            if s[0]=='decl':
                _,name,typ,array,value=s
                if value is not None:check(value)
                declared.add(name)
                if value is not None or array:assigned.add(name)
            elif s[0]=='set':
                check(s[2:])
                if s[1] in declared:assigned.add(s[1])
            elif s[0]=='if':
                for condition,_ in s[1]:check(condition)
                branches=[walk(b,declared,assigned,fn) for _,b in s[1]]+[walk(s[2],declared,assigned,fn)]
                assigned.update(set.intersection(*branches))
            elif s[0]=='loop':walk(s[1],declared,assigned,fn)
            else:check(s)
        return assigned
    for name,fn in model['functions'].items():
        parameters={p[0] for p in fn['parameters']};walk(fn['body'],set(parameters),parameters,name)
    assert not uninitialized,uninitialized
    report={'function_bodies_matched':len(entries),'global_declarations_matched':True,'startup_split_matched':True,
        'potential_reads_of_uninitialized_locals':uninitialized,'scope':'checks assembly completeness against fresh typed translation; dynamic tests independently evaluate the original JASS AST'}
    (ROOT/'reports/source-audit.json').write_text(json.dumps(report,indent=2)+'\n')
    print('Source assembly audit passed:',len(entries),'function bodies and all global declarations.')
if __name__=='__main__':main()
