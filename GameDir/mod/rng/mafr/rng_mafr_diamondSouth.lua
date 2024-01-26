local this={}

this.locationName="MAFR"
this.name="diamondSouth"

this.packs={
    "/Assets/tpp/pack/rng/mafr/op/diamondSouth/rng_mafr_diamondSouth.fpk",
    "/Assets/tpp/pack/rng/mafr/op/diamondSouth/rng_mafr_diamondSouth_heli.fpk",
}

this.baseList={
    "diamondSouth",
}

this.soldierDefine={
    mafr_diamondSouth_ob={
        "sol_diamondSouth_0000",
        "sol_diamondSouth_0001",
        "sol_diamondSouth_0002",
        "sol_diamondSouth_0003",
        "sol_diamondSouth_0004",
        "sol_diamondSouth_0005",
    },
}

this.routeSets={
    mafr_diamondSouth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    mafr_diamondSouth_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.helicopterRouteList={
    "lz_drp_diamondSouth_S0000|lz_drp_diamondSouth_S_0000",
    "lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000",
}

this.landingZones={
    "lz_diamondSouth_S0000|lz_diamondSouth_S_0000",
    "lz_diamondSouth_W0000|lz_diamondSouth_W_0000",
}

return this