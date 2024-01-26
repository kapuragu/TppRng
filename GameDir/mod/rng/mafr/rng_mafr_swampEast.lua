local this={}

this.locationName="MAFR"
this.name="swampEast"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/swampEast/rng_mafr_swampEast.fpk",
    "/Assets/tpp/pack/rng/mafr/op/swampEast/rng_mafr_swampEast_heli.fpk",
}

this.baseList={
    "swampEast",
}

this.soldierDefine={
    mafr_swampEast_ob={
        "sol_swampEast_0000",
        "sol_swampEast_0001",
        "sol_swampEast_0002",
        "sol_swampEast_0003",
        "sol_swampEast_0004",
        "sol_swampEast_0005",
    },
}

this.routeSets={
    mafr_swampEast_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_swampEast_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.helicopterRouteList={
    "lz_drp_swampEast_N0000|lz_drp_swampEast_N_0000",
}

this.landingZones={
    "lz_swampEast_N0000|lz_swampEast_N_0000",
}

return this