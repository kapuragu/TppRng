local this={}

this.locationName="MAFR"
this.name="diamondNorth"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/diamondNorth/rng_mafr_diamondNorth.fpk",
}

this.baseList={
    "diamondNorth",
}

this.soldierDefine={
    mafr_diamondNorth_ob={
        "sol_diamondNorth_0000",
        "sol_diamondNorth_0001",
        "sol_diamondNorth_0002",
        "sol_diamondNorth_0003",
        "sol_diamondNorth_0004",
        "sol_diamondNorth_0005",
    },
}

this.routeSets={
    mafr_diamondNorth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_diamondNorth_ob={
        USE_COMMON_COMBAT=true,
    },
}

return this