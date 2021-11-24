bReader =  peripheral.wrap("left");
function getContents(chestData) 
    if chestData["Items"][0] == nil then
        return nil
    end
    local itemAmt = table.getn(chestData["Items"])
    local tempDict = {}
    for i=0,itemAmt do 
        local tString = chestData.Items[i].id
        if(tempDict[tString]) then
            tempDict[tString] = tempDict[tString] + chestData["Items"][i]["Count"]
        else
            tempDict[tString] = chestData["Items"][i]["Count"]
        end
    end
    return tempDict
end
local test = getContents(bReader.getBlockData())
table.getn(test)
for i in ipairs(test) do
    print(test[i])
end
print(test);