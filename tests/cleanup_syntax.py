"""Compile/run edge cases for the narrow generated-Lua normalizer."""
from pathlib import Path
import subprocess,sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'tools'))
from lua_cleanup import normalize


def main():
    samples=[
        'function sample()\n    return [[a\n\n\nb]]\nend',
        'function sample()\n    return [=[a\n-- Original JASS function: text to preserve\n\n\nb]=]\nend',
        'function sample()\n    do return (("end do return -- function")) end\nend',
        'function sample()\n    do return ((many())) end\nend',
        'function sample()\n    do return pack(((many()))) end\nend',
        'function sample()\n    if ((not (value))) then\n        do return false end\n    end\n    do return true end\nend',
        'function sample()\n    if ((not ((value == false)))) then\n        do return false end\n    end\n    do return true end\nend',
        'function sample()\n    if ((not ((value == false or other)))) then\n        do return false end\n    end\n    do return true end\nend',
        'function sample()\n    if ((value)) then\n        do return 4 end\n    else\n        DoNothing()\n    end\n    do return 5 end\nend',
        'function sample()\n    return not not value == false\nend',
        'function sample()\n    if (not value == false) then\n        return false\n    end\n    return true\nend',
        'function sample()\n    if (not many() == false) then\n        return false\n    end\n    return true\nend',
        'function sample()\n    return not not value or other\nend',
    ]
    quote=lambda text:'[====['+text+']====]'
    code='''local checks=0
local function run(source,value,other)
  local count=0
  local env={value=value,other=other,DoNothing=function()end}
  env.many=function()count=count+1;return 7,8,9 end
  env.pack=function(...)return select('#',...),... end
  assert(load(source,'sample','t',env))()
  local values=table.pack(env.sample())
  return values,count
end
local values={false,true,0,1,-1,'',{},'string'}
values[9]=nil
'''
    for sample in samples:
        normalized=normalize(sample)
        code+='local old,new='+quote(sample)+','+quote(normalized)+'\n'
        code+='''for i=1,9 do for j=1,9 do
  local a,ac=run(old,values[i],values[j]);local b,bc=run(new,values[i],values[j])
  assert(a.n==b.n and ac==bc,'return arity or evaluation count changed')
  for k=1,a.n do assert(a[k]==b[k] and type(a[k])==type(b[k]),'value/type changed') end
  checks=checks+1
end end
'''
    code+="print('Mechanical syntax checks passed: '..checks..' return/boolean/evaluation cases')\n"
    target=ROOT/'build/cleanup-syntax-tests.lua';target.write_text(code,encoding='utf-8')
    results=[]
    for kind in ('lua-5.3.6','lua-5.3.6-32'):
        result=subprocess.run([str(ROOT/'.tools'/kind/'src/lua'),str(target)],cwd=ROOT,capture_output=True,text=True,check=True)
        print(result.stdout.strip());results.append({'runtime':kind,'result':result.stdout.strip()})
    return results


if __name__=='__main__':main()
