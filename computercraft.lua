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
            {"draconicevolution:awakened_draconium_block",1}
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
    ,
    {"draconicevolution:chaotic_core",
        {
            {"draconicevolution:large_chaos_frag",1}
            ,
            {"draconicevolution:large_chaos_frag",5}
            ,
            {"draconicevolution:awakened_core",4}
            ,
            {"draconicevolution:awakened_draconium_ingot",4} 
        }
    }
    ,
    {"draconicevolution:chaotic_core",
        {
            {"draconicevolution:large_chaos_frag",1}
            ,
            {"draconicevolution:large_chaos_frag",5}
            ,
            {"draconicevolution:awakened_core",4}
            ,
            {"draconicevolution:awakened_draconium_ingot",4} 
        }
    }
    ,
    {"solarflux:sp_de.chaotic",
        {
            {"draconicevolution:chaotic_core",1}
            ,
            {"draconicevolution:awakened_core",4}
            ,
            {"solarflux:sp_de.draconic",4}
        }
    }
    ,
    {"draconicevolution:reactor_core",
        {
            {"draconicevolution:chaos_shard",1}
            ,
            {"draconicevolution:awakened_draconium_ingot",4}
            ,
            {"draconicevolution:large_chaos_frag",2}
        }
    }
    ,
    {"draconicevolution:reactor_stabilizer",
        {
            {"draconicevolution:reactor_prt_stab_frame",1}
            ,
            {"draconicevolution:chaotic_core",1}
            ,
            {"draconicevolution:reactor_prt_rotor_full",1}
            ,
            {"draconicevolution:reactor_prt_focus_ring",1}
            ,
            {"draconicevolution:awakened_draconium_ingot",3}
            ,
            {"draconicevolution:draconic_energy_core",1}
            ,
            {"draconicevolution:large_chaos_frag",1}
        }
    }
    ,
    {"draconicevolution:reactor_injector",
        {
            {"draconicevolution:wyvern_core",1}
            ,
            {"draconicevolution:reactor_prt_in_rotor",4}
            ,
            {"draconicevolution:draconium_ingot",4}
            ,
            {"minecraft:iron_ingot",2}
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
                recipeBool = false; 
                break;
            end
            recipeBool = true;
        end    
        if recipeBool then
        print("recipe detected: ",recipe[1])
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
                print("Pushed "currentCount, itemID,side)
                currentCount = currentCount - chest.pushItems(side,i,currentCount);
                break;
            else
                print("Pushed "currentCount, itemID,side)
                currentCount = currentCount - chest.pushItems(side,i);
            end
            
        end
    end
    return false
end
while true do
    local recipeCheck = checkRecipe(recipes,getContents(iChest))
    if recipeCheck then
        rs.setOutput("back",true)
        rpushToChest(recipeCheck[2][1][1],recipeCheck[2][1][2],iChest,fCrafterSide);
        for i,val in next,recipeCheck[2] do
            if i == 1 then 
            rpushToChest(val[1][1],val[1][2],iChest,fCrafterSide);

            else

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
        print("succesfully crafted: ",recipeCheck[1])
        rs.setOutput("front",true);
        os.sleep(0.25);
        rs.setOutput("front",false);
    else
    rs.setOutput("back",false)
    end
end