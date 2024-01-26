local this={}

this.name="slopedTown"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/slopedTown/rng_afgh_slopedTown.fpk",
    "/Assets/tpp/pack/rng/afgh/op/slopedTown/rng_afgh_slopedTown_heli.fpk",
}

this.baseList={
    "slopedTown",
}

this.soldierDefine={
    afgh_slopedTown_cp={
        "sol_slopedTown_0000",
        "sol_slopedTown_0001",
        "sol_slopedTown_0002",
        "sol_slopedTown_0003",
        "sol_slopedTown_0004",
        "sol_slopedTown_0005",
        "sol_slopedTown_0006",
        "sol_slopedTown_0007",
        "sol_slopedTown_0008",
        "sol_slopedTown_0009",
        "sol_slopedTown_0010",
    },
}

this.routeSets={
    afgh_slopedTown_cp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_slopedTown_cp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_slopedTown_cp={},
}

this.useGeneInter={
    afgh_slopedTown_cp=true,
}

this.helicopterRouteList={
    "lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000",
    "lz_drp_slopedTown_E0000|rt_drp_slopedTown_E_0000",
    "lz_drp_slopedTown_W0000|rt_drp_slopedTown_W_0000",
}

this.landingZones={
    "lz_slopedTown_I0000|lz_slopedTown_I_0000",
    "lz_slopedTown_E0000|lz_slopedTown_E_0000",
    "lz_slopedTown_W0000|lz_slopedTown_W_0000",
}

this.travelRoadGroups={
    travel={
        W={
            "in_lrrpHold_W",
            "out_lrrpHold_W",
        },
        B01={
            "out_lrrpHold_B01",
        },
    },
}

return this