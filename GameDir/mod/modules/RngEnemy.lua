--RngEnemy.lua
local this={}

local IsTypeTable = Tpp.IsTypeTable

local GetGameObjectId = GameObject.GetGameObjectId
local SendCommand = GameObject.SendCommand
local NULL_ID = GameObject.NULL_ID

function this.SetUpUnique(uniqueSetUpTable)
    if not IsTypeTable(uniqueSetUpTable) then
        return
    end
    for gameObjectName, uniqueTable in pairs(uniqueSetUpTable) do
        local gameObjectId = GetGameObjectId(gameObjectName)
        if gameObjectId==NULL_ID then
            InfCore.Log("RngEnemy: "..gameObjectName.." is NULL_ID!!!")
        else
            local isFemale=false
            if InfEneFova.IsFemaleFace(uniqueTable.faceId) then
                isFemale=true
            elseif IsTypeTable(uniqueTable.createFaceTable) then
                isFemale=(uniqueTable.createFaceTable.gender==TppDefine.QUEST_GENDER_TYPE.WOMAN)
            end
            SendCommand(gameObjectId,{id="SetHostage2Flag",flag="female",on=isFemale})
            --hostage2flags
            if IsTypeTable(uniqueTable.commands) then
                for i, command in ipairs(uniqueTable.commands) do
                    SendCommand(gameObjectId,command)
                end
            end
            if IsTypeTable(uniqueTable.staffParameter) then
                local staffParameter={
                    gameObjectId=gameObjectId,
                }
                staffParameter.staffTypeId=uniqueTable.staffParameter.staffTypeId
                staffParameter.skill=uniqueTable.staffParameter.skill
                staffParameter.staffType=uniqueTable.staffParameter.staffType
                staffParameter.uniqueTypeId=uniqueTable.staffParameter.uniqueTypeId
                TppMotherBaseManagement.RegenerateGameObjectStaffParameter(staffParameter)
            end
        end
    end
end

return this