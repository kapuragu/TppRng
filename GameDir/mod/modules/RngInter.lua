--RngInter.lua
local this={}

local NULL_ID = GameObject.NULL_ID
local IsTypeTable = Tpp.IsTypeTable

function this.AddHighInterrogations(interrInfo)
    for cpId, cpTable in pairs(mvars.interTable) do
        if IsTypeTable(cpTable.layer) then
            for layerName, interList in pairs(cpTable.layer) do
                for i,addInterrInfo in pairs(interrInfo)do
                    for j,interrInfo in pairs(interList)do
                        if addInterrInfo.name==interrInfo.name then
                            if addInterrInfo.func==interrInfo.func then
                                local svarsName
                                if layerName=="high" then
                                    svarsName="InterrogationHigh"
                                else
                                    svarsName="InterrogationNormal"
                                end
                                local index=cpTable.index
                                local svarBitfield=svars[svarsName][index]
                                local bitshift=bit.lshift(1,j-1)
                                svars[svarsName][index]=bit.bor(svarBitfield,bitshift)
                                InfCore.Log("RngInter: added "..addInterrInfo.name.." from cp# "..tostring(cpId))
                            end
                        end
                    end
                end
            end
        end
    end
end

--like high but for all
function this.RemoveInterrogation(interrInfo)
    for cpId, cpTable in pairs(mvars.interTable) do
        if IsTypeTable(cpTable.layer) then
            for layerName, interList in pairs(cpTable.layer) do
                if IsTypeTable(interList) then
                    for i,addInterrInfo in pairs(interrInfo)do
                        for j,interrInfo in pairs(interList)do
                            if addInterrInfo.name==interrInfo.name then
                                if addInterrInfo.func==interrInfo.func then
                                    local svarsName
                                    if layerName=="high" then
                                        svarsName="InterrogationHigh"
                                    else
                                        svarsName="InterrogationNormal"
                                    end
                                    local index=cpTable.index
                                    local svarBitfield=svars[svarsName][index]
                                    local bitshift=bit.lshift(1,j-1)
                                    svars[svarsName][index]=bit.band(svarBitfield,bit.bnot(bitshift))
                                    InfCore.Log("RngInter: removed "..addInterrInfo.name.." from cp# "..tostring(cpId))
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

return this