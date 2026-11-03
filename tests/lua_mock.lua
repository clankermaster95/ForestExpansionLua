-- Deterministic engine double shared in behavior with jass_model.py.
local metadata = dofile(arg[1])
local traces, reverse, players, enums = {}, {}, {}, {}
local nextId, tracking, currentTrigger, currentEnum = 1048576, false, nil, nil
local extension
local function handle(kind, data)
    nextId = nextId + 1
    return {kind=kind, id=nextId, data=data or {}}
end
local function hex(s) return (s:gsub('.', function(c) return string.format('%02x', c:byte()) end)) end
local function encode(v)
    if v == nil then return 'nil' end
    if type(v) == 'boolean' then return tostring(v) end
    if type(v) == 'function' then return 'c:' .. assert(reverse[v], 'unnamed callback') end
    if type(v) == 'table' then return 'h:' .. v.kind .. ':' .. v.id end
    if type(v) == 'number' then
        if math.type(v) == 'integer' then return tostring(v) end
        return 'f:' .. hex(string.pack('>f', v))
    end
    return 's:' .. hex(v)
end
local function zero(t)
    if t == 'integer' then return 0 elseif t == 'real' then return 0.0 elseif t == 'boolean' then return false end
end
local function conditions(t)
    for _, h in ipairs(t.data.conditions or {}) do if not h.data.code() then return false end end
    return true
end
local function actions(t)
    local previous = currentTrigger; currentTrigger = t
    for _, code in ipairs(t.data.actions or {}) do
        local co = coroutine.create(code)
        local ok, message = coroutine.resume(co)
        if not ok then error(message) end
        if coroutine.status(co) == 'suspended' then break end
    end
    currentTrigger = previous
end
local function native(n, a, ret)
    if extension then
        local handled, value = extension.native(n, a, ret)
        if handled then return value end
    end
    if n:sub(1,7) == 'Convert' then
        local key = ret .. ':' .. a[1]
        if not enums[key] then enums[key] = {kind=ret,id=a[1],data={}} end
        return enums[key]
    end
    if n == 'Player' then
        if not players[a[1]] then players[a[1]] = {kind='player',id=100+a[1],data={}} end
        return players[a[1]]
    end
    if n == 'GetPlayerId' then return a[1] and a[1].id-100 or 0 end
    if n == 'GetHandleId' then return a[1] and a[1].id or 0 end
    if n == 'GetPlayerNeutralAggressive' then return 24 end
    if n == 'GetPlayerNeutralPassive' then return 27 end
    if n == 'GetBJMaxPlayers' then return 24 end
    if n == 'GetBJMaxPlayerSlots' then return 28 end
    if n == 'GetLocalPlayer' then return native('Player',{0},'player') end
    if n == 'GetTriggeringTrigger' then return currentTrigger end
    if n == 'GetEnumPlayer' or n == 'GetEnumUnit' then return currentEnum end
    if n == 'Condition' or n == 'Filter' then return handle(ret,{code=a[1]}) end
    if n == 'TriggerAddAction' or n == 'TriggerAddCondition' then
        local key = n == 'TriggerAddAction' and 'actions' or 'conditions'
        a[1].data[key] = a[1].data[key] or {}; table.insert(a[1].data[key],a[2]); return handle(ret)
    end
    if n == 'DisableTrigger' then a[1].data.disabled=true; return end
    if n == 'EnableTrigger' then a[1].data.disabled=false; return end
    if n == 'IsTriggerEnabled' then return a[1] ~= nil and not a[1].data.disabled end
    if n == 'TriggerEvaluate' then return conditions(a[1]) end
    if n == 'TriggerExecute' or n == 'ConditionalTriggerExecute' or n == 'TriggerExecuteBJ' then
        if a[1] == nil then return end
        if n == 'TriggerExecute' or (not a[1].data.disabled and conditions(a[1])) then actions(a[1]) end
        return
    end
    if n == 'ExecuteFunc' then return assert(_G[a[1]],a[1])() end
    if n == 'TriggerSleepAction' or n == 'PolledWait' then coroutine.yield(); return end
    if n == 'GroupAddUnit' or n == 'ForceAddPlayer' then
        a[1].data.members=a[1].data.members or {}; table.insert(a[1].data.members,a[2]);
        if ret=='boolean' then return true end; return
    end
    if n == 'ForForce' or n == 'ForGroup' or n == 'ForGroupBJ' then
        local previous=currentEnum
        for _,member in ipairs(a[1] and a[1].data.members or {}) do currentEnum=member; a[2]() end
        currentEnum=previous; return
    end
    if n == 'CreateUnit' or n == 'BlzCreateUnitWithSkin' or n == 'CreateUnitByName' then return handle('unit',{typeid=a[2],x=a[3],y=a[4]}) end
    if n == 'GetUnitTypeId' then return a[1] and a[1].data.typeid or 0 end
    if n == 'GetUnitX' or n == 'GetUnitY' then return __jreal(a[1] and a[1].data[n:sub(-1)=='X' and 'x' or 'y'] or 0) end
    if n == 'GetWidgetLife' or n == 'GetUnitLifePercent' then return a[1] and 100.0 or 0.0 end
    if n == 'UnitAlive' then return a[1] ~= nil end
    if n == 'GetRandomInt' or n == 'GetRandomReal' then return a[1] end
    if n == 'I2R' then return __jreal(a[1]) end
    if n == 'R2I' then return __jint(a[1] < 0 and math.ceil(a[1]) or math.floor(a[1])) end
    if n == 'I2S' then return tostring(a[1]) end
    if n == 'R2S' then return string.format('%.3f',a[1]) end
    if n == 'StringLength' then return #(a[1] or '') end
    if n == 'StringCase' then return a[2] and (a[1] or ''):upper() or (a[1] or ''):lower() end
    if n == 'S2I' then return __jint(tonumber((a[1] or ''):match('^%s*([+-]?%d+)')) or 0) end
    if n == 'SubString' then return (a[1] or ''):sub(a[2]+1,a[3]) end
    if n == 'Sin' then return __jreal(math.sin(a[1])) end
    if n == 'Cos' then return __jreal(math.cos(a[1])) end
    if n == 'SquareRoot' then return __jreal(math.sqrt(a[1])) end
    if n == 'Atan2' then return __jreal(math.atan(a[1],a[2])) end
    if n == 'Pow' then return __jreal(a[1]^a[2]) end
    if n:sub(1,6)=='Create' or n=='InitHashtable' or n:sub(1,15)=='TriggerRegister' or n=='GetWorldBounds' or n=='GetPlayableMapRect' then
        if ret~='nothing' and ret~='integer' and ret~='real' and ret~='boolean' and ret~='string' then return handle(ret) end
    end
    return zero(ret)
