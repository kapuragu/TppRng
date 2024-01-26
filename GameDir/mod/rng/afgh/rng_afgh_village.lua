local this={}

this.name="village"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/village/rng_afgh_village.fpk",
    "/Assets/tpp/pack/rng/afgh/op/village/rng_afgh_village_heli.fpk",
}

this.baseList={
    "village",
}

this.soldierDefine={
    afgh_village_cp={
        "sol_village_0000",
        "sol_village_0001",
        "sol_village_0002",
        "sol_village_0003",
        "sol_village_0004",
        "sol_village_0005",
        "sol_village_0006",
        "sol_village_0007",
        "sol_village_0008",
        "sol_village_0009",
    },
}

this.routeSets={
    afgh_village_cp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_village_cp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_village_cp={},
}

this.useGeneInter={
    afgh_village_cp=true,
}

this.helicopterRouteList={
    "lz_drp_village_N0000|rt_drp_village_N_0000",
    "lz_drp_village_W0000|rt_drp_village_W_0000",
}

this.landingZones={
    "lz_village_N0000|lz_village_N_0000",
    "lz_village_W0000|lz_village_W_0000",
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