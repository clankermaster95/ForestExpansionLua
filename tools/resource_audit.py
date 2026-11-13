"""Reject temporary group/location allocations hidden inside call arguments.

This is a narrow ownership guard, not an escape analysis or a leak/desync proof.
An explicitly captured handle still needs review and repeated-use tests.
"""
from lua_source import tokens, functions

ALLOCATORS = {
    'Location', 'GetUnitLoc', 'GetSpellTargetLoc', 'GetRectCenter',
    'GetDestructableLoc', 'GetItemLoc', 'OffsetLocation', 'PolarProjectionBJ',
    'CreateGroup', 'GetUnitsInRectAll', 'GetUnitsInRectMatching',
    'GetUnitsInRectOfPlayer', 'GetUnitsInRangeOfLocAll',
    'GetUnitsInRangeOfLocMatching', 'GetUnitsOfPlayerAll',
    'GetUnitsOfPlayerAndTypeId', 'GetUnitsOfPlayerMatching', 'GetRandomSubGroup',
}

def inspect(source, path):
    stream=tokens(source);spans=functions(source);stack=[];sites=[]
    for i, token in enumerate(stream):
        if token.kind=='string': continue
        if token.text=='(':
            previous=stream[i-1] if i else None
            call=previous.text if previous and previous.kind=='word' and previous.text not in {'if','while','until','not','and','or'} else None
            declaration=i>=2 and stream[i-2].text=='function'
            if call in ALLOCATORS and not declaration:
                line=source.count('\n',0,previous.start)+1
                # A callback body has its own lifetime scope. The outer call
                # receiving that callback does not consume its local handles.
                scope=max((f['start'] for f in spans if f['start']<=previous.start<f['end']),default=-1)
                owners=[owner for owner,start in stack if owner and start>scope]
                assert not owners, f'{path}:{line}: capture {call} before passing it to {owners[-1]}'
                sites.append({'line':line,'allocator':call})
            stack.append((None if declaration else call,token.start))
        elif token.text==')':
            assert stack, f'Unbalanced parentheses: {path}'
            stack.pop()
    assert not stack, f'Unbalanced parentheses: {path}'
    return sites

def regression_checks():
    for source in (
        'ForGroupBJ(GetUnitsOfPlayerAll(p), action)',
        'CreateNUnitsAtLoc(1, id, p, GetUnitLoc(u), 0)',
        'return IsUnitInGroup(u, GetUnitsInRectOfPlayer(r,p))',
        'IssuePointOrderLocBJ(u,"attack",OffsetLocation(point,0,0))',
        'forUnits(p,function(u) use(GetUnitLoc(u)) end)',
    ):
        try: inspect(source,'negative-case')
        except AssertionError: pass
        else: raise AssertionError('Inline native allocation escaped the guard: '+source)
    assert len(inspect('local g=CreateGroup(); ForGroupBJ(g, action); DestroyGroup(g)','owned'))==1
    assert not inspect('-- GetUnitLoc(u)\nlocal text="f(GetUnitLoc(u))"','non-code')
    assert len(inspect('forUnits(p,function(u) local point=GetUnitLoc(u); use(point); RemoveLocation(point) end)','owned-callback'))==1
    return 8
