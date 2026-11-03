-- Each carrier earns its own XP. Read its inventory at each tick so nested
-- crafting/drop events cannot leave stale global counters behind.
FE_Ledgers = { units = {}, known = {} }

function FE_Ledgers.watch(unit)
    if unit and not FE_Ledgers.known[unit] then
        FE_Ledgers.known[unit] = true
        FE_Ledgers.units[#FE_Ledgers.units + 1] = unit
    end
end

function FE_Ledgers.tick()
    for index = #FE_Ledgers.units, 1, -1 do
        local unit = FE_Ledgers.units[index]
        local xp = 0
        if GetUnitTypeId(unit) ~= 0 then
            if UnitHasItemOfTypeBJ(unit, FourCC('I01N')) then xp = 8
            elseif UnitHasItemOfTypeBJ(unit, FourCC('I01J')) then xp = 3 end
        end
        if xp == 0 then
            FE_Ledgers.known[unit] = nil; table.remove(FE_Ledgers.units, index)
        elseif GetWidgetLife(unit) > 0.405 then
            AddHeroXP(unit, xp, true)
        end
    end
end
