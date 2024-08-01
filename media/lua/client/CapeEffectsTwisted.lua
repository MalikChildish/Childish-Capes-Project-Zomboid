-- File: media/lua/client/CapeEffectsTwisted.lua

-- Function to add or remove the Herbalist trait (Twisted Cape)
local function adjustHerbalistTrait(player, equipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if equipped then
        if not player:HasTrait("Herbalist") and not modData.HerbalistAlreadyPresent then
            player:getTraits():add("Herbalist")
            player:Say("I feel knowledgeable about herbs")
            print("[childishcape] Herbalist trait added")
        elseif player:HasTrait("Herbalist") then
            modData.HerbalistAlreadyPresent = true
            print("[childishcape] Player already has Herbalist trait")
        end
    else
        if player:HasTrait("Herbalist") and not modData.HerbalistAlreadyPresent then
            player:getTraits():remove("Herbalist")
            player:Say("I forgot my herb knowledge")
            print("[childishcape] Herbalist trait removed")
        end
        modData.HerbalistAlreadyPresent = nil
    end
end

-- Event to handle the equip and unequip actions for Twisted Cape
local function onClothingUpdatedTwisted(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "TwistedChildishCape" then
        if not player:getModData().TwistedCapeEquipped then
            player:getModData().TwistedCapeEquipped = true
            adjustHerbalistTrait(player, true)
        end
    else
        if player:getModData().TwistedCapeEquipped then
            adjustHerbalistTrait(player, false)
            player:getModData().TwistedCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedTwisted)
Events.OnPlayerUpdate.Add(onClothingUpdatedTwisted)
