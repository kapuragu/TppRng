local this={}

local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT
local ApendArray=Tpp.ApendArray

this.locationName="AFGH"

this.common={}

this.common.packs={
    TppDefine.MISSION_COMMON_PACK.AFGH_SCRIPT,
    TppDefine.MISSION_COMMON_PACK.HELICOPTER,
    "/Assets/tpp/pack/rng/afgh/rng_afgh.fpk",
}

this.common.MissionPrepare=function()
    Gimmick.EnableAlarmLampAll(false)
end

this.npc={
    TppSoldier2={
        packs=function(missionCode)
            TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_MISSION_AREA)
            TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_DECOY)
            TppPackList.AddMissionPack"/Assets/tpp/pack/rng/afgh/npc/rng_afgh_soldier.fpk"
            local soldierCount = RngConfig.GetSelectedSoldierCount()
            local dynamicPacks = {
                [RngDefine.MAX_SOLDIER_STATE_COUNT]={
                    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_soldier_160.fpk",
                },
                [RngDefine.MAX_SOLDIER_STATE_COUNT_EXT]={
                    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_soldier_360.fpk",
                },
            }
            local packs = {}
            local maxCounts={} for cnt, pcks in pairs(dynamicPacks) do InfUtil.InsertUniqueInList(maxCounts,cnt) end
            packs = dynamicPacks[RngMission.GetHighestEntityCount(maxCounts, soldierCount)]
            for i, fpk in ipairs(packs) do
                TppPackList.AddMissionPack(fpk)
            end
        end,
        fovaSetupFunc=function(locationCode,missionId)
            local moreVariationMode=0
            if TppSoldierFace.IsMoreVariationMode~=nil then
                moreVariationMode=TppSoldierFace.IsMoreVariationMode()
            end
            local MAX_AFGAN_GRP=15
            local n=gvars.solface_groupNumber%MAX_AFGAN_GRP
            local faceGroupType=TppEnemyFaceGroupId.AFGAN_GRP_00+n
            local faceGroupTable=TppEneFova.GetFaceGroupTableAtGroupType(faceGroupType)
            TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
            if moreVariationMode>0 then
                for e=1,2 do
                    n=n+2
                    local e=(n%MAX_AFGAN_GRP)*2
                    local faceGroupType=TppEnemyFaceGroupId.AFGAN_GRP_00+(e)
                    local faceGroupTable=TppEneFova.GetFaceGroupTableAtGroupType(faceGroupType)
                    TppSoldierFace.OverwriteMissionFovaData{face=faceGroupTable}
                end
            end
            TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
            local bodies={
                {TppEnemyBodyId.svs0_rfl_v00_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rfl_v01_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rfl_v02_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v00_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v01_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v02_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_snp_v00_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rdo_v00_a,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rfl_v00_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rfl_v01_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rfl_v02_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v00_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v01_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_mcg_v02_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_snp_v00_b,MAX_REALIZED_COUNT},
                {TppEnemyBodyId.svs0_rdo_v00_b,MAX_REALIZED_COUNT},
            }
            if not TppEneFova.IsNotRequiredArmorSoldier(missionId)then
                local body={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}
                table.insert(bodies,body)
            end
            TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}
        end,
        telop={
            enemyCombatantsLangList = { "cast_soviet_soldiers" },
        },
        cpType=CpType.TYPE_SOVIET,
    },
    TppHostage2={
        packs=function(missionCode)
            TppPackList.AddMissionPack"/Assets/tpp/pack/rng/npc/rng_hostage.fpk"
            TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_HOSTAGE)
            local hostageCount = RngConfig.GetSelectedHostageCount()
            local dynamicPacks = {
                [RngDefine.MAX_HOSTAGE_STATE_COUNT]={
                    "/Assets/tpp/pack/rng/afgh/npc/rng_afgh_hostage2_32.fpk",
                }
            }
            local packs = {}
            local maxCounts={} for cnt, pcks in pairs(dynamicPacks) do InfUtil.InsertUniqueInList(maxCounts,cnt) end
            packs = dynamicPacks[RngMission.GetHighestEntityCount(maxCounts, hostageCount)]
            for i, fpk in ipairs(packs) do
                TppPackList.AddMissionPack(fpk)
            end
        end,
        fovaSetupFunc=function(locationCode,missionId)
            local prs2_main0_def_v00PartsAfghan="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts"
            --TODO sync with language
            TppEneFova.SetHostageFaceTable(missionId)
            local bodies={
                {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}
            }
            TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}
            TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs2_main0_v00}}
            TppHostage2.SetDefaultBodyFovaId{parts=prs2_main0_def_v00PartsAfghan,bodyId=TppEnemyBodyId.prs2_main0_v00}
        end,
    },
    TppVehicle2={
        packs=function(missionCode)
            local packs = {}
            
            local typePacks={
                [Vehicle.type.EASTERN_LIGHT_VEHICLE]={
                    type={
                        TppDefine.MISSION_COMMON_PACK.EAST_LV,
                        "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_bd_east_lv.fpk",
                    },
                },
                [Vehicle.type.EASTERN_TRUCK]={
                    type={
                        TppDefine.MISSION_COMMON_PACK.EAST_TRUCK,
                        "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_bd_east_trc.fpk",
                    },
                    subType={
                        [Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION]={
                            TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_AMMUNITION,
                            "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_at_east_trc_crg_ammunition.fpk",
                        },
                        [Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM]={
                            TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_DRUM,
                            "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_at_east_trc_crg_drum.fpk",
                        },
                        [Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR]={
                            TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_GENERATOR,
                            "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_at_east_trc_crg_generator.fpk",
                        },
                        [Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL]={
                            TppDefine.MISSION_COMMON_PACK.EAST_TRUCK_MATERIAL,
                            "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_at_east_trc_crg_material.fpk",
                        },
                    },
                },
                [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]={
                    type={
                        TppDefine.MISSION_COMMON_PACK.EAST_WAV,
                        "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_bd_east_wav.fpk",
                    },
                    subType={
                        [Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY]={
                            TppDefine.MISSION_COMMON_PACK.EAST_WAV_ROCKET,
                            "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_at_east_wav_rocket.fpk",
                        },
                    },
                },
                [Vehicle.type.EASTERN_TRACKED_TANK]={
                    type={
                        TppDefine.MISSION_COMMON_PACK.EAST_TANK,
                        "/Assets/tpp/pack/rng/afgh/vehicle/rng_veh_bd_east_tnk.fpk",
                    },
                },
            }

            local vehicleSettingsCollect=function(moduleTables)
                if moduleTables.vehicleSettings then
                    for index, vehicleSetting in ipairs(moduleTables.vehicleSettings) do
                        if vehicleSetting.type then
                            if typePacks[vehicleSetting.type] then
                                if vehicleSetting.subType then
                                    if typePacks[vehicleSetting.type].subType[vehicleSetting.subType] then
                                        Rng.AppendArrayU(packs,typePacks[vehicleSetting.type].subType[vehicleSetting.subType])
                                    end
                                end
                                Rng.AppendArrayU(packs,typePacks[vehicleSetting.type].type)
                            end
                        end
                    end
                end
            end
            RngConfig.OnSelectedModules(vehicleSettingsCollect)

            local vehicleCount = RngConfig.GetSelectedVehicleCount()
            local dynamicPacks = {
                [RngDefine.MAX_VEHICLE_STATE_COUNT]={
                    "/Assets/tpp/pack/rng/npc/rng_vehicle.fpk",
                },
            }
            local maxCounts={} for cnt, pcks in pairs(dynamicPacks) do InfUtil.InsertUniqueInList(maxCounts,cnt) end
            Rng.AppendArrayU(packs,dynamicPacks[RngMission.GetHighestEntityCount(maxCounts, vehicleCount)])

            for i, fpk in ipairs(packs) do
                TppPackList.AddMissionPack(fpk)
            end
        end,
    },
    TppCritterBird={
        packs=function(missionCode)
            TppPackList.AddMissionPack"/Assets/tpp/pack/rng/npc/rng_raven.fpk"
        end,
        MissionPrepare=function()
            TppRatBird.EnableBird( "TppCritterBird" )
        end,
    },
}

return this