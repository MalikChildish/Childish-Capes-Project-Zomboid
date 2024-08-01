require 'Items/SuburbsDistributions'

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
    "Base.HeroicTales_SpaceCape"
}

-- Function to add books to a distribution list
local function addBooksToDistribution(distribution)
    for _, book in ipairs(books) do
        table.insert(SuburbsDistributions["all"][distribution].items, book)
        table.insert(SuburbsDistributions["all"][distribution].items, 0.25) -- Adjust the weight as needed
    end
end

-- Add books to male zombie inventory
addBooksToDistribution("inventorymale")

-- Add books to female zombie inventory
addBooksToDistribution("inventoryfemale")