end
dofile('src/runtime.lua')
function FourCC(s) return __jint(string.unpack('>I4', s)) end
if arg[5] then
    extension=dofile('tests/event_engine.lua')({handle=handle,zero=zero,encode=encode,players=players,
        invoke=function(name,args) return _G[name](table.unpack(args,1,args.n or #args)) end,
        actions=actions,conditions=conditions})
end
for name,sig in pairs(metadata.functions) do
    _G[name] = function(...)
        local a=table.pack(...)
        for i,t in ipairs(sig.Types) do if t=='real' then a[i]=__jreal(a[i]) end end
        if tracking then
            local line={name}
            for i=1,#sig.Types do line[#line+1]=encode(a[i]) end
            traces[#traces+1]=table.concat(line,'|') .. (#sig.Types==0 and '|' or '')
        end
        return native(name,a,sig.Returns)
    end
end
dofile('build/converted/api_globals.lua')
tracking=true
dofile(arg[2])
for name,value in pairs(_G) do if type(value)=='function' then reverse[value]=name end end
config(); main()
local function globals_snapshot(path)
    local lines={}
    for name,kind in pairs(metadata.globals) do
        local value=_G[name]
        if type(value)=='table' and rawget(value,'kind')==nil then
            for key,item in pairs(value) do
                if item~=zero(kind) then lines[#lines+1]='array|'..name..'|'..tostring(key)..'|'..encode(item) end
            end
        else lines[#lines+1]='global|'..name..'|'..encode(value) end
    end
    table.sort(lines)
    local f=assert(io.open(path,'w'));f:write(table.concat(lines,'\n'),'\n');f:close()
end
if extension then
    globals_snapshot('build/lua-startup.state')
    extension.run(dofile(arg[5]))
    globals_snapshot('build/lua-event.state')
end
if arg[4] and arg[4]~='' then
    local results={}
    for _,case in ipairs(dofile(arg[4])) do
        local args=case.args
        for i,t in ipairs(metadata.functions[case.name].Types) do if t=='real' then args[i]=__jreal(args[i]) end end
        results[#results+1]=encode(_G[case.name](table.unpack(args,1,#metadata.functions[case.name].Types)))
    end
    local out=assert(io.open('build/lua-behavior.results','w'));out:write(table.concat(results,'\n'),'\n');out:close()
end
local f=assert(io.open(arg[3],'w')); f:write(table.concat(traces,'\n'),'\n'); f:close()
print('Lua startup native/BJ calls: '..#traces)
