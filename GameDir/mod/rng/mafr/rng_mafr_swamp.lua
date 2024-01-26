local this={}

this.locationName="MAFR"
this.name="swamp"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/swamp/rng_mafr_swamp.fpk",
    "/Assets/tpp/pack/rng/mafr/op/swamp/rng_mafr_swamp_heli.fpk",
}

this.baseList={
    "swamp",
}

this.soldierDefine={
    mafr_swamp_cp={
        "sol_swamp_0000",
        "sol_swamp_0001",
        "sol_swamp_0002",
        "sol_swamp_0003",
        "sol_swamp_0004",
        "sol_swamp_0005",
        "sol_swamp_0006",
        "sol_swamp_0007",
        "sol_swamp_0008",
        "sol_swamp_0009",
        "sol_swamp_0010",
        "sol_swamp_0011",
    },
}

this.routeSets={
    mafr_swamp_cp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_swamp_cp={
        USE_COMMON_COMBAT=true,
    },
}

this.helicopterRouteList={
    "lz_drp_swamp_S0000|rt_drp_swamp_S_0000",
    "lz_drp_swamp_I0000|rt_drp_swamp_I_0000",
    "lz_drp_swamp_N0000|lz_drp_swamp_N_0000",
    "lz_drp_swamp_W0000|lz_drp_swamp_W_0000",
}

this.landingZones={
    "lz_swamp_S0000|lz_swamp_S_0000",
    "lz_swamp_I0000|lz_swamp_I_0000",
    "lz_swamp_N0000|lz_swamp_N_0000",
    "lz_swamp_W0000|lz_swamp_W_0000",
}

return this