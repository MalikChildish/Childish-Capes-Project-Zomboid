-- File: media/lua/client/CapeEffectsNina.lua

-- Constants for Nina's Cape
local stressReduction = 10
local boredomReduction = 10

-- Function to adjust player's mood based on the equipped item (Nina's Cape)
local function adjustPlayerMood(player, equipped)
    local modData = player:getModData()

    if equipped then
        -- Store original stress and boredom levels if not already stored
        if not modData.originalStress then
            modData.originalStress = player:getStats():getStress()
        end
        if not modData.originalBoredom then
            modData.originalBoredom = player:getBodyDamage():getBoredomLevel()
        end

        -- Apply stress and boredom effects
        local newStress = math.max(0, modData.originalStress - stressReduction)
        local newBoredom = math.max(0, modData.originalBoredom - boredomReduction)
        player:getStats():setStress(newStress)
        player:getBodyDamage():setBoredomLevel(newBoredom)

        print("Stress and boredom reduction applied")
        print("Stress Level before: " .. modData.originalStress)
        print("Stress Level after: " .. newStress)
        print("Boredom Level before: " .. modData.originalBoredom)
        print("Boredom Level after: " .. newBoredom)
    else
        -- Restore original stress and boredom levels if they were stored
        if modData.originalStress then
            player:getStats():setStress(modData.originalStress)
            modData.originalStress = nil
        end
        if modData.originalBoredom then
            player:getBodyDamage():setBoredomLevel(modData.originalBoredom)
            modData.originalBoredom = nil
        end

        print("Stress and boredom reduction removed")
    end
end

-- Event to handle the equip and unequip actions for Nina's Cape
local function onClothingUpdatedNina(player)
    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "NinaChildishCape" then
        if not player:getModData().NinaCapeEquipped then
            player:getModData().NinaCapeEquipped = true
            adjustPlayerMood(player, true)
        end
    else
        if player:getModData().NinaCapeEquipped then
            adjustPlayerMood(player, false)
            player:getModData().NinaCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedNina)
Events.OnPlayerUpdate.Add(onClothingUpdatedNina)
