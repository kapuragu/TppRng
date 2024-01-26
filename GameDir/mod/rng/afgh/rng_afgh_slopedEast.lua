local this={}

this.name="slopedEast"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/slopedEast/rng_afgh_slopedEast.fpk",
    "/Assets/tpp/pack/rng/afgh/op/slopedEast/rng_afgh_slopedEast_heli.fpk",
}

this.baseList={
    "slopedEast",
}

this.soldierDefine={
    afgh_slopedEast_ob={
        "sol_slopedEast_0000",
        "sol_slopedEast_0001",
        "sol_slopedEast_0002",
        "sol_slopedEast_0003",
    },
}

this.routeSets={
    afgh_slopedEast_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_slopedEast_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_slopedEast_ob={},
}

this.useGeneInter={
    afgh_slopedEast_ob=true,
}

this.helicopterRouteList={
    "lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000",
}

this.landingZones={
    "lz_slopedTownEast_E0000|lz_slopedTownEast_E_0000",
}

this.travelRoadGroups={
    travel={
        W={
            "in_lrrpHold_W",
        },
        N={
            "out_lrrpHold_N",
        },
    },
}

return this