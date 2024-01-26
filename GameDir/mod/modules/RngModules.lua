--RngModules.lua
local this={}

local IsTypeTable = Tpp.IsTypeTable

--module load
this.rngFolder="rng"

function this.GetModules()
    return this.modules
end

function this.GetModulesForLocation(locationName)
    local modules = this.GetModules()
    if IsTypeTable(modules) then
        return modules[locationName]
    end
    return nil
end

function this.SetModules(modules)
    this.modules=modules
end

function this.PostAllModulesLoad(isReload)
    if isReload then
        this.LoadLibraries()
        mvars.rng_isContinueFromTitle=true
    end
end

function this.LoadLibraries()
    local modules={}
    local infoFiles=InfCore.GetFileList(InfCore.filesFull[this.rngFolder],".lua")
    for i,locationModuleFilePath in ipairs(infoFiles)do
        local locationPathSplits=InfUtil.Split(locationModuleFilePath,"/")
        if locationPathSplits[#locationPathSplits-1]==this.rngFolder  then
            local _locationModule=InfCore.LoadSimpleModule(locationModuleFilePath)
            local locationModule=_locationModule
            locationModule.areas={}
            local locationNameFolder=string.lower(locationModule.locationName)
            for j,areaModuleFilePath in ipairs(infoFiles) do
                local areaPathSplits=InfUtil.Split(areaModuleFilePath,"/")
                if areaPathSplits[#areaPathSplits-1]==locationNameFolder then
                    local _areaModule=InfCore.LoadSimpleModule(areaModuleFilePath)
                    local areaModule={}
                    areaModule.default=_areaModule
                    areaModule.modules={}
                    for k,actModuleFilePath in ipairs(infoFiles) do
                        local actPathSplits=InfUtil.Split(actModuleFilePath,"/")
                        if actPathSplits[#actPathSplits-1]==_areaModule.name 
                        and actPathSplits[#actPathSplits-2]==locationNameFolder then
                            local actModule=InfCore.LoadSimpleModule(actModuleFilePath)
                            areaModule.modules[actModule.name]=actModule
                        end
                    end
                    locationModule.areas[_areaModule.name]=areaModule
                end
            end
            modules[locationModule.locationName]=locationModule
        end
    end
    this.SetModules(modules)
    --InfCore.PrintInspect(this.modules,"this.modules")
end

return this