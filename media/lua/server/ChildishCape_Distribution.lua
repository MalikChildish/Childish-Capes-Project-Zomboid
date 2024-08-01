require "Items/ProceduralDistributions"

local items = {
    "ChildishCapes.BlackChildishCape", 
    "ChildishCapes.BlueChildishCape", 
    "ChildishCapes.ChildishCape", 
    "ChildishCapes.ChoiceChildishCape", 
    "ChildishCapes.CloudChildishCape", 
    "ChildishCapes.HighlightChildishCape", 
    "ChildishCapes.MoneyChildishCape", 
    "ChildishCapes.NinaChildishCape", 
    "ChildishCapes.PotatoChildishCape", 
    "ChildishCapes.RedChildishCape", 
    "ChildishCapes.ShogunChildishCape", 
    "ChildishCapes.SpaceChildishCape", 
    "ChildishCapes.TwistedChildishCape",
}

local distributions = {
    BedroomDresser = 0.2,
    CampingLockers = 2,
    CampingStoreClothes = 0.5,
    ClothingStorageAllShirts = 10,
    ClothingStoresShirts = 5,
    ClothingStoresSport = 10,
    CrateCamping = 0.5,
    CrateClothesRandom = 8,
    CrateRandomJunk = 0.8,
    DresserGeneric = 0.2,
    FitnessTrainer = 0.5,
    GymLaundry = 1,
    GymLockers = 0.5,
    LaundryLoad6 = 1,
    SchoolLockers = 0.2,
    WardrobeChild = 0.2,
    ZippeeClothing = 10
}

for distribution, chance in pairs(distributions) do
    for _, item in ipairs(items) do
        table.insert(ProceduralDistributions.list[distribution].items, item)
        table.insert(ProceduralDistributions.list[distribution].items, chance)
    end
end

-- Add debug prints to verify distribution
print("Distributions updated with ChildishCapes:")
for distribution, chance in pairs(distributions) do
    print(distribution .. " updated with chance " .. chance)
end
