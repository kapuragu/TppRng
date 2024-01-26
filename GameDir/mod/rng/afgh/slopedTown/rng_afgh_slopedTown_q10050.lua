--rng_afgh_slopedTown_q10050.lua
local this={}
local GetGameObjectId = GameObject.GetGameObjectId

local targetName = "sol_q10050_0000"
local targetObjectiveName = "target_q10050"
local clearObjectiveName = "clear_q10050"
--Our specialist is posted... here...
local interSubpId = "enqt1000_108197"

this.locationName="AFGH"
this.areaName="slopedTown"
this.name="slopedTown_q10050"

this.needDefault=true

this.packs=function(missionCode)
    TppPackList.AddMissionPack"/Assets/tpp/pack/rng/afgh/op/slopedTown/rng_afgh_slopedTown_q10050.fpk"
end

this.registHoldRecoveredState={
    targetName,
}

this.soldierDefine={
    afgh_slopedTown_cp = {
        targetName,
        "sol_q10050_0001",
        "sol_q10050_0002",
        "sol_q10050_0003",
        "sol_q10050_0004",
        "sol_q10050_0005",
    },
}

this.soldierPowerSettings = {
    [targetName] = { },
    sol_q10050_0001 = { "HELMET", "SHIELD", "SMG" },
    sol_q10050_0002 = { },
    sol_q10050_0003 = { },
    sol_q10050_0004 = { },
    sol_q10050_0005 = { },
}

this.routeSets={
    afgh_slopedTown_cp = {
		priority = {
			"vip",
			"groupA",	
			"groupB",	
			"groupC",	
			"groupD",	
            "near_vip",
		},
		fixedShiftChangeGroup = {
			"vip",
            "near_vip",
		},
		sneak_day = {
			vip = {
				{ "rts_q10050_d_0000", attr = "VIP" },
			},
            near_vip = {
                "rts_q10050_d_0001",
                "rts_q10050_d_0002",
                "rts_q10050_d_0002",
                "rts_q10050_d_0003",
                "rts_q10050_d_0003",
            },
		},
        sneak_night = {
			vip = {
				{ "rts_q10050_d_0000", attr = "VIP" },
			},
            near_vip = {
                "rts_q10050_d_0001",
                "rts_q10050_d_0002",
                "rts_q10050_d_0002",
                "rts_q10050_d_0003",
                "rts_q10050_d_0003",
            },
        },
        caution = {
			vip = {
				{ "rts_q10050_d_0000", attr = "VIP" },
			},
            near_vip = {
                "rts_q10050_d_0001",
                "rts_q10050_d_0002",
                "rts_q10050_d_0002",
                "rts_q10050_d_0003",
                "rts_q10050_d_0003",
            },
        },
    },
}

this.SetUpUniqueTable={
    [targetName]={
        type="enemy",
        race=TppDefine.QUEST_RACE_TYPE.CAUCASIAN,
        bodyId=TppEnemyBodyId.svs0_rfl_rng_v00_a,
        staffParameter={
            staffTypeId=RngDefine.staffTypeIdsEnum.combat120_baseDev100,
            skill="None",
        },
        commands={
            {id="SetSoldier2Flag",flag="highRank",on=true},
            {id="SetVip"},
            {id="SetVipSpecial"},
            {id="SetForceRealize"},
            {id="SetIgnoreSupportBlastInUnreal",enabled=true},
        },
    },
}

function this.uniqueSettings()
    return RngFova.GetUniqueSetting(this.SetUpUniqueTable)
end

function this.SetUpEnemy()
    RngEnemy.SetUpUnique(this.SetUpUniqueTable)
	TppEnemy.InitialRouteSetGroup{
        cpName = "afgh_slopedTown_cp",
        soldierList = { targetName, },
        groupName = "vip",
	}
    TppEnemy.InitialRouteSetGroup{
        cpName = "afgh_slopedTown_cp",
        soldierList = {
            "sol_q10050_0001",
            "sol_q10050_0002",
            "sol_q10050_0003",
            "sol_q10050_0004",
            "sol_q10050_0005",
        },
        groupName = "near_vip",
    }
