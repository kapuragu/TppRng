local this={}

this.randoTable={}

local afghTable={
    afgh_villageEast={},--1
    afgh_commWest={},--2
    afgh_cliffSouth={},--3
    afgh_villageWest={},--4
    afgh_bridgeWest={--5
        --soldier
        sol_q10060_00={},--Extract Soldier 06
        --hostage
        hos_q19013_00={},--Pashto Interpreter
    },
    afgh_tentEast={},--6
    afgh_enemyNorth={},--7
    afgh_cliffWest={},--8
    afgh_cliffEast={},--9
    afgh_fortWest={--10
        --hostage
        hos_q20905_00={},--Prisoner Extraction 05, under sunshade
    },
    afgh_slopedEast={},--11
    afgh_fortSouth={},--12
    afgh_ruinsNorth={--13
        --soldier
        sol_q19010_00={},--Russian Interpreter, outside hut
        --hostage
        hos_s10156_00={},--EXTRAORDINARY, inside hut
    },
    afgh_villageNorth={},--14
    afgh_slopedWest={},--15
    afgh_fieldEast={},--16
    afgh_plantSouth={},--17
    afgh_waterwayEast={--18
        --soldier
        sol_q10040_00={},--Extract Soldier 05, south buildings
        --intel
        int_q99012_00={},--Secure Quiet, in hut
    },
    afgh_plantWest={},--19
    afgh_fieldWest={},--20
    afgh_remnantsNorth={},--21
    afgh_tentNorth={},--22
    afgh_cliffTown={--23
        --Sakhra Ee Village
        --prisoner
        hos_s10044_00={},--OCCUPATION FORCES, east building
        hos_q20055_00={},--Prisoner Extraction 18, west building
        --intel
        int_s10044_00={},--OCCUPATION FORCES comm hut
    },
    afgh_tent={--24
        --Yakho Oboo Supply Outpost
        --hostage
        hos_s10052_00={},--ANGEL WITH BROKEN WINGS north cell
        hos_s10052_01={},--ANGEL WITH BROKEN WINGS north cell
        hos_q20015_00={},--Unlucky Dog 01, north cell
        hos_q99040_00={},--Secure the Man on Fire's Remains
        hos_q99072_00={},--Gunsmith 3, southeast wing
    },
    afgh_waterway={--25
        --Aabe Shifap Ruins
        --hostage
        hos_q20040_00={},--Prisoner Extraction 09, center
        hos_q20912_00={},--Secure Children 03, north tower
    },
    afgh_powerPlant={--26
        --Serak Power Plant
        --intel
        int_s10070_00={},--HELLBOUND hangar
    },
    afgh_sovietBase={--27
        --Soviet Central Base Camp
        --soldier
        sol_q10070_00={},--Extract Soldier 14
        --hostage
        hos_s10070_00={},--HELLBOUND north hangar
        hos_q99030_00={},--Secure the AI Pod, central hangar
        hos_q99070_00={},--Gunsmith 2, firing range tents, same routes as soldier 14
        hos_q20075_00={},--Prisoner Extraction 03, tent north of central hangar
    },
    afgh_remnants={--28
        --Lamar Khaate Palace
        --hostage
        hos_s10045_00={},--TO KNOW TOO MUCH, quiet exit house
        hos_s10052_00={},--ANGEL WITH BROKEN WINGS executed hostage
        hos_s10052_01={},--ANGEL WITH BROKEN WINGS executed hostage
        hos_s10052_02={},--ANGEL WITH BROKEN WINGS executed hostage
        hos_s10054_00={},--BACKUP, BACK DOWN cell hos_s10054_0003
        hos_q20910_00={},--Secure Children 04, top of south stairs
        hos_q21005_00={},--Prisoner Extraction 10, outside cells
        --intel
        int_s10052_00={},--ANGEL WITH BROKEN WINGS barracks building
    },
    afgh_field={--29
        --Shago Village
        --soldier
        sol_s10036_00={},--A HERO'S WAY target, in building
        sol_s10041_01={},--RED BRASS target, in building
        --hostage
        hos_s10045_01={},--TO KNOW TOO MUCH subtarget, in floor 1
        hos_s10045_02={},--TO KNOW TOO MUCH subtarget, in floor 2
        hos_q20025_00={},--Prisoner Extraction 02
    },
    afgh_citadel={--30
        --OKB Zero
        --soldier
        sol_q10090_00={},--Extract Soldier 16 stage three west buildings
        --hostage
        hos_q20095_00={},--Prisoner Extraction 19 stage three west builings
        hos_q22005_00={},--Unlucky Dog 05 Tan stage three east warehouse
        hos_q22005_01={},--Unlucky Dog 05 Prisoner 2 stage four east building
    },
    afgh_fort={--31
        --Smasei Fort
        --soldier
        sol_q10080_00={},--Extract Soldier 03, east tent
        --hostage
        hos_s10040_00={},--WHERE DO THE BEES SLEEP, bee room
        hos_q20911_00={},--Secure Children 05, caves, zombies
        hos_q20085_00={},--Unlucky Dog 02, east cell
    },
    afgh_village={--32
        --Wialo Village
        --soldier
        sol_s10041_02={},--RED BRASS in weapon room
        sol_q10020_00={},--Extract Soldier 02
        --hostage
        hos_s10043_00={},--C2W south rooms, east
        hos_s10043_01={},--C2W south rooms, west
        --intel
        int_s10020_00={},--PHANTOM LIMBS radio room
    },
    afgh_bridge={--33
        --Mountain Relay Base
        --hostage
        hos_q20805_00={},--Prisoner Extraction 04, west of bridge
    },
    afgh_commFacility={--34
        --Eastern Communications Post
        --hostage
        hos_q20065_00={},--Prisoner Extraction 01, comm hut
        --intel
        int_s10020_01={},--comm hut
    },
    afgh_slopedTown={--35
        --Ghwandai Town
        --soldier
        sol_q10050_00={},--Extract Soldier 04
        --hostage
        hos_s10020_00={},--PHANTOM LIMBS s10020_hostage_miller/q99080 kantoku
        hos_s10041_00={},--RED BRASS hos_subTarget_0000
        hos_s10041_01={},--RED BRASS hos_subTarget_0001
    },
    afgh_enemyBase={--36
        --Wakh Sind Barracks
        --soldier
        sol_s10020_00={},--PHANTOM LIMBS subtarget, barracks
        sol_s10041_00={},--RED BRASS sniper, building
        --hostages
        hos_s10033_00={},--OVER THE FENCE target/s10054 subtarget, in cell
        hos_s10033_01={},--OVER THE FENCE subtarget, on bridge
        --intel
        int_s10033_00={},--OVER THE FENCE hut south of the road
    },
    afgh_bridgeNorth={},--37
    afgh_enemyEast={},--38
    afgh_sovietSouth={},--39
    afgh_ruins={--40
        --Spugmay Keep
        --hostage
        hos_q20035_00={},--Prisoner Extraction 07
    },
}
this.randoTable[TppDefine.LOCATION_ID.AFGH]=afghTable

