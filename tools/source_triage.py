"""Whole-source lexical triage; findings require review, not a correctness proof."""
from pathlib import Path
import collections
import json
import re
from lua_source import code_only, functions, tokens
from source_index import SECTION

ROOT = Path(__file__).resolve().parents[1]
STDLIB = {'FourCC', 'UnitAlive', 'assert', 'error', 'pcall', 'xpcall', 'type',
          'tostring', 'tonumber', 'setmetatable', 'getmetatable', 'ipairs', 'pairs',
          'next', 'select', 'print', 'rawget', 'rawset', 'collectgarbage', 'load',
          'require', 'dofile'}
KEYWORDS = {'if', 'elseif', 'while', 'for', 'return', 'not', 'and', 'or', 'function'}
GETTER_EVENTS = {
    'GetAttacker': {'EVENT_PLAYER_UNIT_ATTACKED'},
    'GetAttackedUnitBJ': {'EVENT_PLAYER_UNIT_ATTACKED'},
    'GetSoldItem': {'EVENT_PLAYER_UNIT_SELL_ITEM'},
    'GetBuyingUnit': {'EVENT_PLAYER_UNIT_SELL_ITEM', 'EVENT_PLAYER_UNIT_SELL'},
    'GetSoldUnit': {'EVENT_PLAYER_UNIT_SELL', 'EVENT_UNIT_SELL'},
    'GetManipulatedItem': {'EVENT_PLAYER_UNIT_PICKUP_ITEM',
                          'EVENT_PLAYER_UNIT_DROP_ITEM', 'EVENT_PLAYER_UNIT_USE_ITEM'},
}


def boundaries(path, source, trigger_module):
    """Original event scopes plus shared code, retaining full-module offsets."""
    if not trigger_module:
        return [(path, 0, len(source))], []
    matches = list(SECTION.finditer(source))
    if not matches:
        raise ValueError('Missing source-section provenance: ' + path)
    scopes = [(path + '#' + match[2], match.start(3), match.end(3)) for match in matches]
    shared = []
    cursor = 0
    for match in matches:
        shared.append((cursor, match.start()))
        cursor = match.end()
    shared.append((cursor, len(source)))
    return scopes, shared


def simple_literal(token):
    """Resolve identifier-only strings; escaped/dynamic targets stay reviewable."""
    value = token.text
    if value.startswith(('"', "'")):
        value = value[1:-1]
    else:
        opening = re.match(r'\[(=*)\[', value)
        if not opening:
            return None
        value = value[opening.end():-(len(opening[1]) + 2)]
        if value.startswith('\n'):
            value = value[1:]
    return value if re.fullmatch(r'[A-Za-z_]\w*', value) else None


