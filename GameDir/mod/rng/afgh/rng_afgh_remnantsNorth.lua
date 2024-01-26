local this={}

this.name="remnantsNorth"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/remnantsNorth/rng_afgh_remnantsNorth.fpk",
    "/Assets/tpp/pack/rng/afgh/op/remnantsNorth/rng_afgh_remnantsNorth_heli.fpk",
}

this.baseList={
    "remnantsNorth",
}

this.soldierDefine={
    afgh_remnantsNorth_ob={
		"sol_remnantsNorth_0000",
		"sol_remnantsNorth_0001",
		"sol_remnantsNorth_0002",
		"sol_remnantsNorth_0003",
    },
}

this.routeSets={
    afgh_remnantsNorth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_remnantsNorth_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_remnantsNorth_ob={
        normal={
            --out of bounds
            --{name="enqt1000_1f1m10",func=TppGeneInter.InterCall_remnantsNorth_002},
        },
    },
}

this.useGeneInter={
    afgh_remnantsNorth_ob=true,
}

this.helicopterRouteList={
    "lz_drp_remnantsNorth_S0000|rt_drp_remnantsNorth_S_0000",
    "lz_drp_remnantsNorth_N0000|rt_drp_remnantsNorth_N_0000",
}

this.landingZones={
    "lz_remnantsNorth_S0000|lz_remnantsNorth_S_0000",
    "lz_remnantsNorth_N0000|lz_remnantsNorth_N_0000",
}

this.travelRoadGroups={
    travel={
        N={
            "in_lrrpHold_N",
            "out_lrrpHold_N",
        },
        S={
            "in_lrrpHold_S",
            "out_lrrpHold_S",
        },
    },
}

return this