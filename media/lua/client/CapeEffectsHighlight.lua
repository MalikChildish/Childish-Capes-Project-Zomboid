-- File: media/lua/client/CapeEffectsHighlight.lua

local function applyNightVisionTrait(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if isEquipped then
        if not player:HasTrait("NightVision") and not modData.NightVisionAlreadyPresent then
            player:getTraits():add("NightVision")
            player:Say("I can see perfectly in the dark with the highlight cape on!")
            print("Night Vision trait equipped.")
        elseif player:HasTrait("NightVision") then
            modData.NightVisionAlreadyPresent = true
            print("Player already has Night Vision trait.")
        end
    else
        if player:HasTrait("NightVision") and not modData.NightVisionAlreadyPresent then
            player:getTraits():remove("NightVision")
            player:Say("I can't see as well in the dark without the highlight cape.")
            print("Night Vision trait removed.")
        end
        modData.NightVisionAlreadyPresent = nil
    end
end

-- Event to handle the equip and unequip actions for the Highlight cape
local function onClothingUpdatedHighlight(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "HighlightChildishCape" then
        if not player:getModData().HighlightCapeEquipped then
            player:getModData().HighlightCapeEquipped = true
            applyNightVisionTrait(player, true)
        end
    else
        if player:getModData().HighlightCapeEquipped then
            applyNightVisionTrait(player, false)
            player:getModData().HighlightCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedHighlight)
Events.OnPlayerUpdate.Add(onClothingUpdatedHighlight)
