"""Narrow, reproducible normalization of the generated preservation-port syntax.

Not a general Lua formatter. Each rule retains expression evaluation order and
numeric boundaries. Call parentheses and single-result return parentheses stay.
Function removal is a separate, explicitly recorded reference audit.
"""
import re
from lua_source import tokens, code_only, functions


def edits(source, changes):
    for start,end,text in sorted(changes,reverse=True):
        source=source[:start]+text+source[end:]
    return source


def replace_outside_strings(source, pattern, replacement):
    strings = [token for token in tokens(source) if token.kind == 'string']
    changes = []
    for match in re.finditer(pattern, source):
        if any(token.start < match.end() and token.end > match.start() for token in strings):
            continue
        changes.append((match.start(), match.end(), replacement))
    return edits(source, changes)


def redundant_parentheses(source):
    stream=tokens(source);stack=[];pairs={}
    for index,token in enumerate(stream):
        if token.kind=='string':continue
        if token.text=='(':stack.append(index)
        elif token.text==')':
            opening=stack.pop();pairs[opening]=index
    changes=[]
    keywords={'if','while','until','return','not','and','or','then','else','do'}
    for opening,closing in pairs.items():
        if opening+1 not in pairs or pairs[opening+1]!=closing-1:continue
        previous=stream[opening-1] if opening else None
        # An opening call parenthesis is not an expression grouping: f((g()))
        # must retain the inner grouping that limits g to a single result.
        if previous and (previous.kind=='string' or previous.text in (')',']','}') or
                         previous.kind=='word' and previous.text not in keywords):continue
        changes.extend([(stream[opening].start,stream[opening].end,''),
                        (stream[closing].start,stream[closing].end,'')])
    return edits(source,changes)


def fully_grouped(expression):
    stream=tokens(expression)
    if not stream or stream[0].text!='(' or stream[-1].text!=')':return False
    depth=0
    for i,token in enumerate(stream):
        if token.kind=='string':continue
        if token.text=='(':depth+=1
        elif token.text==')':depth-=1
        if depth==0 and i<len(stream)-1:return False
    return depth==0


def atomic(expression):
    stream=tokens(expression)
    if not stream or stream[0].kind!='word':return False
    cursor=1
    while cursor+1<len(stream) and stream[cursor].text=='.' and stream[cursor+1].kind=='word':cursor+=2
    if cursor==len(stream):return True
    return stream[cursor].text=='(' and fully_grouped(expression[stream[cursor].start:])


def normalize(source):
    source=replace_outside_strings(source,r'(?m)^-- Original JASS function: [^\n]+\n','')
    source=redundant_parentheses(source)
    code=code_only(source)
    changes=[]
    for match in re.finditer(r'(?m)^([ \t]*)do[ \t]+return(?:[ \t]+[^\n]*?)?[ \t]+end[ \t]*$',code):
        line=source[match.start():match.end()]
        changes.append((match.start(),match.end(),re.sub(r'\bdo\s+return\b','return',line, count=1).rsplit('end',1)[0].rstrip()))
    source=edits(source,changes)
    # DoNothing is the original empty Blizzard helper, not an arbitrary callback.
    code=code_only(source)
    changes=[(m.start(),m.end(),'') for m in re.finditer(r'(?m)^[ \t]*DoNothing\(\)[ \t]*\n',code)]
    source=edits(source,changes)
    code=code_only(source)
    changes=[(m.start(),m.end(),m[1]) for m in re.finditer(r'(?m)^([ \t]*)else[ \t]*\n[ \t]*(?=end\b)',code)]
    source=edits(source,changes)
    changes=[]
    for entry in functions(source):
        if entry['parent'] is not None or not entry['name']:continue
        block=source[entry['start']:entry['end']]
        match=re.fullmatch(r'(function [^\n]+\n)    if \(not (.+)\) then\n        return false\n    end\n    return true\nend',block)
        if match:
            predicate=match[2]
            # `not a == b` means `(not a) == b`, not `not (a == b)`.
            # Only recognize a grouped operand or one atomic variable/getter.
            if not fully_grouped(predicate) and not atomic(predicate):continue
            # Boolean normalization retains false vs nil and true vs truthy
            # values even for getters or callbacks with non-boolean results.
            changes.append((entry['start'],entry['end'],match[1]+'    return not not ('+predicate+')\nend'))
    source=edits(source,changes)
    changes=[]
    for match in re.finditer(r'(?m)^([ \t]*)return not not ([^\n]+)$',code_only(source)):
        predicate=source[match.start(2):match.end(2)].strip()
        if atomic(predicate):
            changes.append((match.start(),match.end(),match[1]+'return not not ('+predicate+')'))
    source=edits(source,changes)
    # A single relational expression already has a boolean result. Do not apply
    # this to `a == b or value`, since Lua's and/or can return non-booleans.
    changes=[]
    for match in re.finditer(r'(?m)^([ \t]*)return not not ([^\n]+)$',code_only(source)):
        predicate=source[match.start(2):match.end(2)].strip()
        if not fully_grouped(predicate):continue
        while predicate.startswith('(') and predicate.endswith(')'):
            stream=tokens(predicate);depth=0;closes_at_end=True
            for i,token in enumerate(stream):
                if token.kind=='string':continue
                if token.text=='(':depth+=1
                elif token.text==')':depth-=1
                if depth==0 and i<len(stream)-1:closes_at_end=False;break
            if not closes_at_end:break
            predicate=predicate[1:-1].strip()
        depth=0;outer=[]
        for token in tokens(predicate):
            if token.kind=='string':continue
            if token.text in ('(','[','{'):depth+=1
            elif token.text in (')',']','}'):depth-=1
            elif depth==0:outer.append(token.text)
        text=''.join(outer)
        if not any(word in outer for word in ('and','or')) and re.search(r'==|~=|(?<!<)<(?!<)|(?<!>)>(?!>)',text):
            changes.append((match.start(),match.end(),match[1]+'return '+predicate))
    source=edits(source,changes)
    return replace_outside_strings(source,r'\n{3,}','\n\n')
