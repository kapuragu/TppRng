local this={}
local GetGameObjectId = GameObject.GetGameObjectId
local StrCode32 = Fox.StrCode32
local driverName = "sol_14_32_s10043_0000"
local vehicleName = "veh_14_32_s10043_0000"
local travelName = "travel_14_32_s10043"
--A fighting vehicle... is patrolling this route...
local interSubpId = "enqt1000_107037"
local targetObjectiveName = vehicleName
local interObjectiveName = travelName
local areaObjectiveName = "marker_s10043_tank_area"
local clearObjectiveName = "clear_14_32_s10043"

this.name="14_32_s10043"

this.needDefault=true
this.need={
    "14_32",
    "village",
    "01_32",
    "villageEast",
    "01_13",
    "ruinsNorth",
    "13_34",
    "commFacility",
    "02_34",
    "commWest",
    "02_14",
    "villageNorth",
    "14_35",
    "slopedTown",
}

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/14_32/rng_afgh_14_32_tank.fpk",
}

this.vehicleDefine={
    instanceCount = 1,
}

this.vehicleSettings={
    {
        id = "Spawn",
        locator = vehicleName,
        type = Vehicle.type.EASTERN_TRACKED_TANK,
        priority = 1,
    },
}

this.soldierDefine = {
    afgh_14_32_lrrp = {
        driverName,
        lrrpTravelPlan=travelName,
        lrrpVehicle=vehicleName,
    },
}

this.missionObjectiveDefine={
    [areaObjectiveName] = {
        gameObjectName = "marker_s10043_tank_area",
        visibleArea = 9, randomRange = 0,
        viewType = "all",
        setNew = true, setImportant = true,
        langId = "target_type_destruction",
    },
	[interObjectiveName] = { 
		showEnemyRoutePoints = { --groupIndex=0,
			width=200.0,
			langId="target_type_destruction",
			points={
				Vector3( 414,323,985 ),--afgh_14_32_lrrp
				Vector3( 508,329,702 ),--afgh_villageNorth_ob
				Vector3( 389,367,465 ),--afgh_14_35_lrrp
				Vector3( 512,331,38 ),--afgh_slopedTown_cp
				Vector3( 389,367,465 ),--afgh_14_35_lrrp
				Vector3( 508,329,702 ),--afgh_villageNorth_ob

				Vector3( 742,350,705 ),--afgh_02_14_lrrp
				Vector3( 1005,346,655 ),--afgh_commWest_ob
				Vector3( 1221,349,424 ),--afgh_02_34_lrrp
				Vector3( 1482,356,459 ),--afgh_commFacility_cp
				Vector3( 1617,382,775 ),--afgh_13_34_lrrp
				Vector3( 1627,322,1057 ),--afgh_ruinsNorth_ob
				Vector3( 1311,337,1263 ),--afgh_01_13_lrrp
				Vector3( 938,318,1261 ),--afgh_villageEast_ob
				Vector3( 755,319,1207 ),--afgh_01_32_lrrp
				Vector3( 514,323,1172 ),--afgh_village_cp
				Vector3( 414,323,985 ),--afgh_14_32_lrrp
			}
		},
		announceLog = "updateMap", 
	},
	[targetObjectiveName] = { 
		gameObjectName = vehicleName,
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = true,
        --langId = "marker_info_tank",
		langId = "target_type_destruction",
        announceLog = "updateMap", 
	},
    [clearObjectiveName] = {
        announceLog = "achieveAllObjectives",
    },
}

this.missionObjectiveTree={
    [clearObjectiveName] = {
		[targetObjectiveName] = {
			[interObjectiveName]={
				[areaObjectiveName]={},
			},
		},
	},
}

this.defaultObjectives={
    areaObjectiveName,
}

this.clearObjectiveName = {
    clearObjectiveName,
}

this.travelPlans = {
	[travelName]= {
		{ cp="afgh_14_32_lrrp", 			routeGroup={ "travel", "lrrp_14to32" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_01_32_lrrp", 			routeGroup={ "travel", "lrrp_32to01" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_01_13_lrrp", 			routeGroup={ "travel", "lrrp_01to13" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_13_34_lrrp",				routeGroup={ "travel", "lrrp_13to34" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_02_34_lrrp",				routeGroup={ "travel", "lrrp_34to02" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"out_lrrpHold_E_S" }, },
		{ cp="afgh_02_14_lrrp",				routeGroup={ "travel", "lrrp_02to14" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_E" }, },

		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E_W" }, },
		{ cp="afgh_14_35_lrrp",				routeGroup={ "travel", "lrrp_14to35" }, },
		{ cp="afgh_slopedTown_cp",          routeGroup={ "travel", 					"in_lrrpHold_W" }, },

		{ cp="afgh_slopedTown_cp",          routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_slopedTown_cp",          routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_14_35_lrrp",				routeGroup={ "travel", "lrrp_35to14" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_E" }, },

		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E_S" }, },
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
    afgh_14_32_lrrp={high={},normal=this.interInfo,},
    afgh_village_cp={high={},normal=this.interInfo,},
    afgh_01_32_lrrp={high={},normal=this.interInfo,},
    afgh_villageEast_ob={high={},normal=this.interInfo,},
    afgh_01_13_lrrp={high={},normal=this.interInfo,},
    afgh_ruinsNorth_ob={high={},normal=this.interInfo,},
    afgh_13_34_lrrp={high={},normal=this.interInfo,},
    afgh_commFacility_cp={high={},normal=this.interInfo,},
    afgh_02_34_lrrp={high={},normal=this.interInfo,},
    afgh_commWest_ob={high={},normal=this.interInfo,},
    afgh_02_14_lrrp={high={},normal=this.interInfo,},
    afgh_villageNorth_ob={high={},normal=this.interInfo,},
    afgh_slopedTown_cp={high={},normal=this.interInfo,},
}

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

function this.TargetFound()
	TppMission.UpdateObjective{objectives={targetObjectiveName}}
	this.InterStop_travel_path()
end

function this.OnExtract()
	this.OnEliminate()
end

function this.OnDestroyed()
	this.OnEliminate()
end

function this.OnEliminate()
	TppMission.UpdateObjective{objectives={clearObjectiveName}}
	this.InterStop_travel_path()
	RngMission.OnObjectiveClear()
end

this.registHoldRecoveredState={
    vehicleName,
}

this.systemCallbackTable={
    OnRecovered = function(s_gameObjectId)
        InfCore.Log("14_32_s10043:OnRecovered "..s_gameObjectId)
        if Tpp.IsVehicle( s_gameObjectId ) then
            if GetGameObjectId( vehicleName ) == s_gameObjectId then
                this.OnExtract()
            end
        end
    end,
}

this.setUpSearchTarget={
    {
        gameObjectName = vehicleName, gameObjectType = "TppVehicle2",
        messageName = vehicleName, offSet = Vector3(0,1.5,-0.25), doDirectionCheck = false,
        func = function(locatorNameS32,gameObjectId,messageNameS32)
            this.TargetFound()
        end,
    },
}

this.Messages=function()
    local messages={}
    local objectiveMessages={
        GameObject={
            {
                msg="VehicleBroken",
                sender=vehicleName,
                func=function(gameObjectId,stateS32)
					if stateS32==StrCode32"End" then
						this.OnDestroyed()
					end
                end,
            },
        },
    }
    Rng.AppendMessages(messages,objectiveMessages)
    return Tpp.StrCode32Table(messages)
end

return this