bReader =  peripheral.wrap("left");
function getContents(chestData,invTag1,invTag2) 
    if not invTag2 then
    invData = chestData[invTag1][invTag2]
    else
    invData = chestData[invTag1]
    end
    if invData[0] == nil then
        return nil
    end
    local itemAmt = table.getn(invData)
    local tempDict = {}
    for i=0,itemAmt do 
        local tString = invData[i].id
        if(tempDict[tString]) then
            tempDict[tString] = tempDict[tString] + invData[i]["Count"]
        else
            tempDict[tString] = invData[i]["Count"]
        end
    end
    return tempDict
end
local test = getContents(bReader.getBlockData())
print(table.getn(test))
for i in ipairs(test) do
    print(test[i])
end
print(test);