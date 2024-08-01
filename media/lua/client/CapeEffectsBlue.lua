-- File: media/lua/client/CapeEffectsBlue.lua

local function applyCapeEffects(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local wornItems = player:getWornItems()
    if not wornItems then
        print("Error: Worn items are nil")
        return
    end

    print("Number of worn items: " .. tostring(wornItems:size()))

    local insulationIncrease = 0.1 -- Set this to a moderate value equivalent to a jacket

    for i = 0, wornItems:size() - 1 do
        local item = wornItems:get(i):getItem()
        if item and item.getInsulation and item.setInsulation then
            local modData = item:getModData()
            if isEquipped then
                if not modData.originalInsulation then
                    modData.originalInsulation = item:getInsulation()
                end
                item:setInsulation(modData.originalInsulation + insulationIncrease)
                print("Increased insulation for item: " .. item:getType() .. ", new insulation: " .. tostring(item:getInsulation()))
            else
                if modData.originalInsulation then
                    item:setInsulation(modData.originalInsulation)
                    modData.originalInsulation = nil
                    print("Restored insulation for item: " .. item:getType() .. ", original insulation: " .. tostring(item:getInsulation()))
                end
            end
        else
            print("Error: Item is nil or does not support insulation at index " .. tostring(i))
        end
    end

    if isEquipped then
        player:Say("I feel much warmer with this cape on!")
    else
        player:Say("I feel cooler without the cape!")
    end
end

-- Event to handle the equip and unequip actions for the Blue cape
local function onClothingUpdatedBlue(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "BlueChildishCape" then
        if not player:getModData().BlueCapeEquipped then
            player:getModData().BlueCapeEquipped = true
            applyCapeEffects(player, true)
        end
    else
        if player:getModData().BlueCapeEquipped then
            applyCapeEffects(player, false)
            player:getModData().BlueCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedBlue)
Events.OnPlayerUpdate.Add(onClothingUpdatedBlue)
