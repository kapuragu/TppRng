--RngConfig.lua
local this={}

local StrCode32 = Fox.StrCode32
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local IsTypeNumber = Tpp.IsTypeNumber

function this.GetConfig()
    return this.config
end

function this.SetConfig(config)
    this.config=config
end

function this.GetSelectedLocationName()
    local config = this.GetConfig()
    local locationName = config.locationName
    return locationName
end

function this.GetSelectedLocationId()
    --WIP this config
    local locationName = this.GetSelectedLocationName()
    return TppDefine.LOCATION_ID[locationName]
end

function this.OnSelectedModules(func)
    local config = this.GetConfig()
    local selectLocationName = RngConfig.GetSelectedLocationName()
    local locModules = RngModules.GetModulesForLocation(selectLocationName)
    local areaModules = locModules.areas
    for areaName, areaTables in pairs(areaModules) do
        if config.areas[areaName] then
            local isDefault = (config.areas[areaName].default==true)
            if areaTables.default and isDefault then
                func(areaTables.default)
            end
            if areaTables.modules then
                for moduleName, moduleTables in pairs(areaTables.modules) do
                    local isModule = (config.areas[areaName].module==moduleName)
                    if isModule then
                        func(moduleTables)
                    end
                end
            end
        end
    end
end

function this.GetSelectedSoldierCount()
    local soldierCount =RngDefine.START_SOLDIER_STATE_COUNT
    local countSoldiers=function(moduleTables)
        soldierCount=soldierCount+this.CountSoldiers(moduleTables.soldierDefine)
    end
    this.OnSelectedModules(countSoldiers)
    return soldierCount
end

function this.GetSelectedHostageCount()
    local hostageCount =RngDefine.START_HOSTAGE_STATE_COUNT
    local countHostages=function(moduleTables)
        hostageCount=hostageCount+Rng.CountStringTable(moduleTables.hostageDefine)
    end
    this.OnSelectedModules(countHostages)
    return hostageCount
end

function this.GetSelectedVehicleCount()
    local vehicleCount =RngDefine.START_HOSTAGE_STATE_COUNT
    local countVehicles=function(moduleTables)
        vehicleCount=vehicleCount+this.CountVehicles(moduleTables.vehicleDefine)
    end
    this.OnSelectedModules(countVehicles)
    return vehicleCount
end

--count strings in keyed subtables
function this.CountSoldiers(soldierDefine)
    local soldierCount = 0
    if soldierDefine then
        for cpName, soldierTable in pairs(soldierDefine) do
            for key, value in pairs(soldierTable) do
                if IsTypeString(key) then
                    if TppEnemy.SOLDIER_DEFINE_RESERVE_TABLE_NAME[key] then
                        soldierDefine[cpName][key]=value
                    end
                elseif IsTypeString(value) then
                    soldierCount = soldierCount + 1
                end
            end
        end
    end
    return soldierCount
end

--count vehicles
function this.CountVehicles(vehicleDefine)
    local vehicleCount = 0
    if vehicleDefine then
        if vehicleDefine.instanceCount then
            vehicleCount = vehicleDefine.instanceCount
        end
    end
    return vehicleCount
end

--count indexed subtables or func return's indexed subtables
function this.CountTableFuncParams(f_uniqueSettings)
    local moduleUniqueSettingCount = 0
    if f_uniqueSettings then
        local uniqueSettingsT = f_uniqueSettings
        if IsTypeFunc(uniqueSettingsT) then
            uniqueSettingsT = uniqueSettingsT()
        end
        if IsTypeTable(uniqueSettingsT) then
            moduleUniqueSettingCount=#uniqueSettingsT
            InfCore.Log("RngConfig.DecideRng: module's table-func param count is: "..moduleUniqueSettingCount)
        end
    end
    return moduleUniqueSettingCount
end

