-- File: media/lua/client/CapeEffectsPotato.lua

local function applyThickSkinnedTrait(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if isEquipped then
        if not player:HasTrait("ThickSkinned") and not modData.ThickSkinnedAlreadyPresent then
            player:getTraits():add("ThickSkinned")
            player:Say("I feel tougher with the potato cape on!")
            print("Thick Skinned trait equipped.")
        elseif player:HasTrait("ThickSkinned") then
            modData.ThickSkinnedAlreadyPresent = true
            print("Player already has Thick Skinned trait.")
        end
    else
        if player:HasTrait("ThickSkinned") and not modData.ThickSkinnedAlreadyPresent then
            player:getTraits():remove("ThickSkinned")
            player:Say("I feel less tough without the potato cape!")
            print("Thick Skinned trait removed.")
        end
        modData.ThickSkinnedAlreadyPresent = nil
    end
end

-- Event to handle the equip and unequip actions for the Potato cape
local function onClothingUpdatedPotato(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "PotatoChildishCape" then
        if not player:getModData().PotatoCapeEquipped then
            player:getModData().PotatoCapeEquipped = true
            applyThickSkinnedTrait(player, true)
        end
    else
        if player:getModData().PotatoCapeEquipped then
            applyThickSkinnedTrait(player, false)
            player:getModData().PotatoCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedPotato)
Events.OnPlayerUpdate.Add(onClothingUpdatedPotato)
