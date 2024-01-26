--Rng.lua
local this={}

local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local ApendArray = Tpp.ApendArray

this.registerIvars={
    "rngMissionSeed",
    "rngMissionRestartReshuffle",
}

function this.rngMissionActivate()
    TppMission.ReserveMissionClear{
        missionClearType = TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,
        nextMissionId = RngDefine.rngMissionId,
    }
end

this.rngMissionRestartReshuffle={
    range=Ivars.switchRange,
    settingNames="set_switch",
    save=IvarProc.CATEGORY_EXTERNAL,
    default=1,
}

this.rngMissionSeed={
    range={min=-2147483647,max=2147483647},
    default=math.random(0,2147483647),
    save=IvarProc.CATEGORY_EXTERNAL,
}

function this.IsRestartReshuffle()
    return Ivars.rngMissionRestartReshuffle:Is(1)
end

this.registerMenus={
    "rngMissionMenu",
}

this.rngMissionMenu={
    parentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu"},
    options={
        --"Rng.rngMissionActivate",
        "Ivars.rngMissionRestartReshuffle",
        --"Ivars.rngMissionSeed",
    },
}
--infutil but unique
function this.MergeTable(t1, t2)
    local addToTbl = function(k,t,v)
        if type(k)=="number" then
            InfUtil.InsertUniqueInList(t,v)
        else
            if t[k]==nil then
                t[k] = v
            end
        end
    end
    for k,v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                this.MergeTable(t1[k] or {}, t2[k] or {})
            else
                addToTbl(k,t1,v)
            end
        else
            addToTbl(k,t1,v)
        end
    end
    return t1
end

--Tpp.ApendArray + InfUtil.InsertUniqueInList
function this.AppendArrayU(destTable,sourceTable)
    for k,v in pairs(sourceTable)do
        local hasValue=this.ArrayContains(destTable,v)
        if hasValue then
            InfCore.Log("AppendArrayU The destTable remains the same")
            break
        else
            destTable[#destTable+1]=v
            InfCore.PrintInspect(destTable,"AppendArrayU destTable")
        end
    end
end

function this.ArrayContains(destTable,v)
    for i,value in ipairs(destTable)do
        if value==v then
            return true
        end
    end
    return false
end

function this.AppendMessages(destMessages,sourceMessages)
    for messageGroup, messageEntrys in pairs(sourceMessages) do
        destMessages[messageGroup]=destMessages[messageGroup] or{}
        ApendArray(destMessages[messageGroup],messageEntrys)
    end
    InfCore.PrintInspect(destMessages,"AppendMessages destMessages")
end

function this.GetTableFuncParamTable(_tableFunc)
    local settings={}
    if _tableFunc then
        local tableFunc = _tableFunc
        if IsTypeFunc(tableFunc) then
            tableFunc = tableFunc()
        end
        if IsTypeTable(tableFunc) then
            settings=tableFunc
        end
    end
    InfCore.PrintInspect(settings,"Rng: GetTableFuncParamTable settings")
    return settings
end

--count string table
function this.CountStringTable(hostageDefine)
    local hostageCount = 0
    if hostageDefine then
        for index, hostageName in ipairs(hostageDefine) do
            if IsTypeString(hostageName) then
                hostageCount = hostageCount + 1
            end
        end
    end
    return hostageCount
end

function this.SetTimer( params )
    if params==nil then
        return
    end
	local timerName
	local time
	local stop
	if params.timerList then
		timerName	= params.timerList.timerName or nil
		time		= params.timerList.time or nil
		stop		= params.timerList.stop or false
	else
		timerName	= params.timerName or nil
		time		= params.time or nil
		stop		= params.stop or false
	end
	if stop == true then
		GkEventTimerManager.Stop( timerName )
	end
	if timerName == nil or time == nil then
		return
	end
	if not GkEventTimerManager.IsTimerActive( timerName ) then
		GkEventTimerManager.Start( timerName, time )
	end
end

return this