function this.CheckModuleGameObjectCount(gameObjectCountTable,moduleTable)
    local gameObjectChecks={
        soldierCount={
            maxCount=RngDefine.MAX_SOLDIER_STATE_COUNT_EXT,
            moduleCount=this.CountSoldiers(moduleTable.soldierDefine),
        },
        hostageCount={
            maxCount=RngDefine.MAX_HOSTAGE_STATE_COUNT,
            moduleCount=Rng.CountStringTable(moduleTable.hostageDefine),
        },
        vehicleCount={
            maxCount=RngDefine.MAX_VEHICLE_STATE_COUNT,
            moduleCount=this.CountVehicles(moduleTable.vehicleDefine),
        },
        uniqueSettingsCount={
            maxCount=RngDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,
            moduleCount=this.CountTableFuncParams(moduleTable.uniqueSettings),
        },
        holdRecoveredCount={
            maxCount=RngDefine.MAX_HOLD_RECOVERED_STATE_COUNT,
            moduleCount=Rng.CountStringTable(moduleTable.registHoldRecoveredState),
        },
        vehicleBrokenCount = {
            maxCount=RngDefine.MAX_VEHICLE_BROKEN_STATE_COUNT,
            moduleCount=Rng.CountStringTable(moduleTable.registVehicleBrokenState),
        },
        enemyHeliCount = {
            maxCount=RngDefine.MAX_ENEMY_HELI_STATE_COUNT,
            moduleCount=this.CountSoldiers(moduleTable.enemyHeliDefine),
        },
        walkerGearCount = {
            maxCount=RngDefine.MAX_WALKER_GEAR_STATE_COUNT,
            moduleCount=Rng.CountStringTable(moduleTable.walkerGearDefine),
        },
        uavCount = {
            maxCount=RngDefine.MAX_UAV_COUNT,
            moduleCount=this.CountSoldiers(moduleTable.uavDefine),
        },
        securityCameraCount = {
            maxCount=RngDefine.MAX_SECURITY_CAMERA_COUNT,
            moduleCount=this.CountSoldiers(moduleTable.securityCameraDefine),
        },
        searchTargetCount = {
            maxCount=RngDefine.MAX_SEARCH_TARGET_COUNT,
            moduleCount=this.CountTableFuncParams(moduleTable.setUpSearchTarget),
        },
    }
    for countName, countTable in pairs(gameObjectChecks) do
        if gameObjectCountTable[countName] then
            if gameObjectCountTable[countName] + countTable.moduleCount > countTable.maxCount then
                return false
            end
        end
    end
    return true
end

function this.AddModuleGameObjectCounts(gameObjectCountTable,moduleTable)
    local moduleCounts={
        soldierCount=this.CountSoldiers(moduleTable.soldierDefine),
        hostageCount=Rng.CountStringTable(moduleTable.hostageDefine),
        vehicleCount=this.CountVehicles(moduleTable.vehicleDefine),
        uniqueSettingsCount=this.CountTableFuncParams(moduleTable.uniqueSettings),
        holdRecoveredCount=Rng.CountStringTable(moduleTable.registHoldRecoveredState),
        vehicleBrokenCount=Rng.CountStringTable(moduleTable.registVehicleBrokenState),
        enemyHeliCount=this.CountSoldiers(moduleTable.enemyHeliDefine),
        walkerGearCount=Rng.CountStringTable(moduleTable.walkerGearDefine),
        uavCount=this.CountSoldiers(moduleTable.uavDefine),
        securityCameraCount=this.CountSoldiers(moduleTable.securityCameraDefine),
        searchTargetCount=this.CountTableFuncParams(moduleTable.setUpSearchTarget),
    }
    for countName, countNumAdd in pairs(moduleCounts) do
        if gameObjectCountTable[countName] then
            gameObjectCountTable[countName] = gameObjectCountTable[countName] + countNumAdd
        end
    end
    return gameObjectCountTable
end

