-- Load old/new trigger declarations in isolated environments. No native calls,
-- duplicate definitions or captured local state allowed. Preserve the single
-- existing empty feed-identity table initialization explicitly.
local spec=dofile(arg[1])
-- Lua 5.3's strip flag retains each prototype's first/last source line.
-- Normalize only those two debug fields, including nested prototypes. Format
-- follows the pinned runtime's .tools/lua-5.3.6/src/ldump.c DumpFunction.
local function bytecode(fn)
    local data=string.dump(fn,true);assert(data:sub(1,5)=='\27Lua\83')
    local int,size,ins,integer,number=data:byte(13,17)
    local pos,out=1,{}
    local function take(n) out[#out+1]=data:sub(pos,pos+n-1);pos=pos+n end
    local function unsigned(n)
        local value,factor=0,1
        -- These pinned runtimes use native little-endian Windows binaries.
        for i=pos,pos+n-1 do value=value+data:byte(i)*factor;factor=factor*256 end
        take(n);return value
    end
    local function str()
        local n=unsigned(1);if n==255 then n=unsigned(size) end
        if n>0 then take(n-1) end
    end
    local function proto()
        assert(unsigned(1)==0,'Expected stripped source')
        out[#out+1]=string.rep('\0',2*int);pos=pos+2*int
        take(3);local instructions=unsigned(int);take(instructions*ins)
        local constants=unsigned(int)
        for _=1,constants do
            local kind=unsigned(1)
            if kind==1 then take(1)
            elseif kind==3 then take(number)
            elseif kind==19 then take(integer)
            elseif kind==4 or kind==20 then str()
            else assert(kind==0,'Unknown constant type') end
        end
        local upvalues=unsigned(int);take(upvalues*2)
        local children=unsigned(int);for _=1,children do proto() end
        for _=1,3 do assert(unsigned(int)==0,'Unexpected unstripped debug data') end
    end
    take(17+integer+number+1);proto();assert(pos==#data+1,'Incomplete bytecode comparison')
    return table.concat(out)
end
local fixture=assert(load('return function() return 7 end'))()
assert(bytecode(fixture)==bytecode(assert(load('\n\nreturn function() return 7 end'))()))
assert(bytecode(fixture)~=bytecode(assert(load('return function() return 8 end'))()))
local function declarations(paths)
    local definitions={}
    local env=setmetatable({}, {
        __index=function(_,key) error('Unexpected top-level dependency: '..key) end,
        __newindex=function(_,key,value)
            if key=='FE_FeedNames' then
                assert(type(value)=='table' and next(value)==nil,'Feed identity must start empty')
            else assert(type(value)=='function','Top-level side effect: '..key) end
            assert(not definitions[key],'Duplicate function: '..key)
            definitions[key]=value
        end
    })
    for _,path in ipairs(paths) do assert(loadfile(path,'t',env))() end
    return definitions
end
local before,after=declarations(spec.before),declarations(spec.after)
local count=0
for name,fn in pairs(before) do
    assert(after[name],'Missing function: '..name)
    if name=='FE_FeedNames' then
        assert(next(after[name])==nil,'Changed initial feed identity')
    else
    assert(bytecode(fn)==bytecode(after[name]),'Changed bytecode: '..name)
    local index=1
    while true do
        local key,value=debug.getupvalue(after[name],index)
        if not key then break end
        assert(key=='_ENV','Captured state changed by module consolidation: '..name..'/'..key)
        index=index+1
    end
    count=count+1
    end
    after[name]=nil
end
assert(next(after)==nil,'Unexpected added function')
print('Consolidation passed: '..count..' identical function bytecodes; no native calls or captured local state; initial feed table preserved')
