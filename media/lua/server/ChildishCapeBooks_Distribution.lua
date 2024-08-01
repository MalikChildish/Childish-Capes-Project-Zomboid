require "Items/ProceduralDistributions"

local books = {
    "Base.HeroicTales_OrangeCape",
    "Base.HeroicTales_NinaCape",
    "Base.HeroicTales_TwistedCape",
    "Base.HeroicTales_BlackCape",
    "Base.HeroicTales_BlueCape",
    "Base.HeroicTales_ChoiceCape",
    "Base.HeroicTales_CloudCape",
    "Base.HeroicTales_HighlightCape",
    "Base.HeroicTales_MoneyCape",
    "Base.HeroicTales_PotatoCape",
    "Base.HeroicTales_RedCape",
    "Base.HeroicTales_ShogunCape",
    "Base.HeroicTales_SpaceCape",
}

local bookDistributions = {
    BookstoreBooks = 1,
    BookstoreMisc = 0.5,
    CrateBooks = 0.5,
    CrateMagazines = 0.5,
    LibraryBooks = 1,
    LivingRoomShelf = 0.5,
    LivingRoomShelfNoTapes = 0.5,
    LivingRoomSideTable = 0.5,
    MagazineRackMixed = 0.2,
    PostOfficeBooks = 0.5,
}

for distribution, chance in pairs(bookDistributions) do
    for _, book in ipairs(books) do
        table.insert(ProceduralDistributions.list[distribution].items, book)
        table.insert(ProceduralDistributions.list[distribution].items, chance)
    end
end

-- Add debug prints to verify distribution
print("Distributions updated with HeroicTales books:")
for distribution, chance in pairs(bookDistributions) do
    print(distribution .. " updated with chance " .. chance)
end
