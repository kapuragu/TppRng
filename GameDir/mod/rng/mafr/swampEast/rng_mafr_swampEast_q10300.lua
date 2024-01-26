--rng_mafr_swampEast_q10300.lua
local this={}
local GetGameObjectId = GameObject.GetGameObjectId

local targetName = "sol_q10300_0000"
local targetObjectiveName = "target_q10300"
local clearObjectiveName = "clear_q10300"
--Our specialist is posted... here...
local interSubpId = "enqt1000_108197"

this.locationName="MAFR"
this.areaName="swampEast"
this.name="swampEast_q10300"

this.needDefault=true

this.packs=function(missionCode)
    TppPackList.AddMissionPack"/Assets/tpp/pack/rng/mafr/op/swampEast/rng_mafr_swampEast_q10300.fpk"
end

this.registHoldRecoveredState={
    targetName,
}

this.soldierDefine={
    mafr_swampEast_ob = {
        targetName,
        "sol_q10300_0001",
        "sol_q10300_0002",
        "sol_q10300_0003",
        "sol_q10300_0004",
        "sol_q10300_0005",
    },
}

this.soldierPowerSettings = {
    [targetName] = { "SOFT_ARMOR", "MG" },
    sol_q10300_0001 = { "SNIPER", },
    sol_q10300_0002 = { "SNIPER", },
    sol_q10300_0003 = { "SNIPER", },
    sol_q10300_0004 = { "SNIPER", },
    sol_q10300_0005 = { "SHIELD", "HELMET", "SMG" },
}

this.routeSets={
    mafr_swampEast_ob = {
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
				{ "rts_q10300_d_0004", attr = "VIP" },
			},
            near_vip = {
                "rts_q10300_d_0001",
                "rts_q10300_d_0002",
                "rts_q10300_d_0002",
                "rts_q10300_d_0003",
                "rts_q10300_d_0004",
            },
		},
        sneak_night = {
			vip = {
				{ "rts_q10300_d_0004", attr = "VIP" },
			},
            near_vip = {
                "rts_q10300_d_0001",
                "rts_q10300_d_0002",
                "rts_q10300_d_0002",
                "rts_q10300_d_0003",
                "rts_q10300_d_0004",
            },
        },
        caution = {
			vip = {
				{ "rts_q10300_d_0004", attr = "VIP" },
			},
            near_vip = {
                "rts_q10300_d_0001",
                "rts_q10300_d_0002",
                "rts_q10300_d_0002",
                "rts_q10300_d_0003",
                "rts_q10300_d_0004",
            },
        },
    },
}

this.SetUpUniqueTable={
    [targetName]={
        type="enemy",
        race=TppDefine.QUEST_RACE_TYPE.CAUCASIAN,
        bodyId=TppEnemyBodyId.pfs0_rfl_rng_v00_a,
        staffParameter={
            staffTypeId=RngDefine.staffTypeIdsEnum.medical120_support100,
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
        cpName = "mafr_swampEast_ob",
        soldierList = { targetName, },
        groupName = "vip",
	}
    TppEnemy.InitialRouteSetGroup{
        cpName = "mafr_swampEast_ob",
        soldierList = {
            "sol_q10300_0001",
            "sol_q10300_0002",
            "sol_q10300_0003",
            "sol_q10300_0004",
            "sol_q10300_0005",
        },
        groupName = "near_vip",
    }
end

this.missionObjectiveDefine={
    area_q10300 = {
        gameObjectName = "marker_q10300_area",
        visibleArea = 4, randomRange = 0,
        viewType = "all",
        setNew = true, --setImportant = true,
        langId = "target_type_exclusion",
    },
	target_q10300 = { 
		gameObjectName = targetName,
		goalType = "moving", viewType="map_and_world_only_icon",
		setNew = true, setImportant = true,
        langId = "target_type_exclusion",
	},
    clear_q10300 = {
        announceLog = "achieveAllObjectives",
    },
	q10300_cp = {
		targetBgmCp = "mafr_swampEast_ob",
	},
}

this.missionObjectiveTree={
    clear_q10300 = {
        target_q10300 = {
            area_q10300 = {},
        },
        q10300_cp = {},
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
	mafr_swampEast_ob = {
		high = {
			{ name = interSubpId, func = this.InterCall_vip_pos01, },
		},
	},
}

this.UniqueInterEnd_sol_q10300_0000 = function( soldier2GameObjectId, cpID )
	InfCore.Log("CallBack : Unique : End")
end

this.UniqueInterStart_sol_q10300_0000 = function( soldier2GameObjectId, cpID )
	InfCore.Log("CallBack : Unique : start ")
	--Kill me, Big Boss. I'm a mercenary too.  Always ready to die.
    TppInterrogation.UniqueInterrogation( cpID, "enqt1000_103730")
	return true
end

this.uniqueInterrogation = {
	unique = {
        --Kill me, Big Boss. I'm a mercenary too.  Always ready to die.
		{ name = "enqt1000_103730", func = this.UniqueInterEnd_sol_q10300_0000, },
	},
	uniqueChara = {
		{ name = targetName, func = this.UniqueInterStart_sol_q10300_0000, },
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
    local cpGameObjectId = GetGameObjectId("mafr_swampEast_ob")
	TppInterrogation.RemoveHighInterrogation(cpGameObjectId,this.interrogation.mafr_swampEast_ob.high)
end

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == false then
        local cpGameObjectId = GetGameObjectId("mafr_swampEast_ob")
		TppInterrogation.AddHighInterrogation(cpGameObjectId,this.interrogation.mafr_swampEast_ob.high)
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
    "area_q10300",
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