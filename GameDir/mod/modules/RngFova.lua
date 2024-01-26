--RngFova.lua
local this={}
local IsTypeTable=Tpp.IsTypeTable

--TppEneFova (external lua)
this.fovaSetupFunc=function(locationName,missionId)
    local selectLocationName = RngConfig.GetSelectedLocationName()
    local locModules = RngModules.GetModulesForLocation(selectLocationName)

    local missionHostageInfos = {}
    local hostageCount = RngDefine.START_HOSTAGE_STATE_COUNT
    local countHostages = function(moduleTables)
        if moduleTables.hostageDefine then
            hostageCount = hostageCount + Rng.CountStringTable(moduleTables.hostageDefine)
        end
    end
    RngConfig.OnSelectedModules(countHostages)

    missionHostageInfos.count=hostageCount
    missionHostageInfos.lang=RngDefine.HOS_LANG.LOCATION
    
    InfCore.PrintInspect(missionHostageInfos,"RngFova missionHostageInfos")
    TppEneFova.missionHostageInfos[missionId]=missionHostageInfos

    local npcTable = locModules.npc
    if npcTable then
        for gameObjectType, gameObjectTable in pairs(npcTable) do
            if gameObjectTable.fovaSetupFunc then
                gameObjectTable.fovaSetupFunc(locationName,missionId)
            end
        end
    end
    local fovaSetupModuleFunc = function(moduleTables)
        if moduleTables.fovaSetupFunc then
            moduleTables.fovaSetupFunc(locationName,missionId)
        end
    end
    RngConfig.OnSelectedModules(fovaSetupModuleFunc)
    --TppEneFova.fovaSetupFuncs[string.lower(selectLocationName)](locationName,missionId)
end

function this.CreateFace(createParams)
    createParams.count=1
    local faceIds=this.CreateFaceTable(createParams)
    return faceIds[1]
end

function this.CreateFaceTable(createParams)
    InfCore.PrintInspect(createParams,"RngFova: createParams")
    local faceIds={}
    local count=createParams.count
    local gender=createParams.gender
    if not IsTypeTable(createParams.race) then
        createParams.race={createParams.race}
    end
    local createFaceTable={
        race=createParams.race,
        gender=gender,
        needCount=count,
        maxUsedFovaCount=count,
        seed=gvars.hosface_groupNumber
    }
    InfCore.PrintInspect(createFaceTable,"RngFova: createFaceTable")
    local createdFaceIds = TppSoldierFace.CreateFaceTable(createFaceTable)
    if createdFaceIds==nil then
        if gender==TppDefine.QUEST_GENDER_TYPE.MAN then
            for i=1, count do
                faceIds[i]=TppDefine.QUEST_FACE_ID_LIST.DEFAULT_MAN
            end
        elseif gender==TppDefine.QUEST_GENDER_TYPE.WOMAN then
            for i=1, count do
                faceIds[i]=TppDefine.QUEST_FACE_ID_LIST.DEFAULT_WOMAN
            end
        end
    else
        --non-unique
        for n,faceId in ipairs(createdFaceIds)do
            table.insert(faceIds,faceId)
        end
    end
    InfCore.PrintInspect(faceIds,"RngFova: face")
    return faceIds
end

function this.GetUniqueSetting(setUpUniqueTable)
    local settings={}
    for locatorName, uniqueTable in pairs(setUpUniqueTable) do
        local setting={}
        local faceId=uniqueTable.faceId
        if uniqueTable.race or uniqueTable.gender then
            local createFaceTable={
                race=uniqueTable.race or TppDefine.QUEST_RACE_TYPE.CAUCASIAN,
                gender=uniqueTable.gender or TppDefine.QUEST_GENDER_TYPE.MAN
            }
            faceId=RngFova.CreateFace(createFaceTable)
        end
        setting.faceId=faceId or TppDefine.QUEST_FACE_ID_LIST.DEFAULT_MAN
        setting.name=locatorName
        setting.type=uniqueTable.type
        setting.bodyId=uniqueTable.bodyId
        table.insert(settings,setting)
    end
    return settings
end

return this