--rng_afgh_commFacility_spowen07.lua
local this={}
local ApendArray = Tpp.ApendArray
local GetGameObjectId = GameObject.GetGameObjectId

local targetName = "hos_spowen07_0000"
local interObjectiveName = "area_target_commFacility_spowen07"
local targetObjectiveName = "target_commFacility_spowen07"
local clearObjectiveName = "clear_commFacility_spowen07"
--The woman you're looking for... is here.
local interSubpId = "enqt1000_101527"

this.locationName="AFGH"
this.areaName="commFacility"
this.name="commFacility_spowen07"

this.needDefault=true

this.packs={
    "/Assets/tpp/pack/rng/npc/rng_female.fpk",
    "/Assets/tpp/pack/rng/npc/rng_spowen07.fpk",
    "/Assets/tpp/pack/rng/npc/rng_hostage_fa.fpk",
    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_hostage2_prs3.fpk",
    "/Assets/tpp/pack/rng/afgh/op/commFacility/rng_afgh_commFacility_spowen07.fpk",
}

this.routeSets={
    afgh_commFacility_cp = {
        sneak_day = {
            groupC = {
                "rts_commFacility_spowen07_d_0000",
            },
        },
        sneak_night = {
            groupC = {
                "rts_commFacility_spowen07_n_0000",
            },
        },
        caution = {
            groupC = {
                "rts_commFacility_spowen07_c_0000",
            },
        },
    },
}

this.hostageDefine={
    targetName,
}

local prs3_main0_def_v00PartsAfghanFree="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
this.SetUpUniqueTable={
    [targetName]={
        type="hostage",
        race=TppDefine.QUEST_RACE_TYPE.WHITE,
        gender=TppDefine.QUEST_GENDER_TYPE.WOMAN,
        bodyId=TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_FEMALE,
        staffParameter={
            staffTypeId=RngDefine.staffTypeIdsEnum.spy100,
            skill="None",
        },
        commands={
            {id="SetVoiceType",voiceType="hostage_a"},
            {id="SetHostage2Flag",flag="female",on=true},
        },
        gameObjectType="TppHostage2",
        parts=prs3_main0_def_v00PartsAfghanFree,
    },
}

this.missionObjectiveDefine={
    area_commFacility_spowen07 = {
        gameObjectName = "marker_commFacility_spowen07_area",
        visibleArea = 4, randomRange = 0, 
        viewType = "all",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
    },
	area_target_commFacility_spowen07 = { 
		gameObjectName = "marker_commFacility_spowen07_target",
		visibleArea = 0, randomRange = 0, viewType = "all",
		setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
	target_commFacility_spowen07 = { 
		gameObjectName = targetName,
		goalType = "moving", viewType="map_and_world_only_icon",
        setNew = true, setImportant = true,
        langId = "target_type_rescue",
	},
    clear_commFacility_spowen07 = {
        announceLog = "achieveAllObjectives",
    },
	commFacility_spowen07_cp = {
		targetBgmCp = "afgh_commFacility_cp",
	},
}

this.missionObjectiveTree={
    clear_commFacility_spowen07 = {
        target_commFacility_spowen07 = {
            area_target_commFacility_spowen07 = {
                area_commFacility_spowen07 = {},
            },
        },
        commFacility_spowen07_cp = {},
    },
}

function this.InterCall_hostage_pos01(gameObjectId,cpId,interName)
    if TppMission.IsEnableAnyParentMissionObjective(interObjectiveName) == false then
        TppMission.UpdateObjective{objectives={interObjectiveName}}
    end
end

this.interrogation = {
	afgh_commFacility_cp = {
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
    InfCore.PrintInspect(saveVars,"commFacility_spowen07: DeclareSVars")
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
        local cpGameObjectId = GetGameObjectId("afgh_commFacility_cp")
		TppInterrogation.AddHighInterrogation(cpGameObjectId,this.interrogation.afgh_commFacility_cp.high)
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
    local cpGameObjectId = GetGameObjectId("afgh_commFacility_cp")
	TppInterrogation.RemoveHighInterrogation(cpGameObjectId,this.interrogation.afgh_commFacility_cp.high)
end

this.carryMonologue={
    [targetName]={
        monologues={
            {label="speech_carry_spowen07_00",nextDelay=1.0},
            {label="speech_carry_spowen07_01",nextDelay=1.0},
            {label="speech_carry_spowen07_02",nextDelay=1.0},
            {label="speech_carry_spowen07_03",nextDelay=1.0},
            {label="speech_carry_spowen07_04",nextDelay=1.0},
            {label="speech_carry_spowen07_05",nextDelay=1.0},
            {label="speech_carry_spowen07_06",nextDelay=1.0},
            {label="speech_carry_spowen07_07",nextDelay=1.0},
            {label="speech_carry_spowen07_08",nextDelay=1.0},
            {label="speech_carry_spowen07_09",},
        },
    }
}

this.systemCallbackTable={
    OnRecovered = function(gameObjectId)
        InfCore.Log("commFacility_spowen07:OnRecovered "..gameObjectId)
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
        InfCore.Log("commFacility_spowen07: OnGameOver")
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
    "area_commFacility_spowen07",
}

this.Messages=function()
    local messages={}
    Rng.AppendMessages(messages,RngHostage.RegisterMessagesForCariMono(this.carryMonologue))
    Rng.AppendMessages(messages,RngHostage.RegisterOnDeadGameOverMessage(this.deadGameOverLocators))
    return Tpp.StrCode32Table(messages)
end

return this