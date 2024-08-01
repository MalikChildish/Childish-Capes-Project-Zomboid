-- File: media/lua/client/AllCapeEffects.lua

local function applyScratchBiteResistance(player, isEquipped)
    if not player then
        print("[childishcape] Error: Player object is nil")
        return
    end

    local validLocations = {
        ["Jacket"] = true,
        ["Shirt"] = true,
        ["Tshirt"] = true,
        ["Sweater"] = true
    }

    local wornItems = player:getWornItems()
    if not wornItems then
        print("[childishcape] Error: Worn items are nil")
        return
    end

    print("[childishcape] Number of worn items: " .. tostring(wornItems:size()))

    local resistanceIncrease = 5

    for i = 0, wornItems:size() - 1 do
        local item = wornItems:get(i):getItem()
        if item then
            local location = item:getBodyLocation()
            if validLocations[location] then
                local modData = item:getModData()
                if isEquipped then
                    if not modData.originalScratchDefense then
                        modData.originalScratchDefense = item:getScratchDefense()
                    end
                    if not modData.originalBiteDefense then
                        modData.originalBiteDefense = item:getBiteDefense()
                    end
                    item:setScratchDefense(modData.originalScratchDefense + resistanceIncrease)
                    item:setBiteDefense(modData.originalBiteDefense + resistanceIncrease)
                    print("[childishcape] Increased scratch and bite resistance for item: " .. item:getType() .. " at location: " .. location)
                else
                    if modData.originalScratchDefense then
                        item:setScratchDefense(modData.originalScratchDefense)
                        modData.originalScratchDefense = nil
                    end
                    if modData.originalBiteDefense then
                        item:setBiteDefense(modData.originalBiteDefense)
                        modData.originalBiteDefense = nil
                    end
                    print("[childishcape] Restored scratch and bite resistance for item: " .. item:getType() .. " at location: " .. location)
                end
            else
                print("[childishcape] Item at index " .. tostring(i) .. " is worn at location: " .. location .. ", which is not a valid location")
            end
        else
            print("[childishcape] Error: Item is nil or does not support defenses at index " .. tostring(i))
        end
    end
end

-- Event to handle the equip and unequip actions for all capes
local function onClothingUpdatedUpperBody(player)
    if not player then
        print("[childishcape] Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and (
        equippedItem:getType() == "BlackChildishCape" or
        equippedItem:getType() == "BlueChildishCape" or
        equippedItem:getType() == "ChoiceChildishCape" or
        equippedItem:getType() == "CloudChildishCape" or
        equippedItem:getType() == "HighlightChildishCape" or
        equippedItem:getType() == "MoneyChildishCape" or
        equippedItem:getType() == "NinaChildishCape" or
        equippedItem:getType() == "PotatoChildishCape" or
        equippedItem:getType() == "RedChildishCape" or
        equippedItem:getType() == "ShogunChildishCape" or
        equippedItem:getType() == "SpaceChildishCape" or
        equippedItem:getType() == "TwistedChildishCape") then

        if not player:getModData().CapeEquipped then
            player:getModData().CapeEquipped = true
            applyScratchBiteResistance(player, true)
        end
    else
        if player:getModData().CapeEquipped then
            applyScratchBiteResistance(player, false)
            player:getModData().CapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedUpperBody)
Events.OnPlayerUpdate.Add(onClothingUpdatedUpperBody)
