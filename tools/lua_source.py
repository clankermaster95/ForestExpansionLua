"""Lexical Lua source spans for audits; strings/comments never become fake code.

This deliberately does not evaluate Lua or claim semantic/desync proof. It
recognizes function and block boundaries, including local/anonymous callbacks.
The compiler remains the syntax authority.
"""
from dataclasses import dataclass
import re


@dataclass(frozen=True)
class Token:
    text: str
    start: int
    end: int
    kind: str


def tokens(source):
    result = []
    cursor = 0
    while cursor < len(source):
        start = cursor
        char = source[cursor]
        if char.isspace():
            cursor += 1
            continue
        comment = source.startswith('--', cursor)
        bracket = re.match(r'\[(=*)\[', source[cursor + (2 if comment else 0):])
        if bracket:
            end = source.find(']' + bracket[1] + ']', cursor + (2 if comment else 0) + bracket.end())
            if end < 0:
                raise ValueError('Unterminated Lua long string/comment')
            cursor = end + 2 + len(bracket[1])
            if not comment:
                result.append(Token(source[start:cursor], start, cursor, 'string'))
        elif comment:
            end = source.find('\n', cursor)
            cursor = len(source) if end < 0 else end
        elif char in "\"'":
            cursor += 1
            while cursor < len(source):
                if source[cursor] == '\\':
                    cursor += 2
                elif source[cursor] == char:
                    cursor += 1
                    break
                else:
                    cursor += 1
            else:
                raise ValueError('Unterminated Lua quoted string')
            result.append(Token(source[start:cursor], start, cursor, 'string'))
        elif char.isalpha() or char == '_':
            cursor += 1
            while cursor < len(source) and (source[cursor].isalnum() or source[cursor] == '_'):
                cursor += 1
            result.append(Token(source[start:cursor], start, cursor, 'word'))
        else:
            # Individual punctuation/numeric tokens suffice for balanced spans.
            cursor += 1
            result.append(Token(char, start, cursor, 'symbol'))
    return result


def functions(source):
    stream = tokens(source)
    blocks, result = [], []
    for i, token in enumerate(stream):
        word = token.text if token.kind == 'word' else None
        if word == 'function':
            j = i + 1
            while stream[j].text != '(':
                j += 1
            name = ''.join(t.text for t in stream[i+1:j]) or None
            parent = next((value for kind, value in reversed(blocks) if kind == 'function'), None)
            entry = {'name': name, 'start': token.start, 'token_start': i,
                     'line': source.count('\n', 0, token.start) + 1, 'parent': parent,
                     'local': i > 0 and stream[i-1].text == 'local'}
            blocks.append(('function', entry)); result.append(entry)
        elif word in ('if', 'do', 'repeat'):
            blocks.append((word, None))
        elif word == 'end':
            if not blocks or blocks[-1][0] == 'repeat':
                raise ValueError('Unbalanced Lua end')
            kind, entry = blocks.pop()
            if kind == 'function':
                entry['end'] = token.end; entry['token_end'] = i
        elif word == 'until':
            if not blocks or blocks.pop()[0] != 'repeat':
                raise ValueError('Unbalanced Lua until')
    if blocks:
        raise ValueError('Unclosed Lua block')
    return result


def code_only(source):
    """Retain code characters/offsets, blanking comments and all string contents."""
    output = ['\n' if char == '\n' else ' ' for char in source]
    for token in tokens(source):
        if token.kind != 'string':
            output[token.start:token.end] = source[token.start:token.end]
    return ''.join(output)
