local this={}

this.name="commWest"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/commWest/rng_afgh_commWest.fpk",
}

this.baseList={
    "commWest",
}

this.soldierDefine={
    afgh_commWest_ob={
		"sol_commWest_0000",
		"sol_commWest_0001",
		"sol_commWest_0002",
		"sol_commWest_0003",
    },
}

this.routeSets={
    afgh_commWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_commWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_commWest_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_commWest_002},
        },
    },
}

this.useGeneInter={
    afgh_commWest_ob=true,
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
        S_E={
            "in_lrrpHold_S_E",
            "out_lrrpHold_E_S",
        },
        S_W={
            "in_lrrpHold_S_W",
            "out_lrrpHold_W_S",
        },
    },
}

return this