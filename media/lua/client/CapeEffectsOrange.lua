-- File: media/lua/client/CapeEffectsOrange.lua

-- Constants for Orange Cape
local minXPAmount = 100 -- Minimum XP to add
local maxXPAmount = 500 -- Maximum XP to add

-- Function to generate a random positive float between min and max using ZombRand
local function getRandomPositiveFloat(min, max)
    return min + (ZombRand(10000) / 10000) * (max - min)
end

-- Function to adjust player's run speed based on the equipped item (Orange Cape)
local function adjustRunSpeed(player, equipped)
    local xpAmount = getRandomPositiveFloat(minXPAmount, maxXPAmount)
    
    if equipped then
        if not player:getModData().OrangeCapeXPGranted then
            -- Add Sprinting XP once
            player:getXp():AddXP(Perks.Sprinting, xpAmount)
            player:getModData().OrangeCapeXPGranted = true
            player:Say("I feel way faster\nGained Sprinting XP")
            print("[childishcape] Sprinting XP added, XP granted: " .. xpAmount)
        else
            player:Say("Sprinting XP already added")
            print("[childishcape] Sprinting XP already added")
        end
    else
        player:Say("Takes My Childish Cape Off")
        print("[childishcape] Run Speed Boost removed")
    end
end

-- Event to handle the equip and unequip actions for Orange Cape
local function onClothingUpdatedOrange(player)
    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "ChildishCape" then
        if not player:getModData().OrangeCapeEquipped then
            player:getModData().OrangeCapeEquipped = true
            adjustRunSpeed(player, true)
        end
    else
        if player:getModData().OrangeCapeEquipped then
            adjustRunSpeed(player, false)
            player:getModData().OrangeCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedOrange)
Events.OnPlayerUpdate.Add(onClothingUpdatedOrange)

-- Initialize the XP granted flag on game start
local function onGameStartOrange()
    local player = getPlayer()
    if not player:getModData().OrangeCapeXPGranted then
        player:getModData().OrangeCapeXPGranted = false
    end
end

Events.OnGameStart.Add(onGameStartOrange)