function this.TableRandomKey(T)
    local randomKey
    local keyPool = {}
    for k, v in pairs(T) do
        if not randomKey then
            randomKey=k
        end
        table.insert(keyPool,k)
    end
    local rnd = math.random(1,#keyPool)
    randomKey=keyPool[rnd]
    return randomKey
end

function this.SetRandomLocation()
    local modules = RngModules.GetModules()
    local locationName = this.TableRandomKey(modules)
    this.UpdateLocation(locationName)
    InfCore.Log("RngConfig: Location is "..locationName)
    return locationName
end

function this.OnFadeOutDirect(msgName)
    if msgName=="OnEstablishMissionClearFadeOut" then
        if gvars.mis_nextMissionCodeForMissionClear~=RngDefine.rngMissionId then
            return
        end
    elseif msgName=="RestartMissionFadeOutFinish" then
        if vars.missionCode~=RngDefine.rngMissionId then
            return
        end
        mvars.rng_isRestartMission=true
    elseif msgName=="ContinueFromCheckPoint" then
        if not TppMission.IsHelicopterSpace(vars.missionCode) and gvars.title_nextMissionCode~=RngDefine.rngMissionId then
            return
        end
        mvars.rng_isContinueFromTitle=true
    else
        return
    end
    this.DecideRng()
end

function this.OnFadeInDirect(msgName)
    if msgName=="FadeInOnStartTitle" then
        if gvars.title_nextMissionCode~=RngDefine.rngMissionId then
            return
        else
            InfMain.abortToAcc=true
        end
    else
        return
    end
end

function this.DecideDropRoute()
    local helicopterRouteList={}
    local dropRoutesCollect=function(moduleTables)
        if moduleTables.helicopterRouteList then
            Rng.AppendArrayU(helicopterRouteList,moduleTables.helicopterRouteList)
        end
    end
    this.OnSelectedModules(dropRoutesCollect)
    InfCore.PrintInspect(helicopterRouteList,"helicopterRouteList")
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    local groundStartPosition
    local startOnFoot=true
    if #helicopterRouteList>0 then
        local dropRoute = helicopterRouteList[math.random(1,#helicopterRouteList)]
        InfCore.Log("RngConfig: Start route is "..tostring(dropRoute))
        if IsTypeString(dropRoute) then
            TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
            local dropRouteS32 = StrCode32(dropRoute)
            local isAssaultLz=TppLandingZone.IsAssaultDropLandingZone(dropRouteS32)
            groundStartPosition=InfLZ.GetGroundStartPosition(dropRouteS32)
            startOnFoot=groundStartPosition and InfMain.IsStartOnFoot(RngDefine.rngMissionId,isAssaultLz)
            gvars.heli_missionStartRoute=dropRouteS32
            InfCore.Log("RngConfig: DecideDropRoute startOnFoot="..tostring((groundStartPosition~=nil))..","..tostring(InfMain.IsStartOnFoot(RngDefine.rngMissionId,isAssaultLz)))
        elseif IsTypeTable(dropRoute) then
            if dropRoute.pos then
                groundStartPosition=dropRoute
            end
        end
        if startOnFoot then
            TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
            igvars.mis_isGroundStart=true
            if groundStartPosition then
                local pos=groundStartPosition.pos
                local rotY=groundStartPosition.rotY or 0--tex TODO: RETRY: fill out, or tocenter or to closest
                mvars.mis_helicopterMissionStartPosition=pos
                TppPlayer.SetInitialPosition(pos,rotY)
                TppPlayer.SetMissionStartPosition(pos,rotY)
            end
        end
    end
end

function this.RandomSetToSavedSeed()
    local seed = Ivars.rngMissionSeed:Get()
    InfCore.Log("RngConfig: RandomSetToSavedSeed:"..tostring(seed))--DEBUG
    InfCore.Log("caller:"..InfCore.DEBUG_Where(2))--DEBUG
    math.randomseed(seed)
    math.random()
    math.random()
    math.random()
end

function this.SaveSeed()
    local seed = igvars.inf_levelSeed
    Ivars.rngMissionSeed:Set(seed)
    InfCore.Log("RngConfig: SaveSeed:"..tostring(seed))
end

function this.GetRouteGroupsForExclusion(routeGroupName)
    local compStrings={routeGroupName}
    local splitString=InfUtil.Split(routeGroupName,"_")
    if #splitString>1 then
        local lrrpStr="lrrp"
        local rpStr="rp"
        local inStr="in"
        local outStr="out"
        if splitString[1]==lrrpStr or splitString[1]==rpStr then
            local splitLrrpStr=InfUtil.Split(splitString[2],"to")
            if #splitLrrpStr==2 then
                local lrrpNums={
                    tonumber(splitLrrpStr[2]),
                    tonumber(splitLrrpStr[1]),
                }
                local otherRouteGroup=string.format("%s_%02dto%02d",splitString[1],lrrpNums[1],lrrpNums[2])
                table.insert(compStrings,otherRouteGroup)
            end
        elseif splitString[1]==inStr or splitString[1]==outStr then
            local compStr=splitString[1]
            if compStr==inStr then
                compStr=outStr
            elseif compStr==outStr then
                compStr=inStr
            end
            for j=2,#splitString do
                compStr=string.format("%s_%s",compStr,splitString[j])
            end
            if compStr~=routeGroupName then
                table.insert(compStrings,compStr)
            end
        end
    end
    InfCore.PrintInspect(compStrings,"RngConfig.GetRouteGroupsForExclusion")
    return compStrings
end

function this.CheckModuleTravelReserve(moduleTable,reservedTravelPlans)
    local mdlTrvlPlns={}
    if moduleTable.reservedTravelPlans then
        for travelPlanName, travelPlanDefine in pairs(moduleTable.reservedTravelPlans) do
            for travelStepIndex, trvlRtGrpDef in ipairs(travelPlanDefine) do
                if IsTypeString(trvlRtGrpDef.cp) then
                    if not mdlTrvlPlns[trvlRtGrpDef.cp] then
                        mdlTrvlPlns[trvlRtGrpDef.cp]={}
                    end
                    if IsTypeTable(trvlRtGrpDef.routeGroup) then
                        if IsTypeString(trvlRtGrpDef.routeGroup[1]) then
                            if not mdlTrvlPlns[trvlRtGrpDef.cp][trvlRtGrpDef.routeGroup[1] ] then
                                mdlTrvlPlns[trvlRtGrpDef.cp][trvlRtGrpDef.routeGroup[1] ]={}
                            end
                            if IsTypeString(trvlRtGrpDef.routeGroup[2]) then
                                if not (trvlRtGrpDef.routeGroup[1]=="travel" and trvlRtGrpDef.routeGroup[2]=="lrrpHold") then
                                    local compStrings=this.GetRouteGroupsForExclusion(trvlRtGrpDef.routeGroup[2])
                                    Rng.AppendArrayU(mdlTrvlPlns[trvlRtGrpDef.cp][trvlRtGrpDef.routeGroup[1] ],compStrings)
                                    if reservedTravelPlans[trvlRtGrpDef.cp] then
                                        if reservedTravelPlans[trvlRtGrpDef.cp][trvlRtGrpDef.routeGroup[1] ] then
                                            for i, compString in ipairs(compStrings) do
                                                if Rng.ArrayContains(reservedTravelPlans[trvlRtGrpDef.cp][trvlRtGrpDef.routeGroup[1] ],compString) then
                                                    InfCore.Log("RngConfig.CheckModuleTravelReserve: Travel plan "..travelPlanName.." from "..moduleTable.name.." has already been reserved")
                                                    InfCore.Log("RngConfig.CheckModuleTravelReserve: route group "..trvlRtGrpDef.routeGroup[1].."/"..compString..", cancelling")
                                                    return false
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return mdlTrvlPlns
end

function this.SetConfigAreaModules(moduleTable,areaTables,countTable,reservedTravelPlans,isDefault)
    local configArea
    local moduleName = moduleTable.name
    local needDefault = (moduleTable.needDefault or false)
    local excludeDefault = (moduleTable.excludeDefault or false)
    local addDefault = true
    local moduleAccept = false
    
    --check gameobject counts for overflow
    local checkModuleCount=this.CheckModuleGameObjectCount(countTable,moduleTable)
    if checkModuleCount then
        InfCore.Log("RngConfig.SetConfigAreaModules: Counts seem ok, adding "..moduleName)
        if not needDefault or isDefault then
            moduleAccept=true
            InfCore.Log("RngConfig.SetConfigAreaModules: Default module not needed, adding "..moduleName)
        else
            if not excludeDefault then
                local checkNeededDefaultCount = this.CheckModuleGameObjectCount(countTable,areaTables.default)
                if checkNeededDefaultCount then
                    moduleAccept=true
                    addDefault=true
                    InfCore.Log("RngConfig.SetConfigAreaModules: Will add "..moduleName.."'s needed default module")
                else
                    moduleAccept=false
                    addDefault=false
                    InfCore.Log("RngConfig.SetConfigAreaModules: Not adding "..moduleName.."'s needed default module")
                end
            else
                moduleAccept=true
                addDefault=false
                InfCore.Log("RngConfig.SetConfigAreaModules: Default excluded by "..moduleName..", not adding default")
            end
        end
    else
        moduleAccept=false
        InfCore.Log("RngConfig.SetConfigAreaModules: Counts suck, not adding "..moduleName)
    end
    
    if moduleAccept then
        local mdlTrvlPlns=this.CheckModuleTravelReserve(moduleTable,reservedTravelPlans)
        if mdlTrvlPlns then
            for cpName, trvlRtGrpDef in pairs(mdlTrvlPlns) do
                if not reservedTravelPlans[cpName] then
                    reservedTravelPlans[cpName]=mdlTrvlPlns[cpName]
                else
                    for routeGroupTypeName, routeGroupList in pairs(trvlRtGrpDef) do
                        if not reservedTravelPlans[cpName][routeGroupTypeName] then
                            reservedTravelPlans[cpName][routeGroupTypeName]=routeGroupList
                        else
                            Rng.AppendArrayU(reservedTravelPlans[cpName][routeGroupTypeName],routeGroupList)
                        end
                    end
                end
            end
            InfCore.PrintInspect(mdlTrvlPlns,"RngConfig.SetConfigAreaModules: "..moduleName.." mdlTrvlPlns")
            InfCore.PrintInspect(reservedTravelPlans,"RngConfig.SetConfigAreaModules: "..moduleName.." reservedTravelPlans")
        else
            moduleAccept=false
            InfCore.Log("RngConfig.SetConfigAreaModules: Didn't select "..moduleName.." due to travel plan reservation")
        end
    end
    
    if addDefault or (isDefault and moduleAccept) then
        configArea={}
        configArea.default=true
    end
    if moduleAccept then
        configArea=configArea or{}
        if not isDefault then
            configArea.module=moduleName
            InfCore.Log("RngConfig.SetConfigAreaModules: Selected "..moduleName)
            InfCore.PrintInspect(configArea,"RngConfig.SetConfigAreaModules: "..moduleName.." configArea")
        end
    end
    return configArea
end

--decide rng here
function this.DecideRng()
    if mvars.rng_isRestartMission and not Rng.IsRestartReshuffle() then
        mvars.rng_isRestartMission=nil
        if this.GetConfig()~=nil then
            return
        end
    end

    local config={}

    if mvars.rng_isContinueFromTitle then
        this.RandomSetToSavedSeed()
        mvars.rng_isContinueFromTitle=nil
    else
        this.SaveSeed()
    end

    --decide location
    local locationName=TppPackList.GetLocationNameFormMissionCode(RngDefine.rngMissionId)
    locationName=this.SetRandomLocation()
    vars.locationCode=TppDefine.LOCATION_ID[locationName]
    mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[locationName]
    config.locationName=locationName

    local modules = RngModules.GetModulesForLocation(locationName)
    local areaModules = modules.areas
    local countTable = {
        soldierCount = RngDefine.START_SOLDIER_STATE_COUNT,
        hostageCount = RngDefine.START_HOSTAGE_STATE_COUNT,
        vehicleCount = RngDefine.START_VEHICLE_STATE_COUNT,
        uniqueSettingsCount = RngDefine.START_UNIQUE_SETTING_COUNT,
        holdRecoveredCount = RngDefine.START_HOLD_RECOVERED_STATE_COUNT,
        vehicleBrokenCount = RngDefine.START_VEHICLE_BROKEN_STATE_COUNT,
        enemyHeliCount = RngDefine.START_ENEMY_HELI_STATE_COUNT,
        walkerGearCount = RngDefine.START_WALKER_GEAR_STATE_COUNT,
        uavCount = RngDefine.START_UAV_STATE_COUNT,
        securityCameraCount = RngDefine.START_SECURITY_CAMERA_COUNT,
        searchTargetCount = RngDefine.START_SEARCH_TARGET_COUNT,
    }
    local reservedTravelPlans={}

    config.areas={}
    local objectiveModulesReqCnt=1
    local depthDef={
        {
            cnt=objectiveModulesReqCnt,
            func=function(moduleTable,areaTables,isDefault)
                return not isDefault and (moduleTable.need==nil) and (moduleTable.defaultObjectives and moduleTable.clearObjectiveName)
            end,
        },
        {
            func=function(moduleTable,areaTables,isDefault)
                return moduleTable.need==nil
            end,
        },
        {
            func=function(moduleTable,areaTables,isDefault)
                local acceptModule=false
                if moduleTable.need then
                    local moduleNeeds=moduleTable.need
                    if not IsTypeTable(moduleNeeds) then
                        moduleNeeds={moduleNeeds}
                    end
                    InfCore.PrintInspect(moduleNeeds,"moduleNeeds")
                    acceptModule=true
                    for i, moduleNeed in ipairs(moduleNeeds) do
                        if not areaTables.name==moduleNeed then
                            if not IsTypeTable(config.areas[moduleNeed]) then
                                acceptModule=false
                                InfCore.Log("Default needed module doesn't have "..moduleNeed.." in the config, not adding module")
                                break
                            else
                                if not config.areas[moduleNeed].default then
                                    acceptModule=false
                                    InfCore.Log("Default needed module "..moduleNeed.." not set in the config, not adding module")
                                    break
                                end
                            end
                        end
                    end
                end
                return acceptModule
            end,
        },
    }
    for depthIndex, depthTable in pairs(depthDef) do
        InfCore.Log("RngConfig.DecideRng: depthIndex #"..tostring(depthIndex).." start")
        local cnt = depthTable.cnt
        local cntIndex = 1

        local areaNames=InfUtil.ShuffleBag:New()
        for areaName, areaTables in pairs(areaModules) do
            areaNames:Add(areaName)
        end
        local numAreaNames=areaNames:Count()
        for areaIndex=1,numAreaNames do
            if IsTypeNumber(cnt) then
                if cntIndex>cnt then
                    break
                end
            end
            local areaName = areaNames:Next()
            InfCore.Log(areaName)
            if not config.areas[areaName] then
                local areaTables = areaModules[areaName]
                local moduleNames=InfUtil.ShuffleBag:New()
                local moduleAccept = true
                if areaTables.modules then
                    for moduleName, moduleTable in pairs(areaTables.modules) do
                        moduleNames:Add(moduleName)
                    end
                    local numModuleNames=moduleNames:Count()
                    for moduleIndex=1,numModuleNames do
                        if IsTypeNumber(cnt) then
                            if cntIndex>cnt then
                                break
                            end
                        end
                        local moduleName = moduleNames:Next()
                        InfCore.Log(moduleName)
                        local moduleTable = areaTables.modules[moduleName]
                        if depthTable.func then
                            if not depthTable.func(moduleTable,areaTables,false) then
                                moduleAccept = false
                            end
                        end
                        if moduleAccept then
                            if config.areas[areaName]==nil then
                                config.areas[areaName]=this.SetConfigAreaModules(moduleTable,areaTables,countTable,reservedTravelPlans,false)
                                if config.areas[areaName]~=nil then
                                    if config.areas[areaName].module~=nil then
                                        countTable = this.AddModuleGameObjectCounts(countTable,moduleTable)
                                        if IsTypeNumber(cnt) then
                                            cntIndex=cntIndex+1
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if depthTable.func then
                    if not depthTable.func(areaTables.default,areaTables,true) then
                        moduleAccept = false
                    end
                end
                if moduleAccept and config.areas[areaName]==nil then
                    config.areas[areaName]=this.SetConfigAreaModules(areaTables.default,areaTables,countTable,reservedTravelPlans,true)
                    if config.areas[areaName]~=nil then
                        if config.areas[areaName].default then
                            countTable = this.AddModuleGameObjectCounts(countTable,areaTables.default)
                        end
                    end
                end
                if IsTypeNumber(cnt) then
                    if cntIndex>cnt then
                        break
                    end
                end
                InfCore.PrintInspect(countTable,"RngConfig.DecideRng: countTable")
            end
        end
        InfCore.PrintInspect(config,"RngConfig.DecideRng: depthIndex #"..tostring(depthIndex).." config")
    end
    --save config
    this.SetConfig(config)
    InfCore.PrintInspect(countTable,"RngConfig.DecideRng: countTable")
    InfCore.PrintInspect(config,"RngConfig.DecideRng: config")
    InfCore.PrintInspect(reservedTravelPlans,"RngConfig.DecideRng: reservedTravelPlans")

    this.DecideDropRoute()
    InfMain.RandomResetToOsTime()
end

function this.UpdateLocation(newLocationName)
    --patch LOCATION_HAVE_MISSION_LIST to remove mission from original location and move to new location
    local locationName = string.upper(newLocationName)
    local LOCATION_HAVE_MISSION_LIST = TppDefine.LOCATION_HAVE_MISSION_LIST
    --remove
    for locName, missionTable in pairs(TppDefine.LOCATION_HAVE_MISSION_LIST) do
        for index, missionCode in ipairs(missionTable) do
            if missionCode == RngDefine.rngMissionId then
                table.remove(LOCATION_HAVE_MISSION_LIST[locName],index)
            end
        end
    end
    --add
    InfUtil.InsertUniqueInList(LOCATION_HAVE_MISSION_LIST[locationName],RngDefine.rngMissionId)
    TppDefine.LOCATION_HAVE_MISSION_LIST=LOCATION_HAVE_MISSION_LIST
    InfCore.PrintInspect(TppDefine.LOCATION_HAVE_MISSION_LIST,"TppDefine.LOCATION_HAVE_MISSION_LIST")
end

function this.PostAllModulesLoad(isReload)
    if isReload then
        --this.SetConfig(nil)
        --mvars.rng_isContinueFromTitle=true
    end
end

return this