"""Regenerate test-only AST and conversion artifacts from the immutable original."""
from pathlib import Path
import project as p
def main():
    root=p.ROOT;api=root/'tools/reference-api';output=root/'build/converted'
    output.mkdir(parents=True,exist_ok=True)
    p.tool('transpile',root/'original/map/war3map.j',api/'common.j',api/'Blizzard.j',output)
    p.tool('model',root/'original/map/war3map.j',api/'common.j',api/'Blizzard.j',root/'build/reference-model.json')
if __name__=='__main__':main()