def inspect(cfg, sources, api_functions):
    parsed = {path: (code_only(source), functions(source), tokens(source))
              for path, source in sources.items()}
    defined, locals_ = set(), set()
    for clean, spans, stream in parsed.values():
        defined.update(entry['name'] for entry in spans if entry['name'])
        locals_.update(re.findall(r'\blocal\s+(\w+)', clean))
        for entry in spans:
            cursor = entry['token_start'] + 1
            while stream[cursor].text != '(':
                cursor += 1
            cursor += 1
            while stream[cursor].text != ')':
                if stream[cursor].kind == 'word':
                    locals_.add(stream[cursor].text)
                cursor += 1
        locals_.update(re.findall(r'\b(\w+)\s*=\s*function\b', clean))
    known = api_functions | defined | locals_ | STDLIB | KEYWORDS
    unknown = collections.defaultdict(list)
    executes, unresolved_executes, contexts, unbound_contexts, waits, coverage = [], [], [], [], [], []
    for path, source in sources.items():
        clean, spans, stream = parsed[path]
        scopes, shared = boundaries(path, source, path in cfg['triggers'])

        def scope_at(offset):
            return next((label for label, start, end in scopes if start <= offset < end), path + '#shared')

        def line_at(offset):
            return source.count('\n', 0, offset) + 1

        # Calls and ExecuteFunc inspect the complete module, never just sections.
        declaration_offsets = {entry['token_start'] + 1 for entry in spans}
        call_count = 0
        for index, token in enumerate(stream):
            if token.kind != 'word' or index + 1 >= len(stream) or stream[index + 1].text != '(':
                continue
            previous = stream[index - 1].text if index else None
            if previous in ('.', ':') or index in declaration_offsets or token.text in KEYWORDS:
                continue
            call_count += 1
            if token.text not in known:
                unknown[token.text].append(scope_at(token.start) + ':' + str(line_at(token.start)))
            if token.text == 'ExecuteFunc':
                argument = stream[index + 2] if index + 2 < len(stream) else None
                target = simple_literal(argument) if argument and argument.kind == 'string' else None
                record = {'module': path, 'scope': scope_at(token.start), 'line': line_at(token.start)}
                if target is not None and index + 3 < len(stream) and stream[index + 3].text == ')':
                    executes.append(dict(record, target=target, defined=target in defined))
                else:
                    unresolved_executes.append(record)
        for match in re.finditer(r'\b(FE_\w+\.\w+)\s*\(', clean):
            if match[1] not in defined:
                unknown[match[1]].append(scope_at(match.start()) + ':' + str(line_at(match.start())))

        # Preserve each legacy subscription boundary. Shared helpers have no
        # inherited subscription; their callers need manual context review.
        event_scopes = [(label, clean[start:end]) for label, start, end in scopes]
        shared_clean = '\n'.join(clean[start:end] for start, end in shared)
        if shared_clean.strip():
            event_scopes.append((path + '#shared', shared_clean))
        for label, body in event_scopes:
            events = set(re.findall(r'\bEVENT_\w+', body))
            for getter, allowed in GETTER_EVENTS.items():
                if not re.search(r'\b' + getter + r'\s*\(', body):
                    continue
                record = {'module': path, 'scope': label, 'getter': getter,
                          'registered_events': sorted(events)}
                if events and not events.intersection(allowed):
                    contexts.append(record)
                elif not events:
                    unbound_contexts.append(record)

        # Include local/anonymous functions and nested contents conservatively:
        # a callback can run synchronously and does not establish a new thread.
        for entry in spans:
            body = clean[entry['start']:entry['end']]
            wait = re.search(r'\bTriggerSleepAction\s*\(', body)
            if wait:
                after = body[wait.start():]
                waits.append({'function': entry['name'] or '<anonymous>',
                              'kind': 'anonymous' if not entry['name'] else 'local' if entry['local'] else 'named',
                              'module': path, 'scope': scope_at(entry['start']), 'line': entry['line'],
                              'getters_after_wait': sorted(set(re.findall(r'\b(Get\w+)\s*\(', after))),
                              'globals_after_wait': sorted(set(re.findall(r'\budg_\w+', after)))})
        coverage.append({'module': path, 'complete_module_scanned': True,
                         'function_spans': len(spans), 'direct_call_sites': call_count,
                         'original_sections': len(scopes) if path in cfg['triggers'] else 0,
                         'shared_code_scanned': bool(shared_clean.strip())})
    return {'active_modules': len(sources), 'disabled_modules': len(cfg['disabled']),
            'function_definitions': len(defined), 'function_spans': sum(len(item[1]) for item in parsed.values()),
            'reference_api_functions': len(api_functions), 'module_coverage': coverage,
            'unknown_direct_calls': dict(unknown), 'literal_ExecuteFunc_targets': executes,
            'unresolved_ExecuteFunc_targets': unresolved_executes,
            'event_context_review_candidates': contexts,
            'event_getters_without_local_subscription': unbound_contexts, 'wait_review': waits,
            'limitations': 'Lexical triage, not type/control-flow or scope resolution. Known local/parameter names are approximated across modules; indirect/table-dispatched calls are not resolved. Event scopes retain original sections; shared helpers and getters without a local subscription require caller review. Nested callbacks remain in wait scans conservatively. Native engine behavior and multiplayer remain unverified.'}


def main():
    cfg = json.loads((ROOT / 'project.json').read_text(encoding='utf-8'))
    paths = cfg['header'] + cfg['triggers'] + [cfg['bootstrap']]
    sources = {path: (ROOT / path).read_text(encoding='utf-8') for path in paths}
    api = '\n'.join(path.read_text(encoding='utf-8') for path in (ROOT / 'tools/reference-api').glob('*.j'))
    api_functions = set(re.findall(r'\b(?:native|function)\s+(\w+)\s+takes', api))
    report = inspect(cfg, sources, api_functions)
    (ROOT / 'reports/whole-source-triage.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps({key: value for key, value in report.items()
                      if key not in ('wait_review', 'module_coverage', 'event_getters_without_local_subscription')}, indent=2))
    print('Wait functions recorded:', len(report['wait_review']))
    print('Event getter caller-review candidates:', len(report['event_getters_without_local_subscription']))


if __name__ == '__main__':
    main()
