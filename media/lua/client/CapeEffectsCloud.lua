-- File: media/lua/client/CapeEffectsCloud.lua

local function applySprintingXP(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local perkSprinting = Perks.Sprinting
    local xpSystem = player:getXp()
    local modData = player:getModData()

    if isEquipped then
        if not modData.OriginalSprintingXP then
            modData.OriginalSprintingXP = xpSystem:getXP(perkSprinting)
        end
        if not modData.OriginalSprintingLevel then
            modData.OriginalSprintingLevel = player:getPerkLevel(perkSprinting)
        end
        xpSystem:AddXP(perkSprinting, 10000)
        player:Say("I feel like the wind with the cloud cape on!")
        print("Added 10000 XP to Sprinting.")
    else
        if modData.OriginalSprintingXP and modData.OriginalSprintingLevel then
            local currentXP = xpSystem:getXP(perkSprinting)
            local xpToRemove = currentXP - modData.OriginalSprintingXP
            xpSystem:AddXP(perkSprinting, -xpToRemove)
            player:setPerkLevelDebug(perkSprinting, modData.OriginalSprintingLevel)
            modData.OriginalSprintingXP = nil
            modData.OriginalSprintingLevel = nil
            player:Say("You feel slower without the cloud cape.")
            print("Restored original Sprinting XP and Level.")
        else
            print("Error: Original sprinting XP or level not found.")
        end
    end
end

local function applyFallDamageReduction(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local modData = player:getModData()

    if isEquipped then
        if not modData.OriginalFallDamageReduction then
            modData.OriginalFallDamageReduction = player:getBodyDamage():getHealthFromFood()
            print("[Debug] Original Fall Damage Reduction stored: " .. tostring(modData.OriginalFallDamageReduction))
        end

        local newFallDamageReduction = modData.OriginalFallDamageReduction * 2.5
        player:getBodyDamage():setHealthFromFood(newFallDamageReduction)
        print("[Debug] Cloud Cape effects applied: Reduced fall damage to " .. tostring(newFallDamageReduction))
    else
        if modData.OriginalFallDamageReduction then
            player:getBodyDamage():setHealthFromFood(modData.OriginalFallDamageReduction)
            print("[Debug] Restored Original Fall Damage Reduction: " .. tostring(modData.OriginalFallDamageReduction))
            modData.OriginalFallDamageReduction = nil
        else
            print("Error: Original fall damage reduction not found.")
        end
    end
end

local function onClothingUpdatedCloud(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back")

    if equippedItem and equippedItem:getType() == "CloudChildishCape" then
        if not player:getModData().CloudCapeEquipped then
            player:getModData().CloudCapeEquipped = true
            applySprintingXP(player, true)
            applyFallDamageReduction(player, true)
        end
    else
        if player:getModData().CloudCapeEquipped then
            applySprintingXP(player, false)
            applyFallDamageReduction(player, false)
            player:getModData().CloudCapeEquipped = false
        end
    end
end

Events.OnClothingUpdated.Add(onClothingUpdatedCloud)
Events.OnPlayerUpdate.Add(onClothingUpdatedCloud)
