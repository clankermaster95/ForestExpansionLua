-- races / bounty_hunter
-- Related gameplay callbacks; original initialization order is in src/initialization.lua.

-- BEGIN FOREST SECTION 29 Snipe_Shot
-- Original JASS function: SnipeShot_IsAlive (line 6312)
function SnipeShot_IsAlive(u)
    do return (((u ~= nil) and (GetWidgetLife(u) > __jreal(0.405))) and (not IsUnitType(u, UNIT_TYPE_DEAD))) end
end

-- Original JASS function: SnipeShot_IsValidTarget (line 6316)
function SnipeShot_IsValidTarget(u, p)
    do return ((SnipeShot_IsAlive(u) and IsUnitEnemy(u, p)) and (not IsUnitType(u, UNIT_TYPE_FLYING))) end
end

-- Original JASS function: SnipeShot_StartCooldown (line 6320)
function SnipeShot_StartCooldown(caster)
    if (caster ~= nil) then
        BlzStartUnitAbilityCooldown(caster, SNIPESHOT_ABILITY_ID, SNIPESHOT_COOLDOWN)
    end
end

-- Original JASS function: SnipeShot_GetHitTarget (line 6326)
function SnipeShot_GetHitTarget(x, y, p)
    local u = nil
    local best = nil
    local dx = 0.0
    local dy = 0.0
    local d2 = 0.0
    local bestD2 = __jreal(999999999.00)
    GroupEnumUnitsInRange(SNIPESHOT_Group, x, y, SNIPESHOT_COLLISION, nil)
    while true do
        u = FirstOfGroup(SNIPESHOT_Group)
        if (u == nil) then break end
        GroupRemoveUnit(SNIPESHOT_Group, u)
        if SnipeShot_IsValidTarget(u, p) then
            dx = __jreal(GetUnitX(u) - x)
            dy = __jreal(GetUnitY(u) - y)
            d2 = __jreal(__jreal(dx * dx) + __jreal(dy * dy))
            if (d2 < bestD2) then
                bestD2 = d2
                best = u
            end
        end
    end
    u = nil
    do return best end
end

-- Original JASS function: SnipeShot_StunTarget (line 6357)
function SnipeShot_StunTarget(p, x, y, target)
    local dummy = CreateUnit(p, SNIPESHOT_DUMMY_ID, x, y, __jreal(0.00))
    UnitAddAbility(dummy, SNIPESHOT_STUN_ABILITY_ID)
    SetUnitAbilityLevel(dummy, SNIPESHOT_STUN_ABILITY_ID, 1)
    IssueTargetOrder(dummy, SNIPESHOT_STUN_ORDER, target)
    UnitApplyTimedLife(dummy, FourCC("BTLF"), __jreal(1.00))
    dummy = nil
end

-- Original JASS function: SnipeShot_EndMissile (line 6368)
function SnipeShot_EndMissile(t)
    local id = GetHandleId(t)
    local fx = LoadEffectHandle(SNIPESHOT_Hash, id, 2)
    if (fx ~= nil) then
        DestroyEffect(fx)
    end
    FlushChildHashtable(SNIPESHOT_Hash, id)
    PauseTimer(t)
    DestroyTimer(t)
    fx = nil
end

