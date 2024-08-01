require('media/lua/shared/NPCs/ChildishCapeZombs')

ZombiesZoneDefinition = ZombiesZoneDefinition or {}

ZombiesZoneDefinition.ChildishCapeZombs = {
    -- Initial Outfits
    ChildishMaleWithCapes = {
        name = "ChildishMaleWithCapes",
        chance = 15,
        gender = "male",
    },
}

-- Insert the outfits into the default zone
local defaultZone = ZombiesZoneDefinition.Default or {}
table.insert(defaultZone, {name = "ChildishMaleWithCape", chance = 15});