end

this.missionObjectiveDefine={
    area_q10050 = {
        gameObjectName = "marker_q10050_area",
        visibleArea = 4, randomRange = 0,
        viewType = "all",
        setNew = true, setImportant = true,
        langId = "target_type_exclusion",
    },
	target_q10050 = { 
		gameObjectName = targetName,
		goalType = "moving", viewType="map_and_world_only_icon",
		setNew = true, setImportant = true,
        langId = "target_type_exclusion",
	},
    clear_q10050 = {
        announceLog = "achieveAllObjectives",
    },
	q10050_cp = {
		targetBgmCp = "afgh_slopedTown_cp",
	},
}

this.missionObjectiveTree={
    clear_q10050 = {
        target_q10050 = {
            area_q10050 = {},
        },
        q10050_cp = {},
    },
}

this.clearObjectiveName = {
    clearObjectiveName,
}

function this.InterCall_vip_pos01(gameObjectId,cpId,interName)
    if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        TppMission.UpdateObjective{objectives={targetObjectiveName}}
    end
end

this.interrogation = {
	afgh_slopedTown_cp = {
		high = {
			{ name = interSubpId, func = this.InterCall_vip_pos01, },
		},
	},
}

this.UniqueInterEnd_sol_q10050_0000 = function( soldier2GameObjectId, cpID )
	InfCore.Log("CallBack : Unique : End")
end

this.UniqueInterStart_sol_q10050_0000 = function( soldier2GameObjectId, cpID )
	InfCore.Log("CallBack : Unique : start ")
	--You cur, you think you can take on the whole 40th Army?
    TppInterrogation.UniqueInterrogation( cpID, "enqt1000_106930")
	return true
end

this.uniqueInterrogation = {
	unique = {
        --You cur, you think you can take on the whole 40th Army?
		{ name = "enqt1000_106930", func = this.UniqueInterEnd_sol_q10050_0000, },
	},
	uniqueChara = {
		{ name = targetName, func = this.UniqueInterStart_sol_q10050_0000, },
	},
}

function this.TargetFound()
    if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        TppMission.UpdateObjective{objectives={targetObjectiveName}}
    end
	this.InterStop_vip_pos01()
    Player.RemoveSearchTarget(targetName)
end

function this.InterStop_vip_pos01()
    local cpGameObjectId = GetGameObjectId("afgh_slopedTown_cp")
	TppInterrogation.RemoveHighInterrogation(cpGameObjectId,this.interrogation.afgh_slopedTown_cp.high)
end

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        local cpGameObjectId = GetGameObjectId("afgh_slopedTown_cp")
		TppInterrogation.AddHighInterrogation(cpGameObjectId,this.interrogation.afgh_slopedTown_cp.high)
	end
end

function this.OnEliminate()
    if TppMission.IsEnableAnyParentMissionObjective(clearObjectiveName) == false then
        this.TargetFound()
        TppMission.UpdateObjective{objectives={clearObjectiveName}}
        RngMission.OnObjectiveClear()
    end
end

this.systemCallbackTable={
    OnRecovered = function(s_gameObjectId)
        InfCore.Log("village_spowen09:OnRecovered "..s_gameObjectId)
        if Tpp.IsSoldier( s_gameObjectId ) then
            if GetGameObjectId( targetName ) == s_gameObjectId then
                this.OnEliminate()
            end
        end
    end,
}

this.setUpSearchTarget={
    {
        gameObjectName = targetName, gameObjectType = "TppSoldier2",
        messageName = targetName, skeletonName = "SKL_004_HEAD",
        func = function(locatorNameS32,gameObjectId,messageName)
            this.TargetFound()
        end,
    },
}

this.defaultObjectives={
    "area_q10050",
}

this.Messages=function()
    return Tpp.StrCode32Table{
        GameObject={
            {
                msg = "Dead",
                sender = targetName,
                func = function(gameObjectId,attackerGameObjectId,playerPhase,deadMessageFlag)
                    this.OnEliminate()
                end,
            },
        },
    }
end

return this