-- Stateful native test double matching event_model.py. Controlled timers only.
return function(api)
    local ctx, units, ordered, timers, registered = {}, {}, {}, {}, {}
    local currentTimer, filterUnit, active = nil, nil, false
    local observations = {}
    local base = {}
    for name in ("Player GetPlayerId GetHandleId GetUnitTypeId GetUnitX GetUnitY GetRandomInt GetRandomReal I2R R2I I2S R2S S2I StringLength StringCase SubString Sin Cos SquareRoot Atan2 Pow GetTriggeringTrigger GetEnumPlayer GetEnumUnit Condition Filter IsTriggerEnabled TriggerEvaluate GetLocalPlayer GroupAddUnit ForceAddPlayer"):gmatch('%S+') do base[name]=true end
    local function contains(list,value) for _,v in ipairs(list) do if v==value then return true end end return false end
    local function resolve(v)
        if type(v)=='table' then
            if v.global then return _G[v.global] end
            if v.unit then return units[v.unit] end
            if v.player then return api.players[v.player] end
            if v.rawcode then return FourCC(v.rawcode) end
            if v.array then return _G[v.array][resolve(v.index)] end
            if v.field then return resolve(v.of).data[v.field] end
        end
        return v
    end
    local function native(n,a,ret)
        if ctx[n]~=nil then return true,ctx[n] end
        if n=='TimerStart' then
            local d=a[1].data;d.timeout=a[2];d.periodic=a[3];d.callback=a[4];d.active=true
            if not contains(timers,a[1]) then timers[#timers+1]=a[1] end
            return true
        end
        if n=='PauseTimer' or n=='DestroyTimer' then a[1].data.active=false;return true end
        if n=='GetExpiredTimer' then return true,currentTimer end
        if n=='TimerGetElapsed' then return true,a[1].data.elapsed or 0.0 end
        if n:match('^Save') or n:match('^Load') or n:match('^HaveSaved') or n:match('^RemoveSaved') then
            if a[1] and a[1].kind=='hashtable' then
                local d=a[1].data;d.entries=d.entries or {};d.entries[a[2]]=d.entries[a[2]] or {};local t=d.entries[a[2]]
                if n:match('^Save') then t[a[3]]=a[4];return true,ret=='boolean' and true or nil end
                if n:match('^Load') then local v=t[a[3]];if v==nil then v=api.zero(ret) end;return true,v end
                if n:match('^HaveSaved') then return true,t[a[3]]~=nil end
                t[a[3]]=nil;return true
            end
        end
        if n=='FlushChildHashtable' then if a[1].data.entries then a[1].data.entries[a[2]]=nil end;return true end
        if n=='FlushParentHashtable' then a[1].data.entries={};return true end
        if n=='TriggerRegisterAnyUnitEventBJ' or n=='TriggerRegisterPlayerUnitEvent' then
            local d=a[1].data;d.events=d.events or {};d.events[#d.events+1]={event=n:sub(-2)=='BJ' and a[2] or a[3],player=n:sub(-2)~='BJ' and a[2] or nil}
            if not contains(registered,a[1]) then registered[#registered+1]=a[1] end
            return true,ret~='nothing' and api.handle(ret) or nil
        end
        if n=='GetFilterUnit' then return true,filterUnit end
        if n=='GroupEnumUnitsInRange' then
            local members={}
            for _,u in ipairs(ordered) do
                if (u.data.x-a[2])^2+(u.data.y-a[3])^2<=a[4]^2 then
                    filterUnit=u
                    if a[5]==nil or a[5].data.code() then members[#members+1]=u end
                end
            end
            filterUnit=nil;a[1].data.members=members;return true
        end
        if n=='FirstOfGroup' or n=='BlzGroupGetSize' or n=='IsUnitInGroup' or n=='GroupRemoveUnit' or n=='GroupClear' then
            local g=n=='IsUnitInGroup' and a[2] or a[1];g.data.members=g.data.members or {};local m=g.data.members
            if n=='FirstOfGroup' then return true,m[1] end
            if n=='BlzGroupGetSize' then return true,#m end
            if n=='IsUnitInGroup' then return true,contains(m,a[1]) end
            if n=='GroupClear' then g.data.members={};return true end
            for i,v in ipairs(m) do if v==a[2] then table.remove(m,i);break end end
            return true,ret=='boolean' and true or nil
        end
        if n=='GetOwningPlayer' then return true,a[1] and (a[1].data.owner or api.players[0]) or api.players[0] end
        if n=='GetConvertedPlayerId' then return true,a[1] and a[1].id-99 or 1 end
        if n=='GetUnitAbilityLevel' then return true,a[1] and a[1].data.abilities and a[1].data.abilities[a[2]] or 0 end
        if n=='UnitHasBuffBJ' then return true,a[1]~=nil and ((a[1].data.abilities or {})[a[2]] or 0)>0 end
        if n=='UnitHasItemOfTypeBJ' then
            for _,item in ipairs(a[1] and a[1].data.items or {}) do if item.data.typeid==a[2] then return true,true end end
            return true,false
        end
        if n=='GetPlayerTechCountSimple' then return true,(a[2].data.tech or {})[a[1]] or 0 end
        if n=='GetBooleanOr' then return true,a[1] or a[2] end
        if n=='IsUnitType' then
            if not a[1] then return true,false end
            if a[2]==UNIT_TYPE_DEAD then return true,(a[1].data.life or 100.0)<=0 or a[1].data.removed==true end
            return true,contains(a[1].data.types or {},a[2].id)
        end
        if n=='UnitAlive' then return true,a[1]~=nil and (a[1].data.life or 100.0)>0 and not a[1].data.removed end
        if n=='IsUnitEnemy' or n=='IsUnitAlly' then
            local enemy=a[1]~=nil and a[1].data.owner~=a[2]
            if n=='IsUnitAlly' then return true,not enemy end
            return true,enemy
        end
        if n=='IsUnitVisible' then return true,a[1]~=nil and a[1].data.visible~=false end
        if n=='BlzIsUnitInvulnerable' then return true,a[1]~=nil and a[1].data.invulnerable==true end
        if n=='GetWidgetLife' then return true,a[1] and (a[1].data.life or 100.0) or 0.0 end
        if n=='SetWidgetLife' then a[1].data.life=a[2];return true end
        if n=='GetUnitState' then return true,a[1].data[a[2]==UNIT_STATE_MAX_LIFE and 'maxLife' or 'mana'] or 100.0 end
        if n=='BlzGetUnitZ' then return true,a[1] and (a[1].data.z or 0.0) or 0.0 end
        if n=='BlzGetUnitIntegerField' or n=='BlzGetUnitRealField' then
            return true,a[1] and a[1].data.fields and a[1].data.fields[a[2].id] or api.zero(ret)
        end
        if n=='BlzSetUnitIntegerField' or n=='BlzSetUnitRealField' then
            a[1].data.fields=a[1].data.fields or {};a[1].data.fields[a[2].id]=a[3];return true,true
        end
        if n=='BlzGetUnitArmor' then return true,a[1].data.armor or 0.0 end
        if n=='BlzSetUnitArmor' then a[1].data.armor=a[2];return true end
        if n=='UnitInventorySize' then return true,a[1] and #(a[1].data.items or {}) or 0 end
        if n=='UnitItemInSlot' then return true,(a[1].data.items or {})[a[2]+1] end
        if n=='GetItemTypeId' then return true,a[1] and (a[1].data.typeid or 0) or 0 end
        if n=='BlzSetEventDamage' then ctx.GetEventDamage=a[1];return true end
        if n=='BlzSetEventAttackType' or n=='BlzSetEventDamageType' or n=='BlzSetEventWeaponType' then ctx[n:gsub('Set','Get')]=a[1];return true,true end
        if n=='UnitDamageTarget' then if a[2] then a[2].data.life=__jreal((a[2].data.life or 100.0)-a[3]) end;return true,true end
        if n=='AddSpecialEffect' or n=='AddSpecialEffectTarget' then return true,api.handle('effect') end
        if n=='GetTriggerUnit' and active then return true,nil end
        if active and ret~='nothing' and not n:match('^Convert') and not n:match('^Create') and not n:match('^TriggerRegister') then
            assert(base[n],'Unmodelled event return value: '..n)
        end
        return false
    end
    local function run(steps)
        active=true
        for _,s in ipairs(steps) do
            if s.unit then
                local d={typeid=FourCC('hfoo'),x=0.0,y=0.0,z=0.0,life=100.0,maxLife=100.0,owner=api.players[0],abilities={},types={}}
                for k,v in pairs(s.data or {}) do d[k]=resolve(v) end
                local u=api.handle('unit',d);units[s.unit]=u;ordered[#ordered+1]=u
            end
            if s.mutate then for k,v in pairs(s.data) do resolve(s.mutate).data[k]=resolve(v) end end
            if s.ability then local d=resolve(s.of).data;d.abilities=d.abilities or {};d.abilities[resolve(s.ability)]=s.level end
            if s.types then local t={};for _,v in ipairs(s.types) do t[#t+1]=resolve(v).id end;resolve(s.of).data.types=t end
            if s.context then ctx={};for k,v in pairs(s.context) do ctx[k]=resolve(v) end end
            if s.set then if s.index~=nil then _G[s.set][resolve(s.index)]=resolve(s.value) else _G[s.set]=resolve(s.value) end end
            if s.call then
                local args={n=s.argc or #(s.args or {})};for i=1,args.n do args[i]=resolve(s.args[i]) end
                observations[#observations+1]=s.call..'='..api.encode(api.invoke(s.call,args))
            end
            if s.tick then
                for _=1,(s.count or 1) do
                    local copy={table.unpack(timers)}
                    for _,t in ipairs(copy) do
                        if t.data.active and t.data.callback==_G[s.tick] then
                            currentTimer=t;if not t.data.periodic then t.data.active=false end;t.data.callback()
                        end
                    end
                    currentTimer=nil
                end
            end
            if s.observe then
                local v=resolve(s.observe);observations[#observations+1]=s.label..'='..api.encode(v)
                if s.expect~=nil then assert(v==resolve(s.expect),s.label) end
            end
        end
        local out=assert(io.open('build/lua-event.results','w'));out:write(table.concat(observations,'\n'),'\n');out:close()
    end
    return {native=native,run=run}
end