local mafrTable={
    mafr_outlandNorth_ob={},--1
	mafr_swampWest_ob={},--2
	mafr_outlandEast_ob={},--3
	mafr_bananaSouth_ob={},--4
	mafr_swampSouth_ob={--5
        --hostage
        hos_q20305_00={},--Prisoner Extraction 06
    },
	mafr_swampEast_ob={--6
        --soldier
        sol_q10300_00={},--Extract Soldier 09
        --intel
        int_s10090_03={},--TRAITORS CARAVAN
    },
	mafr_savannahWest_ob={},--7
	mafr_bananaEast_ob={--8
        --hostage
        hos_s10081_01={},--ROOT CAUSE on top of hill
    },
	mafr_savannahNorth_ob={},--9
	mafr_diamondWest_ob={--10
        --hostage
        hos_s10081_00={},--ROOT CAUSE, south house
    },
	mafr_diamondSouth_ob={},--11
	mafr_hillNorth_ob={--12
        --soldier
        sol_s10200_00={},--AIM TRUE, YE VENGEFUL
        --hostage
        hos_s10200_00={},--AIM TRUE, YE VENGEFUL under roof
        hos_s10195_00={},--ON THE TRAIL east building
        hos_q19012_00={},--Kikongo Interpreter, in house
    },
	mafr_savannahEast_ob={},--13
	mafr_hillWest_ob={},--14
	mafr_pfCampEast_ob={--15
        --intel
        int_s10090_00={},--TRAITORS CARAVAN
    },
	mafr_pfCampNorth_ob={--16
        --intel
        int_s10171_00={},--TRAITORS CARAVAN/PROXY WAR WITHOUT END
    },
	mafr_factorySouth_ob={--17
        --hostage
        hos_s10085_00={},--CLOSE CONTACT, central tent
        --intel
        int_s10100_00={},--VOICES, tent
    },
	mafr_diamondNorth_ob={},--18
	mafr_labWest_ob={},--19
	mafr_outland_cp={--20
        --Masa Village
        --soldier
        sol_s10080_00={},--PITCH DARK child teacher
        sol_s10120_00={},--THE WHITE MAMBA top of boat
        sol_q99071_00={},--Gunsmith 1
        --hostage
        hos_s10120_00={},--THE WHITE MAMBA center north house
    },
	mafr_flowStation_cp={--21
        --Mfinda Oilfield
        --soldier
        sol_q10100_00={},--Extract Soldier 08
        --hostage
        hos_q20913_00={},--Secure Children 01
    },
	mafr_swamp_cp={--22
        --Kiziba Camp
        --soldier
        sol_s10086_00={},--LINGUA FRANCA interrogator
        sol_s10211_00={},--HUNTING DOWN south east tent
        --hostage
        hos_s10086_00={},--LINGUA FRANCA outside roof northeast
        hos_s10086_01={},--LINGUA FRANCA west cage
        hos_s10086_02={},--LINGUA FRANCA near swamp north tin roof
        hos_s10086_03={},--LINGUA FRANCA east cage
        hos_s10091_00={},--INTEL AGENTS escaped forest
        hos_s10091_01={},--INTEL AGENTS pit near cages
        hos_s10091_02={},--INTEL AGENTS near swamp big house
        --intel
        int_s10086_00={},--LINGUA FRANCA comm hut
        int_s10091_00={},--INTEL AGENTS radio in forest
    },
	mafr_pfCamp_cp={--23
        --Nova Braga Airport
        --soldier
        sol_s10121_00={},--THE WAR ECONOMY comms room
        sol_s10171_00={},--PROXY WAR WITHOUT END west building
        --hostage
        hos_s10140_00={},--METALLIC ARCHAEA helicopter crash
        hos_q20205_00={},--Unlucky Dog 03, central tower roof
        hos_q20205_01={},--Unlucky Dog 03, tan, east roof
        hos_q25005_00={},--Prisoner Extraction 15, south hangar
    },
	mafr_savannah_cp={--24
        --Ditadi Abandoned Village
        --hostage
        hos_s10082_00={},--FOOTPRINTS OF PHANTOMS house ruin west
        hos_s10082_01={},--FOOTPRINTS OF PHANTOMS tent near comms
        hos_s10211_00={},--HUNTING DOWN south tent
        hos_s10211_01={},--HUNTING DOWN south east tent
        hos_s10211_02={},--HUNTING DOWN east tent
        --intel
        int_s10211_00={},--HUNTING DOWN/TRAITORS CARAVAN comm table
    },
	mafr_banana_cp={--25
        --Bampeve Plantation
        --soldier
        sol_s10100_00={},--BLOOD RUNS DEEP
        --hostage
        hos_q23005_00={},--Prisoner Extraction 08
    },
	mafr_diamond_cp={--26
        --Kungenga Mine
        --hostage
        hos_s10100_00={},--BLOOD RUNS DEEP in cave cage
        hos_q26005_00={},--Prisoner Extraction 14, under roof on center river
    },
	mafr_hill_cp={--27
        --Munoko ya Nioka Station
        --soldier
        sol_q10400_00={},--Extract Soldier 11
        --hostage
        hos_s10085_01={},--CLOSE CONTACT, south armory
        hos_q20405_00={},--Prisoner Extraction 20, center
        hos_q27005_00={},--Prisoner Extraction 16, north armory
    },
	mafr_factory_cp={--28
        --Ngumba Industrial Zone
        hos_s10110_00={},--VOICES in main building
    },
	mafr_lab_cp={--29
        --Lufwa Valley
        --soldier
        sol_s10093_00={},--CURSED LEGACY in mansion
        sol_q10700_00={},--Extract Soldier 15
        --hostage
        hos_s10130_00={},--CODE TALKER, basement
        hos_q20705_00={},--Unlucky Dog 04, south tent
        hos_q20705_01={},--Unlucky Dog 04, north west waterfall
        hos_q20914_00={},--Secure Children 05, ammo room
        --intel
        int_s10093_00={},--CURSED LEGACY, in south tent
        int_s10093_01={},--CURSED LEGACY, in mansion
    },
	mafr_hillWestNear_ob={},--30
	mafr_hillSouth_ob={},--31
	mafr_swampWestNear_ob={},--32
	mafr_chicoVilWest_ob={},--33
	mafr_chicoVil_cp={
        --Chico Village
    },--34
}
this.randoTable[TppDefine.LOCATION_ID.MAFR]=mafrTable

return this