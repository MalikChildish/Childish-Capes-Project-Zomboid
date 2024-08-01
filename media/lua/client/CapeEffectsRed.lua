-- File: media/lua/client/CapeEffectsRed.lua

local function applyStrengthLevel(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local perkStrength = Perks.Strength
    local currentLevel = player:getPerkLevel(perkStrength)

    if isEquipped then
        if not player:getModData().OriginalStrengthLevel then
            player:getModData().OriginalStrengthLevel = currentLevel
        end
        player:setPerkLevelDebug(perkStrength, 10)
        player:Say("I feel immensely stronger with the red cape on!")
        print("Strength level set to 10.")
    else
        local originalLevel = player:getModData().OriginalStrengthLevel
        if originalLevel then
            player:setPerkLevelDebug(perkStrength, originalLevel)
            player:getModData().OriginalStrengthLevel = nil
            player:Say("I feel weaker without the red cape!")
            print("Strength level restored to " .. tostring(originalLevel) .. ".")
        else
            print("Error: Original strength level not found.")
        end
    end
end

-- Event to handle the equip and unequip actions for the Red cape
local function onClothingUpdatedRed(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "RedChildishCape" then
        if not player:getModData().RedCapeEquipped then
            player:getModData().RedCapeEquipped = true
            applyStrengthLevel(player, true)
        end
    else
        if player:getModData().RedCapeEquipped then
            applyStrengthLevel(player, false)
            player:getModData().RedCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedRed)
Events.OnPlayerUpdate.Add(onClothingUpdatedRed)
