-- Original JASS function: Trig_Item_Crafting_Actions (line 3795)
function Trig_Item_Crafting_Actions()
    FE_Recipes.combineOwned(GetTriggerUnit(), FourCC('I01N'))
end

-- Original JASS function: InitTrig_Item_Crafting (line 3837)
function InitTrig_Item_Crafting()
    local t = CreateTrigger()
    TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
    TriggerAddAction(t, Trig_Item_Crafting_Actions)
end
