local this={}
local StrCode32 = Fox.StrCode32
local GetGameObjectId = GameObject.GetGameObjectId
local soldierNames={
    "sol_01_32_0000",
    "sol_01_32_0001",
}
local travelName = "travel_01_32_village"
--The inspection will follow this route...
local interSubpId = "enqt1000_106984"
local interObjectiveName = travelName

this.name="01_32_village"

this.needDefault=true
this.need={
    "01_32",
    "village",
    "04_32",
    "villageWest",
    "villageEast",
    "14_32",
    "villageNorth",
}

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/01_32/rng_afgh_01_32_village.fpk",
}

this.missionObjectiveDefine={
	[soldierNames[1]] = { 
		gameObjectName = soldierNames[1],
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = false,
        announceLog = "updateMap", 
	},
	[soldierNames[2]] = { 
		gameObjectName = soldierNames[2],
		goalType = "none", viewType = "map_and_world_only_icon",
        setNew = true, setImportant = false,
        announceLog = "updateMap", 
	},
	[interObjectiveName] = { 
		showEnemyRoutePoints = { --groupIndex=0,
			width=200.0,
			langId="marker_enemy_forecast_path",
			points={
				Vector3( 938,318,1261 ),--afgh_villageEast_ob
				Vector3( 755,319,1207 ),--afgh_01_32_lrrp
				Vector3( 514,323,1172 ),--afgh_village_cp
				Vector3( 414,323,985 ),--afgh_14_32_lrrp
				Vector3( 508,329,702 ),--afgh_villageNorth_ob
				Vector3( 414,323,985 ),--afgh_14_32_lrrp
				Vector3( 514,323,1172 ),--afgh_village_cp
				Vector3( 164,323,938 ),--afgh_04_32_lrrp
				Vector3( -251,297,939 ),--afgh_villageWest_ob
				Vector3( 164,323,938 ),--afgh_04_32_lrrp
				Vector3( 514,323.406,1172 ),--afgh_village_cp
				Vector3( 755,319,1207 ),--afgh_01_32_lrrp
			}
		},
		announceLog = "updateMap",
	},
}

this.missionObjectiveTree={
    [soldierNames[1]] = {
		[interObjectiveName]={},
	},
    [soldierNames[2]] = {
		[interObjectiveName]={},
	},
}

this.soldierDefine = {
    afgh_01_32_lrrp = {
        soldierNames[1],
        soldierNames[2],
        lrrpTravelPlan=travelName,
    },
}

this.travelPlans = {
	[travelName]= {
		{ base = "afgh_villageEast_ob", },
		{ base = "afgh_village_cp", },
		{ base = "afgh_villageNorth_ob", },
		{ base = "afgh_village_cp", },
		{ base = "afgh_villageWest_ob", },
		{ base = "afgh_village_cp", },
	},
}

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
    afgh_villageEast_ob={high={},normal=this.interInfo,},
    afgh_village_cp={high={},normal=this.interInfo,},
    afgh_villageNorth_ob={high={},normal=this.interInfo,},
    afgh_villageWest_ob={high={},normal=this.interInfo,},
}

function this.TargetFound(soldierName)
    TppMission.UpdateObjective{objectives={soldierName}}
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
                sender=soldierNames,
                func=function(instanceName,makerType,gameObjectId,identificationCode)
                    for index, soldierName in ipairs(soldierNames) do
                        if StrCode32(soldierName)==instanceName then
                            this.TargetFound(soldierName)
                            return
                        end
                    end
                end,
            },
        },
        GameObject={
            {
                msg="Dead",
                sender=soldierNames,
                func=function(gameObjectId)
                    for index, soldierName in ipairs(soldierNames) do
                        if GetGameObjectId(soldierName)==gameObjectId then
                            this.TargetFound(soldierName)
                            return
                        end
                    end
                end,
            },
            {
                msg="Fulton",
                sender=soldierNames,
                func=function(gameObjectId)
                    for index, soldierName in ipairs(soldierNames) do
                        if GetGameObjectId(soldierName)==gameObjectId then
                            this.TargetFound(soldierName)
                            return
                        end
                    end
                end,
            },
        },
    }
    Rng.AppendMessages(messages,targetMarkMessages)
    return Tpp.StrCode32Table(messages)
end

return this