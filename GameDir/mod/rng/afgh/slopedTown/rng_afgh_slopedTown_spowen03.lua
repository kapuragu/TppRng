--rng_afgh_slopedTown_spowen03.lua
local this={}
local ApendArray = Tpp.ApendArray
local GetGameObjectId = GameObject.GetGameObjectId

local targetName = "hos_spowen03_0000"
local interObjectiveName = "area_target_slopedTown_spowen03"
local targetObjectiveName = "target_slopedTown_spowen03"
local clearObjectiveName = "clear_slopedTown_spowen03"
--The man you're looking for... is here.
local interSubpId = "enqt1000_101528"

this.locationName="AFGH"
this.areaName="slopedTown"
this.name="slopedTown_spowen03"

this.needDefault=true

this.packs={
    "/Assets/tpp/pack/rng/npc/rng_hostage_ec.fpk",
    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_spowen03.fpk",
    "/Assets/tpp/pack/rng/afgh/op/slopedTown/rng_afgh_slopedTown_spowen03.fpk",
}

this.routeSets={
    afgh_slopedTown_cp = {

    },
}

this.hostageDefine={
    targetName,
}

this.SetUpUniqueTable={
    [targetName]={
        type="hostage",
        race=TppDefine.QUEST_RACE_TYPE.BROWN,
        bodyId=TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_MALE,
        staffParameter={
            staffTypeId=RngDefine.staffTypeIdsEnum.combat120_support100,
            skill="None",
        },
        commands={
            {id="SetVoiceType",voiceType="hostage_c"},
        },
        gameObjectType="TppHostage2",
    },
}

this.missionObjectiveDefine={
    area_slopedTown_spowen03 = {
        gameObjectName = "marker_slopedTown_spowen03_area",
        visibleArea = 4, randomRange = 0, 
        viewType = "all",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
    },
	area_target_slopedTown_spowen03 = { 
		gameObjectName = "marker_slopedTown_spowen03_target",
		visibleArea = 0, randomRange = 0, viewType = "all",
		setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
	target_slopedTown_spowen03 = { 
		gameObjectName = targetName,
		goalType = "moving", viewType="map_and_world_only_icon",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
    clear_slopedTown_spowen03 = {
        announceLog = "achieveAllObjectives",
    },
	slopedTown_spowen03_cp = {
		targetBgmCp = "afgh_slopedTown_cp",
	},
}

this.missionObjectiveTree={
    clear_slopedTown_spowen03 = {
        target_slopedTown_spowen03 = {
            area_target_slopedTown_spowen03 = {
                area_slopedTown_spowen03 = {},
            },
        },
        slopedTown_spowen03_cp = {},
    },
}

function this.InterCall_hostage_pos01(gameObjectId,cpId,interName)
    if TppMission.IsEnableAnyParentMissionObjective(interObjectiveName) == false then
        TppMission.UpdateObjective{objectives={interObjectiveName}}
    end
end

this.interrogation = {
	afgh_slopedTown_cp = {
		high = {
            --The woman you're looking for... is here.
			{ name = interSubpId, func = this.InterCall_hostage_pos01, },
		},
	},
}

this.registHoldRecoveredState=this.hostageDefine

this.deadGameOverLocators=this.hostageDefine

function this.DeclareSVars()
    local saveVars={}
    ApendArray(saveVars,RngHostage.RegisterSVarsForCariMono(this.carryMonologue))
    InfCore.PrintInspect(saveVars,"slopedTown_spowen03: DeclareSVars")
    return saveVars
end

function this.uniqueSettings()
    return RngFova.GetUniqueSetting(this.SetUpUniqueTable)
end

this.SetUpEnemy=function(missionTable)
    RngEnemy.SetUpUnique(this.SetUpUniqueTable)
end

this.clearObjectiveName = {
    clearObjectiveName,
}

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        local cpGameObjectId = GetGameObjectId("afgh_slopedTown_cp")
		TppInterrogation.AddHighInterrogation(cpGameObjectId,this.interrogation.afgh_slopedTown_cp.high)
	end
end

function this.TargetFound()
    if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        TppMission.UpdateObjective{objectives={targetObjectiveName}}
    end
	this.InterStop_hostage_pos01()
    Player.RemoveSearchTarget(targetName)
end

function this.InterStop_hostage_pos01()
    local cpGameObjectId = GetGameObjectId("afgh_slopedTown_cp")
	TppInterrogation.RemoveHighInterrogation(cpGameObjectId,this.interrogation.afgh_slopedTown_cp.high)
end

this.carryMonologue={
    [targetName]={
        monologues={
            {label="speech_carry_spowen03_00",nextDelay=1.0},
            {label="speech_carry_spowen03_01",nextDelay=1.0},
            {label="speech_carry_spowen03_02",nextDelay=1.0},
            {label="speech_carry_spowen03_03",nextDelay=1.0},
            {label="speech_carry_spowen03_04",nextDelay=1.0},
            {label="speech_carry_spowen03_05",nextDelay=1.0},
            {label="speech_carry_spowen03_06",nextDelay=1.0},
            {label="speech_carry_spowen03_07",nextDelay=1.0},
            {label="speech_carry_spowen03_08",},
        },
    }
}

this.systemCallbackTable={
    OnRecovered = function(gameObjectId)
        InfCore.Log("slopedTown_spowen03:OnRecovered "..gameObjectId)
        if Tpp.IsHostage(gameObjectId) then
            if TppMission.IsEnableAnyParentMissionObjective(clearObjectiveName) == false then
                if GetGameObjectId( targetName ) == gameObjectId then
                    this.TargetFound()
                    TppMission.UpdateObjective{objectives={clearObjectiveName}}
                    RngMission.OnObjectiveClear()
                end
            end
        end
    end,
    OnGameOver = function()
        InfCore.Log("slopedTown_spowen03: OnGameOver")
        return RngHostage.SystemCallbackOnGameOver(this.deadGameOverLocators)
    end,
}

this.setUpSearchTarget={
    {
        gameObjectName = targetName, gameObjectType = "TppHostage2",
        messageName = targetName, skeletonName = "SKL_004_HEAD",
        func = function(locatorNameS32,gameObjectId,messageName)
            this.TargetFound()
        end,
    },
}

this.defaultObjectives={
    "area_slopedTown_spowen03",
}

this.Messages=function()
    local messages={}
    Rng.AppendMessages(messages,RngHostage.RegisterMessagesForCariMono(this.carryMonologue))
    Rng.AppendMessages(messages,RngHostage.RegisterOnDeadGameOverMessage(this.deadGameOverLocators))
    return Tpp.StrCode32Table(messages)
end

return this