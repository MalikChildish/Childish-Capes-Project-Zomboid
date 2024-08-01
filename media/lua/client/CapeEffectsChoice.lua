-- File: media/lua/client/CapeEffectsChoice.lua

local function applyCapeEffects(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if isEquipped then
        -- Store original values if not already stored
        if not modData.OriginalStaminaRegenRate then
            modData.OriginalStaminaRegenRate = player:getStats():getEndurance()
            print("[Debug] Original Stamina Regen Rate stored: " .. tostring(modData.OriginalStaminaRegenRate))
        end
        if not modData.OriginalPanicReduction then
            modData.OriginalPanicReduction = player:getStats():getPanic()
            print("[Debug] Original Panic Reduction stored: " .. tostring(modData.OriginalPanicReduction))
        end

        -- Increase stamina regeneration and reduce panic
        local newStaminaRegenRate = modData.OriginalStaminaRegenRate * 1.5
        local newPanicReduction = modData.OriginalPanicReduction * 0.5

        player:getStats():setEndurance(newStaminaRegenRate)
        player:getStats():setPanic(newPanicReduction)

        player:Say("I feel energized and calm with this cape on!")
        print("[Debug] Cape effects applied: Increased stamina regeneration to " .. tostring(newStaminaRegenRate) .. " and reduced panic to " .. tostring(newPanicReduction))
    else
        -- Restore original values
        if modData.OriginalStaminaRegenRate then
            player:getStats():setEndurance(modData.OriginalStaminaRegenRate)
            print("[Debug] Restored Original Stamina Regen Rate: " .. tostring(modData.OriginalStaminaRegenRate))
            modData.OriginalStaminaRegenRate = nil
        end
        if modData.OriginalPanicReduction then
            player:getStats():setPanic(modData.OriginalPanicReduction)
            print("[Debug] Restored Original Panic Reduction: " .. tostring(modData.OriginalPanicReduction))
            modData.OriginalPanicReduction = nil
        end

        player:Say("I feel less energetic and more anxious without the cape.")
        print("[Debug] Cape effects removed: Restored stamina regeneration and panic levels.")
    end
end

-- Event to handle the equip and unequip actions for the Choice cape
local function onClothingUpdatedChoice(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "ChoiceChildishCape" then
        if not player:getModData().ChoiceCapeEquipped then
            player:getModData().ChoiceCapeEquipped = true
            applyCapeEffects(player, true)
        end
    else
        if player:getModData().ChoiceCapeEquipped then
            applyCapeEffects(player, false)
            player:getModData().ChoiceCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedChoice)
Events.OnPlayerUpdate.Add(onClothingUpdatedChoice)
