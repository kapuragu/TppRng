local this={}
local StrCode32 = Fox.StrCode32
local GetGameObjectId = GameObject.GetGameObjectId
local soldierNames={
    "sol_02_34_0000",
    "sol_02_34_0001",
}
local travelName = "travel_02_34_commFacility"
--The inspection will follow this route...
local interSubpId = "enqt1000_106984"
local interObjectiveName = travelName

this.name="02_34_commFacility"

this.needDefault=true
this.need={
    "02_34",
    "commFacility",
    "13_34",
    "ruinsNorth",
    "commWest",
}

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/02_34/rng_afgh_02_34_commFacility.fpk",
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
				Vector3( 1221,349,424 ),--afgh_02_34_lrrp
				Vector3( 1005,346,655 ),--afgh_commWest_ob
				Vector3( 1221,349,424 ),--afgh_02_34_lrrp
				Vector3( 1482,356,459 ),--afgh_commFacility_cp
				Vector3( 1617,382,775 ),--afgh_13_34_lrrp
				Vector3( 1627,322,1057 ),--afgh_ruinsNorth_ob
				Vector3( 1617,382,775 ),--afgh_13_34_lrrp
				Vector3( 1482,356,459 ),--afgh_commFacility_cp
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
    afgh_02_34_lrrp = {
        soldierNames[1],
        soldierNames[2],
        lrrpTravelPlan=travelName,
    },
}

this.travelPlans = {
	[travelName]= {
		{ base = "afgh_commWest_ob", },
		{ base = "afgh_commFacility_cp", },
		{ base = "afgh_ruinsNorth_ob", },
		{ base = "afgh_commFacility_cp", },
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
    afgh_commWest_ob={high={},normal=this.interInfo,},
    afgh_commFacility_cp={high={},normal=this.interInfo,},
    afgh_ruinsNorth_ob={high={},normal=this.interInfo,},
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