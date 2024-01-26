local this={}
local GetGameObjectId = GameObject.GetGameObjectId
local targetName = "veh_diamondWest_s10081_veh_0000"
local targetObjectiveName = "target_diamondWest_s10081_veh"
--Need a four-wheel drive? Check here...
local interSubpId = "enqt1000_1c1110"

this.name="diamondWest_s10081_veh"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/diamondWest/rng_mafr_diamondWest_s10081_veh.fpk",
}

this.vehicleDefine={
    instanceCount = 1,
}

this.vehicleSettings={
    {
        id="Spawn",
        locator=targetName,
        type=Vehicle.type.WESTERN_LIGHT_VEHICLE,
        paintType=Vehicle.paintType.FOVA_0,
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
            this.InterStop_diamondWest_lv()
            TppUI.ShowAnnounceLog"updateMap"
        end,
    },
}

this.interrogation={
    mafr_diamondWest_ob={
        high=this.interInfo,
        normal={},
    },
    mafr_diamond_cp={
        high={},
        normal=this.interInfo,
    },
    mafr_diamondSouth_ob={
        high={},
        normal=this.interInfo,
    },
    mafr_diamondNorth_ob={
        high={},
        normal=this.interInfo,
    },
}

function this.InterStop_diamondWest_lv()
    RngInter.RemoveInterrogation(this.interInfo)
end

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(targetObjectiveName) == true then
        this.InterStop_villageEast_lv()
    else
        RngInter.AddHighInterrogations(this.interInfo)
	end
end

this.Messages=function()
    local messages={}
    local targetMarkMessages={
        Marker={
            {
                msg="ChangeToEnable",
                sender=targetName,
                func=function(instanceName,makerType,gameObjectId,identificationCode)
                    TppMission.UpdateObjective{objectives={targetObjectiveName}}
                    this.InterStop_diamondWest_lv()
                end,
            },
        },
    }
    Rng.AppendMessages(messages,targetMarkMessages)
    return Tpp.StrCode32Table(messages)
end

return this