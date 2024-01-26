local this={}
local GetGameObjectId = GameObject.GetGameObjectId
local driverName = "sol_13_34_s10043_0000"
local vehicleName = "veh_13_34_s10043_0000"
local travelName = "travel_13_34_s10043"
--The transport truck is taking this route...
local interSubpId = "enqt1000_106920"
local targetObjectiveName = vehicleName
local interObjectiveName = travelName

this.name="13_34_s10043"

this.needDefault=true
this.need={
    "13_34",
    "commFacility",
    "02_34",
    "commWest",
    "02_14",
    "villageNorth",
    "14_32",
    "village",
    "01_32",
    "villageEast",
    "01_13",
    "ruinsNorth",
}

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/13_34/rng_afgh_13_34_s10043.fpk",
}

this.vehicleDefine={
    instanceCount = 1,
}

this.vehicleSettings={
    {
        id="Spawn",
        locator=vehicleName,
        type=Vehicle.type.EASTERN_TRUCK,
        subType=Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR,
        priority = 2,
    },
}

this.helicopterRouteList={
    {pos={1598.551,352.656,415.707},rotY=76.096,action=PlayerInitialAction.SQUAT},
}

this.missionObjectiveDefine={
	[targetObjectiveName] = { 
		gameObjectName = vehicleName,
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = false,
        langId = "marker_info_truck",
        announceLog = "updateMap", 
	},
	[interObjectiveName] = { 
		showEnemyRoutePoints = { --groupIndex=0,
			width=200.0,
			langId="marker_enemy_forecast_path",
			points={
				Vector3( 1617,382,775 ),--afgh_13_34_lrrp
				Vector3( 1482,356,459 ),--afgh_commFacility_cp
				Vector3( 1221,349,424 ),--afgh_02_34_lrrp
				Vector3( 1005,346,655 ),--afgh_commWest_ob
				Vector3( 742,350,705 ),--afgh_02_14_lrrp
				Vector3( 508,329,702 ),--afgh_villageNorth_ob
				Vector3( 414,323,985 ),--afgh_14_32_lrrp
				Vector3( 514,323,1172 ),--afgh_village_cp
				Vector3( 755,319,1207 ),--afgh_01_32_lrrp
				Vector3( 938,318,1261 ),--afgh_villageEast_ob
				Vector3( 1311,337,1263 ),--afgh_01_13_lrrp
				Vector3( 1627,322,1057 ),--afgh_ruinsNorth_ob
				Vector3( 1617,382,775 ),--afgh_13_34_lrrp
			}
		},
		announceLog = "updateMap",
	},
}

this.missionObjectiveTree={
    [targetObjectiveName] = {
		[interObjectiveName]={},
	},
}

this.soldierDefine = {
    afgh_13_34_lrrp = {
        driverName,
        lrrpTravelPlan=travelName,
        lrrpVehicle=vehicleName,
    },
}

this.travelPlans = {
	[travelName]= {
		{ cp="afgh_13_34_lrrp",				routeGroup={ "travel", "lrrp_34to13" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_01_13_lrrp", 			routeGroup={ "travel", "lrrp_13to01" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_01_32_lrrp", 			routeGroup={ "travel", "lrrp_01to32" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_14_32_lrrp", 			routeGroup={ "travel", "lrrp_32to14" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_14_lrrp",				routeGroup={ "travel", "lrrp_14to02" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_34_lrrp",				routeGroup={ "travel", "lrrp_02to34" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
	},
}

this.reservedTravelPlans=this.travelPlans

this.interInfo={
    {
        name=interSubpId,
        func=function(gameObjectId,cpId,interName)
            TppMission.UpdateObjective{objectives={interObjectiveName}}
            this.InterStop_travel_path()
            TppUI.ShowAnnounceLog"updateMap"
        end,
    },
}

this.interrogation={
    afgh_13_34_lrrp={high={},normal=this.interInfo,},
    afgh_ruinsNorth_ob={high={},normal=this.interInfo,},
    afgh_01_13_lrrp={high={},normal=this.interInfo,},
    afgh_villageEast_ob={high={},normal=this.interInfo,},
    afgh_01_32_lrrp={high={},normal=this.interInfo,},
    afgh_village_cp={high={},normal=this.interInfo,},
    afgh_14_32_lrrp={high={},normal=this.interInfo,},
    afgh_villageNorth_ob={high={},normal=this.interInfo,},
    afgh_02_14_lrrp={high={},normal=this.interInfo,},
    afgh_commWest_ob={high={},normal=this.interInfo,},
    afgh_02_34_lrrp={high={},normal=this.interInfo,},
    afgh_commFacility_cp={high={},normal=this.interInfo,},
}

function this.TargetFound()
    TppMission.UpdateObjective{objectives={targetObjectiveName}}
    this.InterStop_travel_path()
end

function this.InterStop_travel_path()
    RngInter.RemoveInterrogation(this.interInfo)
end

function this.OnRestoreSVars()
	if TppMission.IsEnableAnyParentMissionObjective(interObjectiveName) == true then
        this.InterStop_travel_path()
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
                sender=vehicleName,
                func=function(instanceName,makerType,gameObjectId,identificationCode)
                    this.TargetFound()
                end,
            },
        },
        GameObject={
            {
                msg="VehicleBroken",
                sender=vehicleName,
                func=function(vehicleId,state)
                    this.TargetFound()
                end,
            },
        },
    }
    Rng.AppendMessages(messages,targetMarkMessages)
    return Tpp.StrCode32Table(messages)
end

return this