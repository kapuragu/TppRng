local this={}

this.locationName="MAFR"
this.name="diamond"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/diamond/rng_mafr_diamond.fpk",
    "/Assets/tpp/pack/rng/mafr/op/diamond/rng_mafr_diamond_heli.fpk",
}

this.baseList={
    "diamond",
}

this.soldierDefine={
    mafr_diamond_cp={
        "sol_diamond_0000",
        "sol_diamond_0001",
        "sol_diamond_0002",
        "sol_diamond_0003",
        "sol_diamond_0004",
        "sol_diamond_0005",
        "sol_diamond_0006",
        "sol_diamond_0007",
        "sol_diamond_0008",
        "sol_diamond_0009",
        "sol_diamond_0010",
        "sol_diamond_0011",
    },
}

this.routeSets={
    mafr_diamond_cp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_diamond_cp={
        USE_COMMON_COMBAT=true,
    },
}

this.helicopterRouteList={
    "lz_drp_diamond_I0000|rt_drp_diamond_I_0000",
    "lz_drp_diamond_N0000|rt_drp_diamond_N_0000",
}

this.landingZones={
    "lz_diamond_I0000|lz_diamond_I_0000",
    "lz_diamond_N0000|lz_diamond_N_0000",
}

return this