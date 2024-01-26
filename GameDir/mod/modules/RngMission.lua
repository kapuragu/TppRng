--JUST ANOTHER DAY IN A WAR WITHOUT END...
local this={}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local MergeTable = Tpp.MergeTable
local ApendArray = Tpp.ApendArray

local SendCommand = GameObject.SendCommand
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID
local GetTypeIndex = GameObject.GetTypeIndex

--In-mission messages

this.CommonMessages=function()
    return StrCode32Table{
        --for reshuffle
        UI = {
            {
                msg="GameOverRestart",
                func=function()
                    mvars.rng_isRestartMission=true
                    RngConfig.DecideRng()
                end,
                option={isExecGameOver=true},
            },
        },
    }
end

function this.EnableMarker(markerName,markerTable)
    TppMarker.Enable(markerName,markerTable.radiusLevel,markerTable.goalType,markerTable.viewType,markerTable.randomLevel,markerTable.setImportant,markerTable.setNew,markerTable.mapRadioName,markerTable.langId,markerTable.goalLangId,markerTable.setInterrogation)
end

function this.OnObjectiveClear()
    if this.IsAllObjectivesClear() then
        TppSequence.SetNextSequence("Seq_Game_Escape")
    else
        local radios={
            "f1000_rtrg1640", --That's the way! // Flawless work. You never cease to amaze, Boss.// Nice work. Keep it up. // Nice work. // Good work.
            "f1000_rtrg1641", --・Complimenting player on his skill Flawless work. You never cease to amaze, Boss. // Good work. // Great.
            "f1000_rtrg1647", --・General-purpose congratulatory remarks  Great job. Nice going, Boss. You're pretty good. 
        }
        TppRadio.Play(radios[math.random(1,#radios)])
    end
end

function this.IsAllObjectivesClear()
    local clearObjectives={}
    local clearObjectivesCollect = function(moduleTables)
        if moduleTables.clearObjectiveName then
            for index, objectiveName in ipairs(moduleTables.clearObjectiveName) do
                clearObjectives[#clearObjectives+1]=objectiveName
            end
        end
    end
    RngConfig.OnSelectedModules(clearObjectivesCollect)
    for index, objectiveName in ipairs(clearObjectives) do
        if TppMission.IsEnableMissionObjective(objectiveName)==false then
            return false
        end
    end
    return true
end

function this.GetHighestEntityCount(maxCountTable, entityCount)
    local ret=entityCount
    for index, totalCount in ipairs(maxCountTable) do
        if ret<totalCount then
            ret=totalCount
            break
        end
    end
    InfCore.Log("RngMission: Highest entity count: "..entityCount.." state count: "..ret)
    return ret
end

--Sequence

function this.SequenceMissionPrepare()
    local systemCallbackTable={}
    
    systemCallbackTable.OnEstablishMissionClear = function( missionClearType )
        InfCore.Log("*** " .. missionClearType .. " OnEstablishMissionClear ***")

        local callbackOnEstablishMissionClearCollect = function(moduleTables)
            if moduleTables.systemCallbackTable then
                if moduleTables.systemCallbackTable.OnEstablishMissionClear then
                    moduleTables.systemCallbackTable.OnEstablishMissionClear(missionClearType)
                end
            end
        end
        RngConfig.OnSelectedModules(callbackOnEstablishMissionClearCollect)

        if missionClearType == TppDefine.MISSION_CLEAR_TYPE.ON_FOOT then
            TppPlayer.PlayMissionClearCamera()
            TppMission.MissionGameEnd{
                loadStartOnResult = true,
                fadeDelayTime = TppPlayer.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME,
                delayTime = TppPlayer.MISSION_CLEAR_CAMERA_DELAY_TIME,
            }
        elseif missionClearType == TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER then
            TppMission.MissionGameEnd{
                loadStartOnResult = true,
                delayTime = 5,
            }
        else
            TppMission.MissionGameEnd{ loadStartOnResult = true }
        end
    end
    
    systemCallbackTable.OnDisappearGameEndAnnounceLog = function( missionClearType )
        InfCore.Log("*** " .. missionClearType .. " OnDisappearGameEndAnnounceLog ***")

        local callbackOnDisappearGameEndAnnounceLogCollect = function(moduleTables)
            if moduleTables.systemCallbackTable then
                if moduleTables.systemCallbackTable.OnDisappearGameEndAnnounceLog then
                    moduleTables.systemCallbackTable.OnDisappearGameEndAnnounceLog(missionClearType)
                end
            end
        end
        RngConfig.OnSelectedModules(callbackOnDisappearGameEndAnnounceLogCollect)

        TppMission.ShowMissionResult()
    end
    
    systemCallbackTable.OnFinishBlackTelephoneRadio = function( missionClearType )
        InfCore.Log("*** " .. missionClearType .. " OnFinishBlackTelephoneRadio ***")

        local callbackOnFinishBlackTelephoneRadioCollect = function(moduleTables)
            if moduleTables.systemCallbackTable then
                if moduleTables.systemCallbackTable.OnFinishBlackTelephoneRadio then
                    moduleTables.systemCallbackTable.OnFinishBlackTelephoneRadio(missionClearType)
                end
            end
        end
        RngConfig.OnSelectedModules(callbackOnFinishBlackTelephoneRadioCollect)

        if not gvars.needWaitMissionInitialize then
            this.ShowMissionReward()
        end
    end

    local callbackCollect = function(moduleTables)
        if moduleTables.systemCallbackTable then
            for systemCallbackName, systemCallbackFunc in pairs(moduleTables.systemCallbackTable) do
                if not systemCallbackTable[systemCallbackName] then
                    systemCallbackTable[systemCallbackName]=function(...)
                        local ret
                        local found=false
                        local callbackArgs={...}
                        local callbackExecute = function(_moduleTables)
                            if _moduleTables.systemCallbackTable then
                                if _moduleTables.systemCallbackTable[systemCallbackName] then
                                    InfCore.Log("RngMission: Execute system callback")
                                    ret = _moduleTables.systemCallbackTable[systemCallbackName](unpack(callbackArgs))
                                    found=true
                                end
                            end
                        end
                        RngConfig.OnSelectedModules(callbackExecute)
                        if found then
                            if ret==nil then
                            else
                                InfCore.Log("RngMission: "..systemCallbackName.." returned "..tostring(ret))
                                return ret
                            end
                        end
                    end
                end
            end
        end
    end
    RngConfig.OnSelectedModules(callbackCollect)
    
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)

    local modules = RngModules.GetModulesForLocation(RngConfig.GetSelectedLocationName())
    if modules.npc then
        for gameObjectType, gameObjectTable in pairs(modules.npc) do
            if gameObjectTable.MissionPrepare then
                gameObjectTable.MissionPrepare()
            end
        end
    end

    local setUpSearchTarget={}
    local missionPrepareCollect = function(moduleTables)
        if moduleTables.MissionPrepare then
            moduleTables.MissionPrepare()
        end
        if moduleTables.setUpSearchTarget then
            local newSearchTargets = Rng.GetTableFuncParamTable(moduleTables.setUpSearchTarget)
            if (#setUpSearchTarget+#newSearchTargets)<=RngDefine.MAX_SEARCH_TARGET_COUNT then
                Tpp.ApendArray(setUpSearchTarget,newSearchTargets)
            end
        end
    end
    RngConfig.OnSelectedModules(missionPrepareCollect)
    
    if #setUpSearchTarget>0 then
        TppMarker.SetUpSearchTarget(setUpSearchTarget)
    end

    if modules.common then
        if modules.common.MissionPrepare then
            modules.common.MissionPrepare()
        end
    end
end

function this.SequenceOnRestoreSVars()
    local restoreSvarsCollect = function(moduleTables)
        if TppMission.IsMissionStart() then
            if moduleTables.soldierDefine then
                for cpName, soldierList in pairs(moduleTables.soldierDefine) do
                    TppInterrogation.ResetFlagNormal(GetGameObjectId(cpName))
                end
            end
        end
        if moduleTables.OnRestoreSVars then
            moduleTables.OnRestoreSVars()
        end
    end
    RngConfig.OnSelectedModules(restoreSvarsCollect)
end

function this.SequenceDeclareSVars()
    local declareSVars={}
    local declareSVarsCollect = function(moduleTables)
        if moduleTables.DeclareSVars then
            ApendArray(declareSVars,moduleTables.DeclareSVars())
        end
    end
    RngConfig.OnSelectedModules(declareSVarsCollect)
    InfCore.PrintInspect(declareSVars,"RngMission: declareSVars")
    return declareSVars
end

--Enemy

function this.EnemyInitEnemy()
    local missionPrepareCollect = function(moduleTables)
        if moduleTables.InitEnemy then
            moduleTables.InitEnemy()
        end
    end
    RngConfig.OnSelectedModules(missionPrepareCollect)
end

function this.EnemySetUpEnemy()
    local combatSetting={}
    local registHoldRecoveredState={}
    local setUpEnemyTopCollect=function(moduleTables)
        if moduleTables.combatSetting then
            combatSetting=MergeTable(combatSetting,moduleTables.combatSetting)
        end
        if moduleTables.registHoldRecoveredState then
            --modules already check but here's a double check
            if (#registHoldRecoveredState + #moduleTables.registHoldRecoveredState) <= RngDefine.MAX_HOLD_RECOVERED_STATE_COUNT then
                ApendArray(registHoldRecoveredState,moduleTables.registHoldRecoveredState)
            end 
        end
    end
    RngConfig.OnSelectedModules(setUpEnemyTopCollect)
    for i, targetName in ipairs(registHoldRecoveredState) do
        --modules already check and list assembler already checks but here's a triple check
        if i <= RngDefine.MAX_HOLD_RECOVERED_STATE_COUNT then
            TppEnemy.RegistHoldRecoveredState(targetName)
        end
    end
    TppEnemy.RegisterCombatSetting(combatSetting)

    local setUpEnemyEndCollect=function(moduleTables)
        if moduleTables.SetUpEnemy then
            moduleTables.SetUpEnemy()
        end
    end
    RngConfig.OnSelectedModules(setUpEnemyEndCollect)
end

function this.EnemySpawnVehicleOnInitialize()
    local vehicleSettingsCollect=function(moduleTables)
        if moduleTables.vehicleSettings then
            for index, vehicleSetting in ipairs(moduleTables.vehicleSettings) do
                SendCommand({type="TppVehicle2"},vehicleSetting)
            end
        end
    end
    RngConfig.OnSelectedModules(vehicleSettingsCollect)
end

--Mission has loaded, but before subscripts are processed - patch them
function this.OnAllocateTop(missionTable)
    if vars.missionCode~=RngDefine.rngMissionId then
        RngConfig.UpdateLocation(RngDefine.DefaultLocationName)
        return
    end
    local modules = RngModules.GetModulesForLocation(RngConfig.GetSelectedLocationName())

    --sequence
    local MISSION_START_INITIAL_ACTION
    local baseList={}
    local Messages={}
    Rng.AppendMessages(Messages,this.CommonMessages())
    local saveVarsList={}
    local missionObjectiveDefine={}
    local missionObjectiveTree={}
    --enemy
    local vehicleDefine={
        instanceCount=RngConfig.GetSelectedVehicleCount()
    }
    local soldierTypes={}
    local cpTypes={}
    local cpSubTypes={}
    local soldierDefine={}
    local routeSets={}
    local interrogation={}
    local uniqueInterrogation={}
    local useGeneInter={}
    local soldierPowerSettings={}
    local travelPlans={}
    --telop
    local telop={}
    --radio
    local radioList={
        "f2000_oprg0020",
        "f1000_rtrg1640",
        "f1000_rtrg1641",
        "f1000_rtrg1647",
        "f1000_rtrg1400",
    }
    --sound
    local bgmList={}

    local commonModule=modules.common
    if commonModule then
        if commonModule.Messages then
            Rng.AppendMessages(Messages,commonModule.Messages())
        end
        if commonModule.saveVarsList then
            saveVarsList=MergeTable(saveVarsList,commonModule.saveVarsList)
        end
    end
    if modules.npc then
        for gameObjectType, gameObjectTable in pairs(modules.npc) do
            if gameObjectTable.Messages then
                Rng.AppendMessages(Messages,gameObjectTable.Messages())
            end
            if gameObjectTable.telop then
                telop=Rng.MergeTable(telop,gameObjectTable.telop)
            end
            if gameObjectTable.saveVarsList then
                saveVarsList=MergeTable(saveVarsList,gameObjectTable.saveVarsList)
            end
            if gameObjectType=="TppSoldier2" then
                if gameObjectTable.cpType then
                    cpTypes=gameObjectTable.cpType
                end
            end
        end
    end
    local allocateCollect = function(moduleTables)
        --sequence
        if moduleTables.helicopterRouteList then
            for index, startPos in ipairs(moduleTables.helicopterRouteList) do
                if IsTypeTable(startPos) then
                    if startPos.action then
                        if startPos.pos then
                            if gvars.ply_missionStartPos[0]==startPos.pos[1]
                            and gvars.ply_missionStartPos[1]==startPos.pos[2]
                            and gvars.ply_missionStartPos[2]==startPos.pos[3] then
                                MISSION_START_INITIAL_ACTION=startPos.action
                                break
                            end
                        end
                    end
                end
            end
        end
        if moduleTables.baseList then
            Rng.AppendArrayU(baseList,moduleTables.baseList)
        end
        if moduleTables.Messages then
            Rng.AppendMessages(Messages,moduleTables.Messages())
        end
        if moduleTables.saveVarsList then
            saveVarsList=MergeTable(saveVarsList,moduleTables.saveVarsList)
        end
        if moduleTables.missionObjectiveDefine then
            missionObjectiveDefine=MergeTable(missionObjectiveDefine,moduleTables.missionObjectiveDefine)
        end
        if moduleTables.missionObjectiveTree then
            missionObjectiveTree=MergeTable(missionObjectiveTree,moduleTables.missionObjectiveTree)
        end

        --enemy
        if moduleTables.soldierDefine then
            for cpName, soldierList in pairs(moduleTables.soldierDefine) do
                soldierDefine[cpName]=soldierDefine[cpName] or soldierList
                for key, value in pairs(soldierList) do
                    if IsTypeString(key) then
                        if TppEnemy.SOLDIER_DEFINE_RESERVE_TABLE_NAME[key] then
                            soldierDefine[cpName][key]=value
                        end
                    elseif IsTypeString(value) then
                        InfUtil.InsertUniqueInList(soldierDefine[cpName],value)
                    end
                    InfCore.PrintInspect(soldierDefine[cpName],"RngMission.OnAllocateTop: soldierDefine."..cpName)
                end
            end
            --make interrogation
            for cpName, cpTable in pairs(moduleTables.soldierDefine) do
                if not interrogation[cpName] then
                    interrogation[cpName]={high={},normal={}}
                end
            end
        end
        if moduleTables.soldierTypes then
            soldierTypes=Rng.MergeTable(soldierTypes,moduleTables.soldierTypes)
        end
        if moduleTables.cpTypes then
            if IsTypeTable(moduleTables.cpTypes) then
                if not IsTypeTable(cpTypes) then
                    local _cpType=cpTypes
                    for cpName, soldierList in ipairs(soldierDefine) do
                        cpTypes[cpName] = moduleTables.cpTypes[cpName] or _cpType
                    end
                end
                cpTypes=Rng.MergeTable(cpTypes,moduleTables.cpTypes)
            end
        end
        if moduleTables.cpSubTypes then
            cpSubTypes=Rng.MergeTable(cpSubTypes,moduleTables.cpSubTypes)
        end
        if moduleTables.routeSets then
            --TODO better merge
            routeSets=Rng.MergeTable(routeSets,moduleTables.routeSets)
            for cpName, routeSet in pairs(moduleTables.routeSets) do
                if routeSet.DONT_USE_COMMON_ROUTE_SETS==true then
                    routeSets[cpName].USE_COMMON_ROUTE_SETS=nil
                end
            end
        end
        if moduleTables.interrogation then
            for cpName, cpTable in pairs(moduleTables.interrogation) do
                interrogation[cpName] = interrogation[cpName] or{}
                for layerName, layerTable in pairs(cpTable) do
                    interrogation[cpName][layerName] = interrogation[cpName][layerName] or{}
                    for interIndex, interInfo in ipairs(layerTable) do
                        table.insert(interrogation[cpName][layerName],interInfo)
                    end
                end
            end
        end
        --[[
              uniqueInterrogation = {
            unique = { {
                func = <function 16>,
                name = "enqt1000_106930"
            }, "enqt1000_106930", <function 17> },
            uniqueChara = { {
                func = <function 18>,
                name = "sol_q10050_0000"
            }, "sol_q10020_0000", <function 19> }
        },
        ]]
        if moduleTables.uniqueInterrogation then
            for interrType, interrTable in pairs(moduleTables.uniqueInterrogation) do
                if not uniqueInterrogation[interrType] then
                    uniqueInterrogation[interrType]=moduleTables.uniqueInterrogation[interrType]
                else
                    for uniqIndex, interrInfo in ipairs(interrTable) do
                        uniqueInterrogation[interrType][#uniqueInterrogation[interrType]+1]=interrInfo
                    end
                end
            end
        end
        if moduleTables.useGeneInter then
            useGeneInter=MergeTable(useGeneInter,moduleTables.useGeneInter)
        end
        if moduleTables.soldierPowerSettings then
            soldierPowerSettings=MergeTable(soldierPowerSettings,moduleTables.soldierPowerSettings)
        end
        if moduleTables.travelPlans then
            travelPlans=Rng.MergeTable(travelPlans,moduleTables.travelPlans)
        end

        --radio
        if moduleTables.intelRadioList then
            useGeneInter=MergeTable(useGeneInter,moduleTables.intelRadioList)
        end
        if moduleTables.radioList then
            ApendArray(radioList,moduleTables.radioList)
        end
    end
    RngConfig.OnSelectedModules(allocateCollect)
    
    --Add to sequence
    if missionTable.sequence then
        missionTable.sequence.MISSION_START_INITIAL_ACTION = MISSION_START_INITIAL_ACTION
        missionTable.sequence.ENABLE_DEFAULT_HELI_MISSION_CLEAR=true
        missionTable.sequence.MissionPrepare=this.SequenceMissionPrepare
        missionTable.sequence.Messages=function() return Messages end
        missionTable.sequence.baseList=baseList
        --this has to just fuckin exist for drop sequence to work
        missionTable.sequence.missionStartPosition={}
        missionTable.sequence.missionStartPosition.helicopterRouteList={}

        missionTable.sequence.saveVarsList=saveVarsList
        missionTable.sequence.OnRestoreSVars=this.SequenceOnRestoreSVars
        missionTable.sequence.DeclareSVars=this.SequenceDeclareSVars

        missionTable.sequence.missionObjectiveDefine=missionObjectiveDefine
        missionTable.sequence.missionObjectiveTree=missionObjectiveTree
        local missionObjectiveEnum={}
        local routeIndex = 0
        for objectiveName, objectiveTable in pairs(missionObjectiveDefine) do
            if IsTypeTable(objectiveTable.showEnemyRoutePoints) then
                objectiveTable.showEnemyRoutePoints.groupIndex=routeIndex
                routeIndex = routeIndex + 1
            end
            if IsTypeString(objectiveName) then
                table.insert(missionObjectiveEnum,objectiveName)
            end
        end
        missionTable.sequence.missionObjectiveEnum=Tpp.Enum(missionObjectiveEnum)
    end
    InfCore.PrintInspect(missionTable.sequence,"OnAllocateTop missionTable.sequence")

    --Add to enemy
    if missionTable.enemy then
        local soldierCount=RngConfig.GetSelectedSoldierCount()
        --fuckin stupid reuse
        local maxCounts={160,360}
        if soldierCount>RngDefine.MAX_SOLDIER_STATE_COUNT then
            missionTable.enemy.MAX_SOLDIER_STATE_COUNT=this.GetHighestEntityCount(maxCounts, soldierCount)
        end
        missionTable.enemy.soldierDefine=soldierDefine
        missionTable.enemy.vehicleDefine=vehicleDefine
        missionTable.enemy.soldierTypes=soldierTypes
        missionTable.enemy.cpTypes=cpTypes
        missionTable.enemy.cpSubTypes=cpSubTypes
        missionTable.enemy.InitEnemy=this.EnemyInitEnemy
        missionTable.enemy.routeSets=routeSets
        missionTable.enemy.SetUpEnemy=this.EnemySetUpEnemy
        missionTable.enemy.interrogation=interrogation
        missionTable.enemy.uniqueInterrogation=uniqueInterrogation
        missionTable.enemy.useGeneInter=useGeneInter
        missionTable.enemy.soldierPowerSettings=soldierPowerSettings
        missionTable.enemy.SpawnVehicleOnInitialize=this.EnemySpawnVehicleOnInitialize
        missionTable.enemy.travelPlans=travelPlans
    end
    InfCore.PrintInspect(missionTable.enemy,"OnAllocateTop missionTable.enemy")

    --Add to radio
    if missionTable.radio then
        --free roam radio
        missionTable.radio.radioList=radioList
    end

    --Add to telop
    if missionTable.telop then
        for telopName, telopTable in pairs(telop) do
            missionTable.telop[telopName]=missionTable.telop[telopName] or {}
            Rng.AppendArrayU(missionTable.telop[telopName],telopTable)
        end
    end
    InfCore.PrintInspect(missionTable.telop,"OnAllocateTop missionTable.telop")

    --Add to sound
    if missionTable.sound then
        missionTable.sound.bgmList=bgmList
    end
end

--Sequences
local sequences = {}

--Before mission can be cleared
sequences.Seq_Game_MainGame = {
    OnEnter=function(self)
        local objectives={}
        local func = function(moduleTables)
            if moduleTables.defaultObjectives then
                for index, objectiveName in ipairs(moduleTables.defaultObjectives) do
                    objectives[#objectives+1]=objectiveName
                end
            end
            if moduleTables.Seq_Game_MainGame then
                if moduleTables.Seq_Game_MainGame.OnEnter then
                    InfCore.Log("RngMission: Seq_Game_MainGame OnEnter")
                    moduleTables.Seq_Game_MainGame.OnEnter(self)
                end
            end
        end
        InfCore.PrintInspect(objectives,"Seq_Game_MainGame OnEnter objectives")
        RngConfig.OnSelectedModules(func)
        TppTelop.StartCastTelop()
        TppMission.UpdateObjective{
            objectives=objectives,
			radio = {
				radioGroups = { "f2000_oprg0020" },
			},
            options={isMissionStart=true},
        }
        TppMission.UpdateObjective{
            objectives=objectives,
        }
        TppRadio.SetOptionalRadio( "Set_f2000_oprg0010" )
    end,
    OnLeave=function(self)
        local func = function(moduleTables)
            if moduleTables.Seq_Game_MainGame then
                if moduleTables.Seq_Game_MainGame.OnLeave then
                    InfCore.Log("RngMission: Seq_Game_MainGame OnLeave")
                    moduleTables.Seq_Game_MainGame.OnLeave(self)
                end
            end
        end
        RngConfig.OnSelectedModules(func)
    end,
}

--Mission can be cleared and left
sequences.Seq_Game_Escape = {
    OnEnter=function(self)
        local func = function(moduleTables)
            if moduleTables.Seq_Game_Escape then
                if moduleTables.Seq_Game_Escape.OnEnter then
                    moduleTables.Seq_Game_Escape.OnEnter(self)
                end
            end
        end
        TppRadio.Play("f1000_rtrg1400")
        RngConfig.OnSelectedModules(func)
		TppMission.CanMissionClear()
    end,
    OnLeave=function(self)
        local func = function(moduleTables)
            if moduleTables.Seq_Game_Escape then
                if moduleTables.Seq_Game_Escape.OnLeave then
                    InfCore.Log("RngMission: Seq_Game_Escape OnLeave")
                    moduleTables.Seq_Game_Escape.OnLeave(self)
                end
            end
        end
        RngConfig.OnSelectedModules(func)
    end,
}

local sequenceNames = {"Seq_Game_MainGame","Seq_Game_Escape"}

--Called in sequence's OnLoad, can't patch it in through OnAllocate
function this.SequenceOnLoad()
    InfCore.Log("RngMission.SequenceOnLoad")
	TppSequence.RegisterSequences(sequenceNames)
	TppSequence.RegisterSequenceTable(sequences)
end

return this