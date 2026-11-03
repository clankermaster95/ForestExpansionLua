-- Parent-owned game helpers: exact native traces plus explicit group cleanup.
local checks=0
local function check(v,m) assert(v,m);checks=checks+1 end
local function fixture(prefix)
    local env,trace={},{}
    setmetatable(env,{__index=_G});env._G=env
    local function log(name,...) local row={name};for i=1,select('#',...) do row[#row+1]=tostring(select(i,...)) end;trace[#trace+1]=table.concat(row,'|') end
    env.record=log
    env.FourCC=function(raw)return raw end
    env.GetBooleanOr=function(a,b)return a or b end
    env.DoNothing=function()end
    env.GetPlayersAll=function()return'all'end
    env.gg_trg_Ancient_Leaves='leave-trigger'
    env.FE_Roles={finishMatch=function(...)log('result',...)end,ancient=function()return 'ancient'end}
    for _,name in ipairs({'DisableTrigger','DisplayTextToForce','PlayThematicMusicBJ','TriggerSleepAction','DisplayTimedTextToForce','UnitAddAbilityBJ'}) do env[name]=function(...)log(name,...)end end
    env.GetSoldUnit=function()return env.unit end;env.GetLastCreatedUnit=env.GetSoldUnit
    env.GetUnitTypeId=function(unit)return unit end;env.gg_unit_n00B_0266='spellbringer'
    env.udg_Units={};env.udg_Ancients={}
    assert(loadfile(prefix..'src/runtime.lua','t',env))()
    for _,path in ipairs({'src/game/selection.lua','src/game/victory.lua','src/game/fountain.lua'})do assert(loadfile(prefix..path,'t',env))()end
    return env,trace
end
local old,a=fixture('build/refactor-r7/');local new,b=fixture('')
local function same(label)
    check(table.concat(a,'\n')==table.concat(b,'\n'),label)
    for i=#a,1,-1 do a[i]=nil end;for i=#b,1,-1 do b[i]=nil end
end
for _,name in ipairs({'Ignite','Avalanche','Paranoia','Eternity','Dragos','Tremor','Zalxon','Divinity','Pharoah','Nebula','Wispari'})do
    old['Trig_'..name..'_Dies_Actions']();new['Trig_'..name..'_Dies_Actions']();same('result sequence '..name)
end
old.Trig_RandomExpander_Actions();new.Trig_RandomExpander_Actions()
for i=1,18 do check(old.udg_Units[i]==new.udg_Units[i],'random expander index '..i)end
same('pool initialization')
for _,entry in ipairs(new.FE_Factions.ancients)do
    old.unit=entry.raw;new.unit=entry.raw
    old.Trig_Spellbringers_spells_Actions();new.Trig_Spellbringers_spells_Actions();same('spellbringer '..entry.raw)
end
old.unit='unknown';new.unit='unknown';old.Trig_Spellbringers_spells_Actions();new.Trig_Spellbringers_spells_Actions();same('unknown spellbringer')
-- Freeze the original 33-entry pool independently of new metadata, and exercise
-- every draw through the actual random action (including orb/ability ordering).
for draw=1,33 do
    for _,env in ipairs({old,new})do
        env.GetRandomInt=function(lo,hi)check(lo==1 and hi==33,'historical RNG bound');env.record('GetRandomInt',lo,hi,draw);return draw end
        env.GetTriggerUnit=function()return 'selector'end
        env.GetOwningPlayer=function()return 'owner'end
        env.GetTriggerPlayer=function()return 'owner'end
        env.GetPlayerName=function()return 'Test'end
        env.GetUnitLoc=function(unit)env.record('GetUnitLoc',unit,'point');return 'point'end
        env.GetRectCenter=function(r)env.record('GetRectCenter',r);return r end
        env.gg_rct_Tele_out_D='spawn';env.gg_rct_Tele_out_E='facing';env.gg_rct_SpawnDefender='selectors'
        env.CreateNUnitsAtLocFacingLocBJ=function(count,raw,owner,location,facing)
            env.record('CreateNUnitsAtLocFacingLocBJ',count,raw,owner,location,facing);env.unit=raw
        end
        env.RemoveLocation=function(location)env.record('RemoveLocation',location)end
        env.RemoveItem=function(item)env.record('RemoveItem',item)end
        env.KillUnit=function(unit)env.record('KillUnit',unit)end
        env.GetManipulatedItem=function()return 'scroll'end
        env.GetUnitsInRectAll=function(rect)env.record('GetUnitsInRectAll',rect,'end-group');return'end-group'end
        env.GetEnumUnit=function()return env.enumUnit end
        env.RemoveUnit=function(unit)env.record('RemoveUnit',unit)end
        env.ForGroupBJ=function(group,callback)
            check(callback==env.Trig_Random_Ancient_Func041002,'same selector-removal callback')
            env.record('ForGroupBJ',group,'remove-selectors')
            for _,unit in ipairs({'selector-one','selector-two'})do env.enumUnit=unit;callback()end
            env.enumUnit=nil
        end
        env.GetPlayableMapRect=function()return'map'end
        env.CreateItemLoc=function(raw,location)env.record('CreateItemLoc',raw,location)end
        env.GetLastCreatedItem=function()return'orb'end
        env.UnitAddItemSwapped=function(item,unit)env.record('UnitAddItemSwapped',item,unit)end
    end
    old.Trig_Random_Ancient_Actions();new.Trig_Random_Ancient_Actions();same('random ancient '..draw)
    for i=1,33 do check(old.udg_Ancients[i]==new.udg_Ancients[i],'random pool index '..i)end
    check(old.udg_AncientUnit==new.udg_AncientUnit,'random hero')
end
-- Enumerate a mixed group through the real fountain callback, retaining native
-- heal/mana/effect ordering. The one expected trace delta is the owned-group free.
for _,env in ipairs({old,new})do
    env.udg_AncientInCombat=0;env.gg_rct_Fountain='fountain'
    env.UNIT_TYPE_STRUCTURE='structure';env.allocations=0;env.frees=0;env.heals=0;env.effects=0
    env.fountainUnits={
        {id='ally',ally=true,structure=false,life=40,mana=20},
        {id='allied-building',ally=true,structure=true,life=60,mana=30},
        {id='enemy',ally=false,structure=false,life=75,mana=10},
        {id='ancient',ally=true,structure=false,life=95,mana=80},
        {id='zero-life-ally',ally=true,structure=false,life=0,mana=0},
    }
    env.GetUnitsInRectAll=function(rect)
        check(rect=='fountain','fountain rectangle');env.allocations=env.allocations+1
        local group={id='fountain-group-'..env.allocations,units=env.fountainUnits}
        env.record('GetUnitsInRectAll',rect,group.id);return group
    end
    env.ForGroupBJ=function(group,callback)
        check(callback==env.Trig_Fountain_Heal_Func001Func001A,'same fountain callback')
        env.record('ForGroupBJ',group.id,'fountain-heal')
        for _,unit in ipairs(group.units)do env.enumUnit=unit;callback()end
        env.enumUnit=nil
    end
    env.GetEnumUnit=function()return env.enumUnit end
    env.IsUnitType=function(unit,kind)check(kind=='structure','fountain structure filter');return unit.structure end
    env.IsUnitAlly=function(unit,player)check(player=='ancient','fountain current Ancient alliance');return unit.ally end
    env.GetUnitLifePercent=function(unit)return unit.life end
    env.GetUnitManaPercent=function(unit)return unit.mana end
    env.SetUnitLifePercentBJ=function(unit,value)
        env.record('SetUnitLifePercentBJ',unit.id,value);unit.life=math.min(100,value);env.heals=env.heals+1
    end
    env.SetUnitManaPercentBJ=function(unit,value)
        env.record('SetUnitManaPercentBJ',unit.id,value);unit.mana=math.min(100,value)
    end
    env.udg_TSE_RegisterTrigger='timed-effect-register';env.udg_TSEDuration=7.5;env.udg_TSEScale=.45
    env.ConditionalTriggerExecute=function(trigger)
        check(trigger=='timed-effect-register','fountain effect registration')
        env.record('ConditionalTriggerExecute',trigger,env.udg_TSETargetUnit.id,env.udg_TSEAttachPoint,
            env.udg_TSEEffectName,env.udg_TSEDuration,env.udg_TSEScale)
        env.effects=env.effects+1
        -- Model the existing registration reset without replacing the callback.
        env.udg_TSETargetUnit=nil;env.udg_TSEScale=1
    end
    env.DestroyGroup=function(group)
        check(not group.freed,'group freed once');group.freed=true;env.frees=env.frees+1
        env.record('DestroyGroup',group.id)
    end
end
old.Trig_Fountain_Heal_Actions();new.Trig_Fountain_Heal_Actions()
check(old.allocations==1 and new.allocations==1 and old.frees==0 and new.frees==1,'only new fountain releases its group')
check(b[#b]=='DestroyGroup|fountain-group-1','owned group is freed after enumeration')
table.remove(b);same('mixed fountain native sequence excluding documented group free')
for _,env in ipairs({old,new})do
    check(env.heals==3 and env.effects==3,'only allied nonstructures healed; original zero-life behavior retained')
    local units=env.fountainUnits
    check(units[1].life==50 and units[1].mana==25,'ally receives quarter of current life and mana')
    check(units[2].life==60 and units[2].mana==30 and units[3].life==75 and units[3].mana==10,'structures and enemies unchanged')
    check(units[4].life==100 and units[4].mana==100,'native percentage setters clamp full health and mana')
    check(units[5].life==0 and units[5].mana==0,'zero percentages remain zero')
    env.udg_AncientInCombat=1;env.Trig_Fountain_Heal_Actions()
    check(env.udg_AncientInCombat==0 and env.allocations==1 and env.heals==3 and env.effects==3,'combat branch skips enumeration and healing')
end
same('fountain combat branch')
print('Game cleanup passed: '..checks..' comparisons; results, random/native selection order, spellbringer and mixed fountain lifetime/healing')
