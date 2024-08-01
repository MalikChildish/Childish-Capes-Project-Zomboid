-- File: media/lua/client/CapeEffectsMoney.lua

-- Function to add or remove the Lucky trait (Money Cape)
local function adjustLuckyTrait(player, equipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if equipped then
        if not player:HasTrait("Lucky") then
            player:getTraits():add("Lucky")
            player:Say("I feel luckier with the money cape on!")
            print("[childishcape] Lucky trait added")
            modData.LuckyAlreadyPresent = false
        else
            modData.LuckyAlreadyPresent = true
            print("[childishcape] Player already has Lucky trait")
        end
    else
        if player:HasTrait("Lucky") and not modData.LuckyAlreadyPresent then
            player:getTraits():remove("Lucky")
            player:Say("I feel less lucky without the money cape.")
            print("[childishcape] Lucky trait removed")
        elseif player:HasTrait("Lucky") and modData.LuckyAlreadyPresent then
            print("[childishcape] Lucky trait retained")
        end
        modData.LuckyAlreadyPresent = nil
    end
end

-- Event to handle the equip and unequip actions for Money Cape
local function onClothingUpdatedMoney(player)
    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "MoneyChildishCape" then
        if not player:getModData().MoneyCapeEquipped then
            player:getModData().MoneyCapeEquipped = true
            adjustLuckyTrait(player, true)
        end
    else
        if player:getModData().MoneyCapeEquipped then
            adjustLuckyTrait(player, false)
            player:getModData().MoneyCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedMoney)
Events.OnPlayerUpdate.Add(onClothingUpdatedMoney)
