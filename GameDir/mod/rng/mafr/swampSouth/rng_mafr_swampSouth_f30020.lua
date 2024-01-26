local this={}
local GetGameObjectId = GameObject.GetGameObjectId
local targetName = "veh_swampSouth_f30020_0000"
local targetObjectiveName = "target_swampSouth_f30020"
--Trucks... I'll tell you where they're parked...
local interSubpId = "enqt1000_1c1210"

this.name="swampSouth_f30020"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/swampSouth/rng_mafr_swampSouth_f30020.fpk",
}

this.vehicleDefine={
    instanceCount = 1,
}

this.vehicleSettings={
    {
        id="Spawn",
        locator=targetName,
        type = Vehicle.type.WESTERN_TRUCK,
        subType = Vehicle.subType.WESTERN_TRUCK_CARGO_CONTAINER,
        paintType=Vehicle.paintType.FOVA_1,
    },
}

this.missionObjectiveDefine={
	[targetObjectiveName] = { 
		gameObjectName = targetName,
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = false,
        langId = "marker_info_truck",
        announceLog = "updateMap", 
	},
}

this.missionObjectiveTree={
    [targetObjectiveName] = {},
}

this.interInfo={
    {
        name=interSubpId,
        func=function(gameObjectId,cpId,interName)
            TppMission.UpdateObjective{objectives={targetObjectiveName}}
            this.InterStop_swampSouth_lv()
            TppUI.ShowAnnounceLog"updateMap"
        end,
    },
}

this.interrogation={
    mafr_swampSouth_ob={
        high=this.interInfo,
        normal={},
    },
    mafr_swamp_cp={
        high={},
        normal=this.interInfo,
    },
    mafr_swampEast_ob={
        high={},
        normal=this.interInfo,
    },
    mafr_swampWest_ob={
        high={},
        normal=this.interInfo,
    },
}

function this.InterStop_swampSouth_lv()
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
                    this.InterStop_swampSouth_lv()
                end,
            },
        },
    }
    Rng.AppendMessages(messages,targetMarkMessages)
    return Tpp.StrCode32Table(messages)
end

return this