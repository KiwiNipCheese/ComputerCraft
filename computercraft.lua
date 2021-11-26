iChest =  peripheral.wrap("top");
fCrafter = peripheral.wrap("left");
oChest = peripheral.wrap("bottom");;
oChestSide = "bottom";
fCrafterSide = "left";
recipes = 
{
    {"draconicevolution:wyvern_crafting_injector"  
        ,
        {
            {"draconicevolution:basic_crafting_injector",1}
            {"minecraft:diamond",4}
            {"draconicevolution:draconium_block",1}
            {"draconicevolution:draonium_core",2}
        }
    }
}
function getContents(inventory)
    local invData = inventory.list();
    local tempDict = {};
    for i in next,invData do 
        local tString = invData[i].name;
        if(tempDict[tString]) then
            table.insert(tempDict,i,{invData[i]["name"],tempDict[tString] + invData[i]["count"]});
        else
            tempDict[i] = invData[i]["count"];
        end
    end
    return tempDict;
end
function checkRecipe(recipeList,contents)
    local recipeBool = false;
    for recipe in next,recipeList do
        for ingredients in next,recipe[2] do
            if recipeBool == false && recipe[2][1][1] == ingredients[1] then
                recipeBool = true;
            end
            for chestContents in next,contents do
                if chestContents[1] == ingredients[1] then
                    if chestContents[2] % ingredients[2] == 0 then
                    else
                        recipeBool = false;
                        break 
                    end
                end
            end
        end
        if recipeBool then
            return recipe;
        end
    end
    return false
end
function rpushToChest(itemID,count,chest,side)
    local chestList = chest.list();
    local currentCount = count;
    local j = 1;
    for i,k in next,chestList do
        if k.name == itemID then
            if ( k.count >= currentCount) then
                currentCount = currentCount - chest.pushItems(side,j,currentCount);
                return true;
            else
                currentCount = currentCount - chest.pushItems(side,j,currentCount);
            end
            
        end
        j = j+1;
    end
    return false
end
while true do
    local recipeCheck = checkRecipe(recipes,getContents(iChest))
    if recipeCheck then
        rpushToChest(recipeCheck[2][1][1],recipeCheck[2][1][2],iChest,fCrafter,1);
        for i=2,table.getn(recipeCheck) do
            rpushToChest(recipeCheck[2][i][1],recipeCheck[2][i][2],iChest,oChest);
        end
        rs.setOutput("left",true);
        os.sleep(1);
        rs.setOuptut("left",false);
        while not (fCrafter.list[2] == nil) do
            os.sleep(1)
        end
        print(recipeCheck[1],"succesfully crafted")
        rs.setOuptut("front",true);
        os.sleep(1);
        rs.setOuptut("front",false);
    end
end