-- Original JASS function: SnipeShot_MissileLoop (line 6383)
function SnipeShot_MissileLoop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local caster = LoadUnitHandle(SNIPESHOT_Hash, id, 0)
    local p = LoadPlayerHandle(SNIPESHOT_Hash, id, 1)
    local fx = LoadEffectHandle(SNIPESHOT_Hash, id, 2)
    local x = LoadReal(SNIPESHOT_Hash, id, 3)
    local y = LoadReal(SNIPESHOT_Hash, id, 4)
    local dx = LoadReal(SNIPESHOT_Hash, id, 5)
    local dy = LoadReal(SNIPESHOT_Hash, id, 6)
    local travelled = LoadReal(SNIPESHOT_Hash, id, 7)
    local maxDist = LoadReal(SNIPESHOT_Hash, id, 8)
    local step = __jreal(SNIPESHOT_SPEED * SNIPESHOT_PERIOD)
    local remaining = __jreal(maxDist - travelled)
    local hit = nil
    local damage = 0.0
    if (((caster == nil) or (not SnipeShot_IsAlive(caster))) or (remaining <= __jreal(0.00))) then
        SnipeShot_EndMissile(t)
    else
        if (step > remaining) then
            step = remaining
        end
        x = __jreal(x + __jreal(dx * step))
        y = __jreal(y + __jreal(dy * step))
        travelled = __jreal(travelled + step)
        BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)
        hit = SnipeShot_GetHitTarget(x, y, p)
        if (hit ~= nil) then
            damage = __jreal(__jreal(SNIPESHOT_DAMAGE_PER_STEP * travelled) / SNIPESHOT_DAMAGE_DISTANCE_STEP)
            UnitDamageTarget(caster, hit, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            SnipeShot_StunTarget(p, x, y, hit)
            SnipeShot_EndMissile(t)
        elseif (travelled >= maxDist) then
            SnipeShot_EndMissile(t)
        else
            SaveReal(SNIPESHOT_Hash, id, 3, x)
            SaveReal(SNIPESHOT_Hash, id, 4, y)
            SaveReal(SNIPESHOT_Hash, id, 7, travelled)
        end
    end
    hit = nil
    caster = nil
    p = nil
    fx = nil
    t = nil
end

-- Original JASS function: SnipeShot_StartMissile (line 6436)
function SnipeShot_StartMissile(caster, tx, ty)
    local t = CreateTimer()
    local id = GetHandleId(t)
    local p = GetOwningPlayer(caster)
    local x = GetUnitX(caster)
    local y = GetUnitY(caster)
    local dx = __jreal(tx - x)
    local dy = __jreal(ty - y)
    local dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
    local angle = 0.0
    local fx = nil
    if (dist <= __jreal(1.00)) then
        angle = __jreal(GetUnitFacing(caster) * bj_DEGTORAD)
        dx = Cos(angle)
        dy = Sin(angle)
    else
        dx = __jreal(dx / dist)
        dy = __jreal(dy / dist)
    end
    fx = AddSpecialEffect(SNIPESHOT_MISSILE_MODEL, x, y)
    BlzSetSpecialEffectPosition(fx, x, y, SNIPESHOT_MISSILE_HEIGHT)
    BlzSetSpecialEffectYaw(fx, Atan2(dy, dx))
    SaveUnitHandle(SNIPESHOT_Hash, id, 0, caster)
    SavePlayerHandle(SNIPESHOT_Hash, id, 1, p)
    SaveEffectHandle(SNIPESHOT_Hash, id, 2, fx)
    SaveReal(SNIPESHOT_Hash, id, 3, x)
    SaveReal(SNIPESHOT_Hash, id, 4, y)
    SaveReal(SNIPESHOT_Hash, id, 5, dx)
    SaveReal(SNIPESHOT_Hash, id, 6, dy)
    SaveReal(SNIPESHOT_Hash, id, 7, __jreal(0.00))
    SaveReal(SNIPESHOT_Hash, id, 8, SNIPESHOT_MAX_RANGE)
    TimerStart(t, SNIPESHOT_PERIOD, true, SnipeShot_MissileLoop)
    fx = nil
    p = nil
    t = nil
end

-- Original JASS function: SnipeShot_OnChannel (line 6478)
function SnipeShot_OnChannel()
    local caster = GetTriggerUnit()
    local casterId = 0
    if (GetSpellAbilityId() == SNIPESHOT_ABILITY_ID) then
        casterId = GetHandleId(caster)
        SaveBoolean(SNIPESHOT_Hash, casterId, 100, true)
        SaveReal(SNIPESHOT_Hash, casterId, 101, GetSpellTargetX())
        SaveReal(SNIPESHOT_Hash, casterId, 102, GetSpellTargetY())
    end
    caster = nil
end

-- Original JASS function: SnipeShot_OnFinish (line 6493)
function SnipeShot_OnFinish()
    local caster = GetTriggerUnit()
    local casterId = 0
    local tx = 0.0
    local ty = 0.0
    if (GetSpellAbilityId() == SNIPESHOT_ABILITY_ID) then
        casterId = GetHandleId(caster)
        if (LoadBoolean(SNIPESHOT_Hash, casterId, 100) and SnipeShot_IsAlive(caster)) then
            tx = LoadReal(SNIPESHOT_Hash, casterId, 101)
            ty = LoadReal(SNIPESHOT_Hash, casterId, 102)
            FlushChildHashtable(SNIPESHOT_Hash, casterId)
            SnipeShot_StartCooldown(caster)
            SetUnitAnimation(caster, "attack")
            SnipeShot_StartMissile(caster, tx, ty)
        end
    end
    caster = nil
end

-- Original JASS function: InitTrig_Snipe_Shot (line 6516)
function InitTrig_Snipe_Shot()
    local channelTrig = CreateTrigger()
    local finishTrig = CreateTrigger()
    local i = 0
    while true do
        if (i >= bj_MAX_PLAYER_SLOTS) then break end
        TriggerRegisterPlayerUnitEvent(channelTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_CHANNEL, nil)
        TriggerRegisterPlayerUnitEvent(finishTrig, Player(i), EVENT_PLAYER_UNIT_SPELL_FINISH, nil)
        i = __jint(i + 1)
    end
    TriggerAddAction(channelTrig, SnipeShot_OnChannel)
    TriggerAddAction(finishTrig, SnipeShot_OnFinish)
    channelTrig = nil
    finishTrig = nil
end
-- END FOREST SECTION 29

-- BEGIN FOREST SECTION 30 Dash
-- Original JASS function: Dash_CreateTrail (line 6538)
function Dash_CreateTrail(u)
    local e = AddSpecialEffect(DASH_TRAIL_EFFECT, GetUnitX(u), GetUnitY(u))
    DestroyEffect(e)
    e = nil
end

-- Original JASS function: Dash_Stop (line 6546)
function Dash_Stop(t)
    local id = GetHandleId(t)
    local u = LoadUnitHandle(DashHash, id, 0)
    local e = LoadEffectHandle(DashHash, id, 4)
    if (e ~= nil) then
        DestroyEffect(e)
    end
    if (u ~= nil) then
        ResetUnitAnimation(u)
    end
    FlushChildHashtable(DashHash, id)
    PauseTimer(t)
    DestroyTimer(t)
    e = nil
    u = nil
    t = nil
end

-- Original JASS function: Dash_TryMove (line 6568)
function Dash_TryMove(u, nx, ny)
    local ox = GetUnitX(u)
    local oy = GetUnitY(u)
    local ax = 0.0
    local ay = 0.0
    SetUnitPosition(u, nx, ny)
    ax = GetUnitX(u)
    ay = GetUnitY(u)
    if (__jreal(__jreal((__jreal(ax - nx)) * (__jreal(ax - nx))) + __jreal((__jreal(ay - ny)) * (__jreal(ay - ny)))) > __jreal(25.00)) then
        SetUnitPosition(u, ox, oy)
        do return false end
    end
    do return true end
end

-- Original JASS function: Dash_TrySlideStep (line 6588)
function Dash_TrySlideStep(u, angle, step)
    local x = GetUnitX(u)
    local y = GetUnitY(u)
    local nx = 0.0
    local ny = 0.0
    nx = __jreal(x + __jreal(step * Cos(angle)))
    ny = __jreal(y + __jreal(step * Sin(angle)))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle + __jreal(0.785398)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle + __jreal(0.785398)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle - __jreal(0.785398)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle - __jreal(0.785398)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle + __jreal(1.570796)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle + __jreal(1.570796)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    nx = __jreal(x + __jreal(step * Cos(__jreal(angle - __jreal(1.570796)))))
    ny = __jreal(y + __jreal(step * Sin(__jreal(angle - __jreal(1.570796)))))
    if Dash_TryMove(u, nx, ny) then
        do return step end
    end
    do return __jreal(0.00) end
end

-- Original JASS function: Dash_Loop (line 6638)
function Dash_Loop()
    local t = GetExpiredTimer()
    local id = GetHandleId(t)
    local u = LoadUnitHandle(DashHash, id, 0)
    local angle = LoadReal(DashHash, id, 1)
    local moved = LoadReal(DashHash, id, 2)
    local targetRange = LoadReal(DashHash, id, 3)
    local tickDistance = __jreal(DASH_SPEED * DASH_PERIOD)
    local subStep = __jreal(6.00)
    local moveNow = 0.0
    if ((u == nil) or (GetWidgetLife(u) <= __jreal(0.405))) then
        Dash_Stop(t)
        t = nil
        u = nil
        do return end
    end
    if (__jreal(moved + tickDistance) > targetRange) then
        tickDistance = __jreal(targetRange - moved)
    end
    while true do
        if (tickDistance <= __jreal(0.00)) then break end
        if (tickDistance < subStep) then
            moveNow = tickDistance
        else
            moveNow = subStep
        end
        moveNow = Dash_TrySlideStep(u, angle, moveNow)
        if (moveNow <= __jreal(0.00)) then
            Dash_Stop(t)
            t = nil
            u = nil
            do return end
        end
        moved = __jreal(moved + moveNow)
        SaveReal(DashHash, id, 5, __jreal(LoadReal(DashHash, id, 5) + moveNow))
        if (LoadReal(DashHash, id, 5) >= DASH_TRAIL_INTERVAL) then
            Dash_CreateTrail(u)
            SaveReal(DashHash, id, 5, __jreal(0.00))
        end
        tickDistance = __jreal(tickDistance - moveNow)
    end
    SaveReal(DashHash, id, 2, moved)
    if (moved >= targetRange) then
        Dash_Stop(t)
    end
    t = nil
    u = nil
end

-- Original JASS function: StartDash (line 6702)
function StartDash(u, tx, ty)
    local t = CreateTimer()
    local id = GetHandleId(t)
    local ux = GetUnitX(u)
    local uy = GetUnitY(u)
    local dx = __jreal(tx - ux)
    local dy = __jreal(ty - uy)
    local dist = SquareRoot(__jreal(__jreal(dx * dx) + __jreal(dy * dy)))
    local angle = 0.0
    local e = nil
    if (dist <= __jreal(10.00)) then
        DestroyTimer(t)
        t = nil
        do return end
    end
    if (dist > DASH_RANGE) then
        dist = DASH_RANGE
    end
    angle = Atan2(dy, dx)
    SetUnitAnimation(u, "walk")
    e = AddSpecialEffectTarget(DASH_ATTACH_EFFECT, u, "origin")
    SaveUnitHandle(DashHash, id, 0, u)
    SaveReal(DashHash, id, 1, angle)
    SaveReal(DashHash, id, 2, __jreal(0.00))
    SaveReal(DashHash, id, 3, dist)
    SaveEffectHandle(DashHash, id, 4, e)
    SaveReal(DashHash, id, 5, __jreal(0.00))
    TimerStart(t, DASH_PERIOD, true, Dash_Loop)
    e = nil
    t = nil
end

-- Original JASS function: Dash_Condition (line 6746)
function Dash_Condition()
    do return (GetSpellAbilityId() == FourCC("A0EW")) end
end

-- Original JASS function: Dash_Action (line 6750)
function Dash_Action()
    StartDash(GetTriggerUnit(), GetSpellTargetX(), GetSpellTargetY())
end

-- Original JASS function: InitTrig_Dash (line 6755)
function InitTrig_Dash()
    local trg = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    TriggerAddCondition(trg, Condition(Dash_Condition))
    TriggerAddAction(trg, Dash_Action)
    trg = nil
end
-- END FOREST SECTION 30

-- BEGIN FOREST SECTION 31 Rome
-- Original JASS function: Trig_Rome_Conditions (line 6767)
function Trig_Rome_Conditions()
    if ((not ((UnitHasBuffBJ(udg_DamageEventTarget, FourCC("B03L")) == true)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Rome_Actions (line 6774)
function Trig_Rome_Actions()
    udg_DamageEventAmount = (__jreal(udg_DamageEventAmount * __jreal(0.60)))
end

-- Original JASS function: InitTrig_Rome (line 6779)
function InitTrig_Rome()
    gg_trg_Rome = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Rome, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Rome, Condition(Trig_Rome_Conditions))
    TriggerAddAction(gg_trg_Rome, Trig_Rome_Actions)
end
-- END FOREST SECTION 31

-- BEGIN FOREST SECTION 32 Basic_Bounty_Hit
-- Original JASS function: Trig_Basic_Bounty_Hit_Func009Func002C (line 6789)
function Trig_Basic_Bounty_Hit_Func009Func002C()
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h05W")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Func009C (line 6796)
function Trig_Basic_Bounty_Hit_Func009C()
    if ((not ((IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true)))) then
        do return false end
    end
    if ((not Trig_Basic_Bounty_Hit_Func009Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Conditions (line 6806)
function Trig_Basic_Bounty_Hit_Conditions()
    if ((not Trig_Basic_Bounty_Hit_Func009C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Basic_Bounty_Hit_Actions (line 6813)
function Trig_Basic_Bounty_Hit_Actions()
    AdjustPlayerStateBJ(35, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    AdjustPlayerStateBJ(1, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    CreateTextTagUnitBJ("TRIGSTR_124", GetEventDamageSource(), __jreal(0), __jreal(9.00), __jreal(100), __jreal(100), __jreal(100), __jreal(0.35))
    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    SetTextTagLifespanBJ(GetLastCreatedTextTag(), __jreal(0.80))
    SetTextTagVelocityBJ(GetLastCreatedTextTag(), __jreal(42.00), __jreal(90))
    SetTextTagFadepointBJ(GetLastCreatedTextTag(), __jreal(0.30))
end

-- Original JASS function: InitTrig_Basic_Bounty_Hit (line 6824)
function InitTrig_Basic_Bounty_Hit()
    gg_trg_Basic_Bounty_Hit = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Basic_Bounty_Hit, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Basic_Bounty_Hit, Condition(Trig_Basic_Bounty_Hit_Conditions))
    TriggerAddAction(gg_trg_Basic_Bounty_Hit, Trig_Basic_Bounty_Hit_Actions)
end
-- END FOREST SECTION 32

-- BEGIN FOREST SECTION 33 Improved_Bounty_Hit
-- Original JASS function: Trig_Improved_Bounty_Hit_Func009Func002C (line 6834)
function Trig_Improved_Bounty_Hit_Func009Func002C()
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h06H")))) then
        do return true end
    end
    if (((GetUnitTypeId(udg_DamageEventSource) == FourCC("h06C")))) then
        do return true end
    end
    do return false end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Func009C (line 6844)
function Trig_Improved_Bounty_Hit_Func009C()
    if ((not ((IsUnitEnemy(udg_DamageEventSource, GetOwningPlayer(udg_DamageEventTarget)) == true)))) then
        do return false end
    end
    if ((not Trig_Improved_Bounty_Hit_Func009Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Conditions (line 6854)
function Trig_Improved_Bounty_Hit_Conditions()
    if ((not Trig_Improved_Bounty_Hit_Func009C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Improved_Bounty_Hit_Actions (line 6861)
function Trig_Improved_Bounty_Hit_Actions()
    AdjustPlayerStateBJ(75, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_LUMBER)
    AdjustPlayerStateBJ(2, GetOwningPlayer(udg_DamageEventSource), PLAYER_STATE_RESOURCE_GOLD)
    CreateTextTagUnitBJ("TRIGSTR_1382", GetEventDamageSource(), __jreal(0), __jreal(9.00), __jreal(100), __jreal(100), __jreal(100), __jreal(0.35))
    SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
    SetTextTagLifespanBJ(GetLastCreatedTextTag(), __jreal(0.80))
    SetTextTagVelocityBJ(GetLastCreatedTextTag(), __jreal(42.00), __jreal(90))
    SetTextTagFadepointBJ(GetLastCreatedTextTag(), __jreal(0.30))
end

-- Original JASS function: InitTrig_Improved_Bounty_Hit (line 6872)
function InitTrig_Improved_Bounty_Hit()
    gg_trg_Improved_Bounty_Hit = CreateTrigger()
    h__TriggerRegisterVariableEvent(gg_trg_Improved_Bounty_Hit, "udg_DamageEvent", EQUAL, __jreal(1.00))
    TriggerAddCondition(gg_trg_Improved_Bounty_Hit, Condition(Trig_Improved_Bounty_Hit_Conditions))
    TriggerAddAction(gg_trg_Improved_Bounty_Hit, Trig_Improved_Bounty_Hit_Actions)
end
-- END FOREST SECTION 33

-- BEGIN FOREST SECTION 34 Harvest_Grapes
-- Original JASS function: Trig_Harvest_Grapes_Conditions (line 6882)
function Trig_Harvest_Grapes_Conditions()
    if ((not ((GetSpellAbilityId() == FourCC("A0DB"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Harvest_Grapes_Actions (line 6889)
function Trig_Harvest_Grapes_Actions()
    CreateItemLoc(FourCC("I027"), GetUnitLoc(GetSpellAbilityUnit()))
    IssueTargetItemOrder(GetSpellAbilityUnit(), "smart", GetLastCreatedItem())
end

-- Original JASS function: InitTrig_Harvest_Grapes (line 6895)
function InitTrig_Harvest_Grapes()
    gg_trg_Harvest_Grapes = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Harvest_Grapes, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Harvest_Grapes, Condition(Trig_Harvest_Grapes_Conditions))
    TriggerAddAction(gg_trg_Harvest_Grapes, Trig_Harvest_Grapes_Actions)
end
-- END FOREST SECTION 34

-- BEGIN FOREST SECTION 35 Bullets_Switch
-- Original JASS function: Trig_Bullets_Switch_Func002C (line 6905)
function Trig_Bullets_Switch_Func002C()
    if ((not ((GetSpellAbilityId() == FourCC("A0DE"))))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Conditions (line 6912)
function Trig_Bullets_Switch_Conditions()
    if ((not Trig_Bullets_Switch_Func002C())) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Func001C (line 6919)
function Trig_Bullets_Switch_Func001C()
    if ((not ((BlzGetUnitWeaponIntegerField(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0) == 5)))) then
        do return false end
    end
    do return true end
end

-- Original JASS function: Trig_Bullets_Switch_Actions (line 6926)
function Trig_Bullets_Switch_Actions()
    if (Trig_Bullets_Switch_Func001C()) then
        BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 2)
    else
        BlzSetUnitWeaponIntegerFieldBJ(GetTriggerUnit(), UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE, 0, 5)
    end
end

-- Original JASS function: InitTrig_Bullets_Switch (line 6935)
function InitTrig_Bullets_Switch()
    gg_trg_Bullets_Switch = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(gg_trg_Bullets_Switch, EVENT_PLAYER_UNIT_SPELL_FINISH)
    TriggerAddCondition(gg_trg_Bullets_Switch, Condition(Trig_Bullets_Switch_Conditions))
    TriggerAddAction(gg_trg_Bullets_Switch, Trig_Bullets_Switch_Actions)
end
-- END FOREST SECTION 35
