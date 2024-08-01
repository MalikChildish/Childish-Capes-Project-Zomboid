-- File: media/lua/client/CapeEffectsSpace.lua

-- Function to apply space cape traits
local function applySpaceCapeTraits(player, isEquipped)
    if not player then
        print("Error: Player object is nil")
        return
    end

    if isEquipped then
        -- Add traits if not already present
        if not player:HasTrait("KeenHearing") then
            player:getTraits():add("KeenHearing")
            player:getModData().KeenHearingAddedByCape = true
            print("KeenHearing trait equipped.")
        end
        if not player:HasTrait("FastLearner") then
            player:getTraits():add("FastLearner")
            player:getModData().FastLearnerAddedByCape = true
            player:Say("I feel so much smarter with the space cape on!")
            print("FastLearner trait equipped.")
        end
    else
        -- Remove traits if they were added by the cape
        if player:getModData().KeenHearingAddedByCape then
            player:getTraits():remove("KeenHearing")
            player:getModData().KeenHearingAddedByCape = nil
            player:Say("I feel less perceptive without the space cape.")
            print("KeenHearing trait removed.")
        end
        if player:getModData().FastLearnerAddedByCape then
            player:getTraits():remove("FastLearner")
            player:getModData().FastLearnerAddedByCape = nil
            player:Say("I feel like I learn slower without the space cape.")
            print("FastLearner trait removed.")
        end
    end
end

-- Event to handle the equip and unequip actions for the Space cape
local function onClothingUpdatedSpace(player)
    if not player then
        print("Error: Player object is nil")
        return
    end

    local equippedItem = player:getWornItem("Back") -- Check if item is worn on the back

    if equippedItem and equippedItem:getType() == "SpaceChildishCape" then
        if not player:getModData().SpaceCapeEquipped then
            player:getModData().SpaceCapeEquipped = true
            applySpaceCapeTraits(player, true)
        end
    else
        if player:getModData().SpaceCapeEquipped then
            applySpaceCapeTraits(player, false)
            player:getModData().SpaceCapeEquipped = false
        end
    end
end

-- Adding event listeners
Events.OnClothingUpdated.Add(onClothingUpdatedSpace)
Events.OnPlayerUpdate.Add(onClothingUpdatedSpace)
