local this={}

this.locationName="MAFR"
this.name="diamondWest"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/diamondWest/rng_mafr_diamondWest.fpk",
    "/Assets/tpp/pack/rng/mafr/op/diamondWest/rng_mafr_diamondWest_heli.fpk",
}

this.baseList={
    "diamondWest",
}

this.soldierDefine={
    mafr_diamondWest_ob={
        "sol_diamondWest_0000",
        "sol_diamondWest_0001",
        "sol_diamondWest_0002",
        "sol_diamondWest_0003",
        "sol_diamondWest_0004",
        "sol_diamondWest_0005",
    },
}

this.routeSets={
    mafr_diamondWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_diamondWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.helicopterRouteList={
    "lz_drp_diamondWest_S0000|lz_drp_diamondWest_S_0000",
}

this.landingZones={
    "lz_diamondWest_S0000|lz_diamondWest_S_0000",
}

return this