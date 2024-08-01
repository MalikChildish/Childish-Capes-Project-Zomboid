-- File: media/lua/client/CapeEffectsBlack.lua

-- Function to add or remove the Inconspicuous trait (Black Cape)
local function adjustInconspicuousTrait(player, equipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if equipped then
        if not player:HasTrait("Inconspicuous") and not modData.InconspicuousAlreadyPresent then
            player:getTraits():add("Inconspicuous")
            player:Say("I feel more inconspicuous")
            print("[childishcape] Inconspicuous trait added")
        elseif player:HasTrait("Inconspicuous") then
            modData.InconspicuousAlreadyPresent = true
            print("[childishcape] Player already has Inconspicuous trait")
        end
    else
        if player:HasTrait("Inconspicuous") and not modData.InconspicuousAlreadyPresent then
            player:getTraits():remove("Inconspicuous")
            player:Say("I feel less inconspicuous")
            print("[childishcape] Inconspicuous trait removed")
        end
        modData.InconspicuousAlreadyPresent = nil
    end
end

-- Event to handle the equip and unequip actions for Black Cape
local function onClothingUpdatedBlack(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "BlackChildishCape" then
        if not player:getModData().BlackCapeEquipped then
            player:getModData().BlackCapeEquipped = true
            adjustInconspicuousTrait(player, true)
        end
    else
        if player:getModData().BlackCapeEquipped then
            adjustInconspicuousTrait(player, false)
            player:getModData().BlackCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedBlack)
Events.OnPlayerUpdate.Add(onClothingUpdatedBlack)
