local this={}
local StrCode32 = Fox.StrCode32
local GetGameObjectId = GameObject.GetGameObjectId
local soldierNames={
    "sol_15_35_0000",
    "sol_15_35_0001",
}
local travelName = "travel_15_35_slopedTown"
--The inspection will follow this route...
local interSubpId = "enqt1000_106984"
local interObjectiveName = travelName

this.name="15_35_slopedTown"

this.needDefault=true
this.need={
    "slopedTown",
    "02_35",
    "commWest",
    "14_35",
    "villageNorth",
    "15_35",
    "slopedWest",
}

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/15_35/rng_afgh_15_35_slopedTown.fpk",
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
				Vector3( 304,323,62 ),--afgh_15_35_lrrp
				Vector3( 97,333,82 ),--afgh_slopedWest_ob
				Vector3( 304,323,62 ),--afgh_15_35_lrrp
				Vector3( 512,331,38 ),--afgh_slopedTown_cp
				Vector3( 389,367,465 ),--afgh_14_35_lrrp
				Vector3( 508,329,702 ),--afgh_villageNorth_ob
				Vector3( 389,367,465 ),--afgh_14_35_lrrp
				Vector3( 512,331,38 ),--afgh_slopedTown_cp
				Vector3( 916,378,389 ),--afgh_02_35_lrrp
				Vector3( 1005,346,655 ),--afgh_commWest_ob
				Vector3( 916,378,389 ),--afgh_02_35_lrrp
				Vector3( 512,331,38 ),--afgh_slopedTown_cp
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
    afgh_15_35_lrrp = {
        soldierNames[1],
        soldierNames[2],
        lrrpTravelPlan=travelName,
    },
}

this.travelPlans = {
	[travelName]= {
		{ base = "afgh_slopedTown_cp", },
		{ base = "afgh_villageNorth_ob", },
		{ base = "afgh_slopedTown_cp", },
		{ base = "afgh_commWest_ob", },
		{ base = "afgh_slopedTown_cp", },
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
    afgh_slopedEast_ob={high={},normal=this.interInfo,},
    afgh_slopedTown_cp={high={},normal=this.interInfo,},
    afgh_villageNorth_ob={high={},normal=this.interInfo,},
    afgh_commWest_ob={high={},normal=this.interInfo,},
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