Recipe.ChildishCapeXP = {}

function Recipe.ChildishCapeXP.MakeChildishCape100(recipe, ingredients, result, player)
    	player:getXp():AddXP(Perks.Tailoring, 100);
end