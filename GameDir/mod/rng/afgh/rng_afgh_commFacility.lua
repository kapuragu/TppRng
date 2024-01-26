local this={}

this.name="commFacility"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/commFacility/rng_afgh_commFacility.fpk",
    "/Assets/tpp/pack/rng/afgh/op/commFacility/rng_afgh_commFacility_heli.fpk",
}

this.baseList={
    "commFacility",
}

this.soldierDefine={
    afgh_commFacility_cp={
		"sol_commFacility_0000",
		"sol_commFacility_0001",
		"sol_commFacility_0002",
		"sol_commFacility_0003",
		"sol_commFacility_0004",
		"sol_commFacility_0005",
		"sol_commFacility_0006",
		"sol_commFacility_0007",
		"sol_commFacility_0008",
    },
}

this.routeSets={
    afgh_commFacility_cp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_commFacility_cp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_commFacility_cp={},
}

this.useGeneInter={
    afgh_commFacility_cp=true,
}

this.helicopterRouteList={
    "lz_drp_commFacility_S0000|rt_drp_commFacility_S_0000",
    "lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000",
    --"lz_drp_commFacility_N0000|rt_drp_commFacility_N_0000", --TppLandingZone, "doesn't exist"
    "lz_drp_commFacility_W0000|rt_drp_commFacility_W_0000",
}

this.landingZones={
    "lz_commFacility_S0000|lz_commFacility_S_0000",
    "lz_commFacility_I0000|lz_commFacility_I_0000",
    "lz_commFacility_N0000|lz_commFacility_N_0000",
    "lz_commFacility_W0000|lz_commFacility_W_0000",
}

this.travelRoadGroups={
    travel={
        E={
            "in_lrrpHold_E",
            "out_lrrpHold_E",
        },
        W={
            "in_lrrpHold_W",
            "out_lrrpHold_W",
        },
    },
}

return this