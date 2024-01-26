local this={}

this.name="slopedWest"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/slopedWest/rng_afgh_slopedWest.fpk",
}

this.baseList={
    "slopedWest",
}

this.soldierDefine={
    afgh_slopedWest_ob={
        "sol_slopedWest_0000",
        "sol_slopedWest_0001",
        "sol_slopedWest_0002",
    },
}

this.routeSets={
    afgh_slopedWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_slopedWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_slopedWest_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_slopedWest_002},
        },
    },
}

this.useGeneInter={
    afgh_slopedWest_ob=true,
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