--RngPack.lua
local this={}

local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local ApendArray = Tpp.ApendArray

--[[
    packs={
        "/Assets....fpk"
    },
    packs=function(self)
        TppPackList.AddMissionPack("/Assets....fpk")
        TppHostage2.SetUniquePartsPath(...)
    end
]]

function this.AddModulePacks(moduleTables,missionCode)
    local packs=moduleTables.packs
    if packs then
        if IsTypeTable(packs) then
            for i, fpk in ipairs(packs) do
                TppPackList.AddMissionPack(fpk)
            end
        elseif IsTypeFunc(packs) then
            packs(missionCode)
        end
    end
end

--TppMissionList packs (external lua)
this.missionPacks=function(missionCode)
    local locModules=RngModules.GetModulesForLocation(RngConfig.GetSelectedLocationName())
    --npc modules
    local npcTable = locModules.npc
    if npcTable then
        for gameObjectType, gameObjectTable in pairs(npcTable) do
            if gameObjectTable then
                this.AddModulePacks(gameObjectTable,missionCode)
            end
        end
    end

    --active area modules
    local addModulePacks=function(moduleTables)
        this.AddModulePacks(moduleTables,missionCode)
    end
    RngConfig.OnSelectedModules(addModulePacks)

    --location modules
    local locCommon = locModules.common
    if locCommon then
        this.AddModulePacks(locCommon,missionCode)
    end
    TppPackList.AddMissionPack"/Assets/tpp/pack/rng/npc/rng_animal_block.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/rng/rng_radio.fpk"
    TppPackList.AddMissionPack"/Assets/tpp/pack/rng/rng_area.fpk"

    --uniquepartspath
    local setUpUniqueTableCollect=function(moduleTables)
        if IsTypeTable(moduleTables.SetUpUniqueTable) then
            for locatorName, uniqueTable in pairs(moduleTables.SetUpUniqueTable) do
                if uniqueTable.gameObjectType and uniqueTable.parts then
                    TppHostage2.SetUniquePartsPath{
                        gameObjectType=uniqueTable.gameObjectType,
                        locatorName=locatorName,
                        parts=uniqueTable.parts
                    }
                end
            end
        end
    end
    RngConfig.OnSelectedModules(setUpUniqueTableCollect)

    --unique settings
    --there's a limit so gotta keep track
    do
        local settings={}
        local addUniqueSettings=function(moduleTables)
            if moduleTables.uniqueSettings then
                local newSetting = Rng.GetTableFuncParamTable(moduleTables.uniqueSettings)
                if (#settings+#newSetting)<=RngDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT then
                    ApendArray(settings,newSetting)
                end
            end
        end
        RngConfig.OnSelectedModules(addUniqueSettings)
        InfCore.PrintInspect(settings,"RngPack: missionPacks settings")
        TppEneFova.AddUniqueSettingPackage(settings)
    end
end

return this