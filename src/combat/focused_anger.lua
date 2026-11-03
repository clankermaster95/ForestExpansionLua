-- Unit custom data belongs to Unit Indexer. Never use it as a spell counter.
FE_FocusedAnger = { stacks = {} }

function FE_FocusedAnger.count(unit)
    return FE_FocusedAnger.stacks[unit] or 0
end

function FE_FocusedAnger.add(unit)
    if not unit or GetUnitTypeId(unit) == 0 or FE_FocusedAnger.count(unit) >= 15 then return end
    FE_FocusedAnger.stacks[unit] = FE_FocusedAnger.count(unit) + 1
    IncUnitAbilityLevel(unit, FourCC('A06K'))
    local timer = CreateTimer()
    TimerStart(timer, 6, false, function()
        local remaining = FE_FocusedAnger.count(unit) - 1
        FE_FocusedAnger.stacks[unit] = remaining > 0 and remaining or nil
        if GetUnitTypeId(unit) ~= 0 then DecUnitAbilityLevel(unit, FourCC('A06K')) end
        DestroyTimer(timer)
    end)
end
