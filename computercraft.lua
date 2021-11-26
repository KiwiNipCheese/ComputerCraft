iChest =  peripheral.wrap("top");
fCrafter = peripheral.wrap("left");
oChest = peripheral.wrap("right");
oChestSide = "right";
fCrafterSide = "left";
recipes = 
{
    {"draconicevolution:wyvern_crafting_injector"  
        ,
        {
            {"draconicevolution:basic_crafting_injector",1}
            ,
            {"minecraft:diamond",4}
            ,
            {"draconicevolution:draconium_block",1}
            ,
            {"draconicevolution:draconium_core",2}
            ,
            {"draconicevolution:wyvern_core",1}
        }
    }
    ,
    {"draconicevolution:awakened_core"  
        ,
        {
            {"minecraft:nether_star",1}
            ,
            {"draconicevolution:wyvern_core",4}
            ,
            {"draconicevolution:awakened_draconium_ingot",4}
        }
    }
    ,
    {"draconicevolution:awakened_crafting_injector"  
        ,
        {
            {"draconicevolution:wyvern_crafting_injector",1}
            ,
            {"minecraft:diamond",4}
            ,
            {"draconicevolution:awakened_draconium_block",2}
            ,
            {"draconicevolution:wyvern_core",2}
        }
    }
    ,
    {"draconicevolution:chaotic_crafting_injector"  
        ,
        {
            {"draconicevolution:awakened_crafting_injector",1}
            ,
            {"minecraft:diamond",4}
            ,
            {"minecraft:dragon_egg",1}
            ,
            {"draconicevolution:large_chaos_frag",4}

        }
    }
    ,
    {"kubejs:uru_ingot"  
        ,
        {
            {"draconicevolution:chaos_shard",1}
            ,
            {"allthemodium:vibranium_allthemodium_alloy_ingot",1}
            ,
            {"allthemodium:unobtainium_vibranium_alloy_ingot",1}
            ,
            {"allthemodium:unobtainium_allthemodium_alloy_ingot",1}
            ,
            {"draconicevolution:awakened_draconium_ingot",1}
        }
    }
}
function getContents(inventory)
    local invData = inventory.list();
    local tempDict = {};
    for i,val in next,invData do 
        local tString = invData[i].name;
        if(tempDict[i]) then
            tempDict[i] = {val["name"],tempDict[tString] + val["count"]};
        else
            tempDict[i] = {val["name"],val["count"]};
        end
    end
    return tempDict;
end
function checkRecipe(recipeList,contents)
    local recipeBool = true;
    for index,recipe in next,recipeList do
        local rCheck = {}
        for index2,ingredients in next,recipe[2] do
            local r1 = false;
            local r2 = false;
            for index3,chestContents in next,contents do
                if chestContents[1] == ingredients[1] then
                    r1 = true
                    if chestContents[2] % ingredients[2] == 0 then
                        r2 = true;
                    else
                    end
                end
            end
            if r1 and r2 then
                rCheck[index2] = true
            else 
                rCheck[index2] = false
            end
        end
        for i,val in next,rCheck do
            if not val then
                recipeBool = false 
                break
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
    for i,k in next,chestList do
        if k.name == itemID then
            if ( k.count >= currentCount) then
            print(itemID, currentCount,side)
                currentCount = currentCount - chest.pushItems(side,i,currentCount);
                break;
            else
                currentCount = currentCount - chest.pushItems(side,is);
            end
            
        end
    end
    return false
end
while true do
    local recipeCheck = checkRecipe(recipes,getContents(iChest))
    if recipeCheck then
        print(recipeCheck[2][1][1])
        rpushToChest(recipeCheck[2][1][1],recipeCheck[2][1][2],iChest,fCrafterSide);
        for i,val in next,recipeCheck[2] do
            if i == 1 then 
            print(val[1],val[2])
            rpushToChest(val[1][1],val[1][2],iChest,fCrafterSide);
                    
            else
            print(i,val[2])
            rpushToChest(val[1],val[2],iChest,oChestSide);
            end
        end
        while not(oChest.list()[1] == nil) do
            sleep(.25)
        end
        rs.setOutput("left",true);
        os.sleep(1);
        rs.setOutput("left",false);
        while (fCrafter.list()[2] == nil) do
            os.sleep(1)
        end
        print(recipeCheck[1],"succesfully crafted")
        rs.setOutput("front",true);
        os.sleep(1);
        rs.setOutput("front",false);
    end
end