function Trig_Item_Crafting_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

function InitTrig_Item_Crafting()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(t, Trig_Item_Crafting_Actions)
end
