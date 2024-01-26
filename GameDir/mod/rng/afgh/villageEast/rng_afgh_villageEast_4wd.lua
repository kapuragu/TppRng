local this={}
local GetGameObjectId = GameObject.GetGameObjectId
local targetName = "veh_villageEast_4wd_0000"
local targetObjectiveName = "target_villageEast_4wd"
--Need a four-wheel drive? Check here...
local interSubpId = "enqt1000_1c1110"

this.name="villageEast_4wd"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/villageEast/rng_afgh_villageEast_4wd.fpk",
}

this.vehicleDefine={
    instanceCount = 1,
}

this.vehicleSettings={
    {
        id="Spawn",
        locator=targetName,
        type=Vehicle.type.EASTERN_LIGHT_VEHICLE,
    },
}

this.missionObjectiveDefine={
	[targetObjectiveName] = { 
		gameObjectName = targetName,
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = false,
        langId = "marker_info_vehicle_4wd",
        announceLog = "updateMap", 
	},
}

this.missionObjectiveTree={
    [targetObjectiveName] = {},
}

this.interInfo={
    {
        --Need a four-wheel drive? Check here...
        name=interSubpId,
        func=function(gameObjectId,cpId,interName)
            TppMission.UpdateObjective{objectives={targetObjectiveName}}
            this.InterStop_target()
            TppUI.ShowAnnounceLog"updateMap"
        end,
    },
}

this.interrogation={
    afgh_villageEast_ob={
        high=this.interInfo,
        normal={},
    },
    afgh_village_cp={
        high={},
        normal=this.interInfo,
    },
    afgh_ruinsNorth_ob={
        high={},
        normal=this.interInfo,
    },
    afgh_fieldEast_ob={
        high={},
        normal=this.interInfo,
    },
}

function this.InterStop_target()
    RngInter.RemoveInterrogation(this.interInfo)
end

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == true then
        this.InterStop_target()
    else
        RngInter.AddHighInterrogations(this.interInfo)
	end
end

this.Messages=function()
    local messages={}
    local targetMarkMessages={
        GameObject={
            {
                msg="ChangeToEnable",
                sender=targetName,
                func=function(instanceName,makerType,gameObjectId,identificationCode)
                    TppMission.UpdateObjective{objectives={targetObjectiveName}}
                    this.InterStop_target()
                end,
            },
        },
    }
    Rng.AppendMessages(messages,targetMarkMessages)
    return Tpp.StrCode32Table(messages)
end

return this