-- File: media/lua/client/CapeEffectsShogun.lua

local function applyWeaponDamageMultiplier(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local damageMultiplier = 1.5

    local function applyDamageMultiplier(item)
        if item and item:getModData() and item.setMinDamage and item.setMaxDamage then
            local modData = item:getModData()
            if isEquipped then
                if not modData.originalMinDamage then
                    modData.originalMinDamage = item:getMinDamage()
                    modData.originalMaxDamage = item:getMaxDamage()
                end
                item:setMinDamage(modData.originalMinDamage * damageMultiplier)
                item:setMaxDamage(modData.originalMaxDamage * damageMultiplier)
                print("Increased damage for item: " .. item:getType() .. ", new min damage: " .. tostring(item:getMinDamage()) .. ", new max damage: " .. tostring(item:getMaxDamage()))
            else
                if modData.originalMinDamage and modData.originalMaxDamage then
                    item:setMinDamage(modData.originalMinDamage)
                    item:setMaxDamage(modData.originalMaxDamage)
                    modData.originalMinDamage = nil
                    modData.originalMaxDamage = nil
                    print("Restored damage for item: " .. item:getType() .. ", min damage: " .. tostring(item:getMinDamage()) .. ", max damage: " .. tostring(item:getMaxDamage()))
                end
            end
        end
    end

    applyDamageMultiplier(player:getPrimaryHandItem())
    applyDamageMultiplier(player:getSecondaryHandItem())

    if isEquipped then
        player:Say("I feel like a master warrior with the shogun cape on!")
    else
        player:Say("I feel my strength returning to normal without the shogun cape.")
    end
end

-- Function to check and apply the weapon damage multiplier when the player equips new weapons
local function onEquipPrimary(player, item)
    if player and player:getModData().ShogunCapeEquipped then
        applyWeaponDamageMultiplier(player, true)
    end
end

local function onEquipSecondary(player, item)
    if player and player:getModData().ShogunCapeEquipped then
        applyWeaponDamageMultiplier(player, true)
    end
end

-- Event to handle the equip and unequip actions for the Shogun cape
local function onClothingUpdatedShogun(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "ShogunChildishCape" then
        if not player:getModData().ShogunCapeEquipped then
            player:getModData().ShogunCapeEquipped = true
            applyWeaponDamageMultiplier(player, true)
        end
    else
        if player:getModData().ShogunCapeEquipped then
            applyWeaponDamageMultiplier(player, false)
            player:getModData().ShogunCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedShogun)
Events.OnPlayerUpdate.Add(onClothingUpdatedShogun)
Events.OnEquipPrimary.Add(onEquipPrimary)
Events.OnEquipSecondary.Add(onEquipSecondary)
