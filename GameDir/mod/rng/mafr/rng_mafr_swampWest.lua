local this={}

this.locationName="MAFR"
this.name="swampWest"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/swampWest/rng_mafr_swampWest.fpk",
}

this.baseList={
    "swampWest",
}

this.soldierDefine={
    mafr_swampWest_ob={
        "sol_swampWest_0000",
        "sol_swampWest_0001",
        "sol_swampWest_0002",
        "sol_swampWest_0003",
        "sol_swampWest_0004",
        "sol_swampWest_0005",
    },
}

this.routeSets={
    mafr_swampWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_swampWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

return this