--rng_afgh_village_spowen09.lua
local this={}
local ApendArray = Tpp.ApendArray
local GetGameObjectId = GameObject.GetGameObjectId

local targetName = "hos_spowen09_0000"
local interObjectiveName = "area_target_village_spowen09"
local targetObjectiveName = "target_village_spowen09"
local clearObjectiveName = "clear_village_spowen09"
--The woman you're looking for... is here.
local interSubpId = "enqt1000_101527"

this.locationName="AFGH"
this.areaName="village"
this.name="village_spowen09"

this.needDefault=true

this.packs={
    "/Assets/tpp/pack/rng/npc/rng_female.fpk",
    "/Assets/tpp/pack/rng/npc/rng_spowen09.fpk",
    "/Assets/tpp/pack/rng/npc/rng_hostage_fc.fpk",
    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_hostage2_prs3.fpk",
    "/Assets/tpp/pack/rng/afgh/op/village/rng_afgh_village_spowen09.fpk",
}

this.hostageDefine={
    targetName,
}

local prs3_main0_def_v00PartsAfghanFree="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
this.SetUpUniqueTable={
    [targetName]={
        type="hostage",
        race=TppDefine.QUEST_RACE_TYPE.BLACK,
        gender=TppDefine.QUEST_GENDER_TYPE.WOMAN,
        bodyId=TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_FEMALE,
        staffParameter={
            staffTypeId=RngDefine.staffTypeIdsEnum.support100,
            skill="None",
        },
        commands={
            {id="SetVoiceType",voiceType="hostage_c"},
            {id="SetHostage2Flag",flag="female",on=true},
        },
        gameObjectType="TppHostage2",
        parts=prs3_main0_def_v00PartsAfghanFree,
    },
}

this.missionObjectiveDefine={
    area_village_spowen09 = {
        gameObjectName = "marker_village_spowen09_area",
        visibleArea = 4, randomRange = 0, 
        viewType = "all",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
    },
	area_target_village_spowen09 = { 
		gameObjectName = "marker_village_spowen09_target",
		visibleArea = 0, randomRange = 0, viewType = "all",
		setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
	target_village_spowen09 = { 
		gameObjectName = targetName,
		goalType = "moving", viewType="map_and_world_only_icon",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
    clear_village_spowen09 = {
        announceLog = "achieveAllObjectives",
    },
	village_spowen09_cp = {
		targetBgmCp = "afgh_village_cp",
	},
}

this.missionObjectiveTree={
    clear_village_spowen09 = {
        target_village_spowen09 = {
            area_target_village_spowen09 = {
                area_village_spowen09 = {},
            },
        },
        village_spowen09_cp = {},
    },
}

function this.InterCall_hostage_pos01(gameObjectId,cpId,interName)
    if TppMission.IsEnableAnyParentMissionObjective(interObjectiveName) == false then
        TppMission.UpdateObjective{objectives={interObjectiveName}}
    end
end

this.interrogation = {
	afgh_village_cp = {
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
    InfCore.PrintInspect(saveVars,"village_spowen09: DeclareSVars")
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
        local cpGameObjectId = GetGameObjectId("afgh_village_cp")
		TppInterrogation.AddHighInterrogation(cpGameObjectId,this.interrogation.afgh_village_cp.high)
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
    local cpGameObjectId = GetGameObjectId("afgh_village_cp")
	TppInterrogation.RemoveHighInterrogation(cpGameObjectId,this.interrogation.afgh_village_cp.high)
end

this.carryMonologue={
    [targetName]={
        monologues={
            {label="speech_carry_spowen09_00",nextDelay=0.75},
            {label="speech_carry_spowen09_01",nextDelay=1.5},
            {label="speech_carry_spowen09_02",nextDelay=1.0},
            {label="speech_carry_spowen09_03",nextDelay=0.75},
            {label="speech_carry_spowen09_04",nextDelay=2.5},
            {label="speech_carry_spowen09_05",nextDelay=1.0},
            {label="speech_carry_spowen09_06",nextDelay=0.75},
            {label="speech_carry_spowen09_07",nextDelay=1.25},
            {label="speech_carry_spowen09_08",nextDelay=1.5},
            {label="speech_carry_spowen09_09",nextDelay=1.5},
            {label="speech_carry_spowen09_10",nextDelay=0.75},
            {label="speech_carry_spowen09_11",},
        },
    }
}

this.systemCallbackTable={
    OnRecovered = function(gameObjectId)
        InfCore.Log("village_spowen09:OnRecovered "..gameObjectId)
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
        InfCore.Log("village_spowen09: OnGameOver")
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
    "area_village_spowen09",
}

this.Messages=function()
    local messages={}
    Rng.AppendMessages(messages,RngHostage.RegisterMessagesForCariMono(this.carryMonologue))
    Rng.AppendMessages(messages,RngHostage.RegisterOnDeadGameOverMessage(this.deadGameOverLocators))
    return Tpp.StrCode32Table(messages)
end

return this