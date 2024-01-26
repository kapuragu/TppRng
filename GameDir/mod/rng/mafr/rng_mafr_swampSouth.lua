local this={}

this.locationName="MAFR"
this.name="swampSouth"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/swampSouth/rng_mafr_swampSouth.fpk",
}

this.baseList={
    "swampSouth",
}

this.soldierDefine={
    mafr_swampSouth_ob={
        "sol_swampSouth_0000",
        "sol_swampSouth_0001",
        "sol_swampSouth_0002",
        "sol_swampSouth_0003",
        "sol_swampSouth_0004",
    },
}

this.routeSets={
    mafr_swampSouth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_swampSouth_ob={
        USE_COMMON_COMBAT=true,
    },
}

return this