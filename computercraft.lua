bReader =  peripheral.wrap("left");
function getContents(chestData) 
    if chestData["Items"][0] == nil then
        return nil
    end
    local itemAmt = table.getn(chestData["Items"])
    local tempDict = {}
    for i=0,itemAmt do 
        if(tempDict[chestData["Items"][i]["id"]]) then
            tempDict[chestData["Items"][i]["id"]] = tempDict[chestData["Items"][i]["id"]] + chestData["Items"][i]["count"]
        else
        tempDict[chestData["Items"][i]["id"]] = chestData["Items"][i]["count"]
        end
    end
    return tempDict
end
local test = getContents(bReader.getBlockData())
table.getn(test)
for i in ipairs(test) do
    print test[i]
end
print(test);