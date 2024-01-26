local this={}

this.name="ruinsNorth"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/ruinsNorth/rng_afgh_ruinsNorth.fpk",
    "/Assets/tpp/pack/rng/afgh/op/ruinsNorth/rng_afgh_ruinsNorth_heli.fpk",
}

this.baseList={
    "ruinsNorth",
}

this.soldierDefine={
    afgh_ruinsNorth_ob={
		"sol_ruinsNorth_0000",
		"sol_ruinsNorth_0001",
		"sol_ruinsNorth_0002",
    },
}

this.routeSets={
    afgh_ruinsNorth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_ruinsNorth_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_ruinsNorth_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_ruinsNorth_002},
        },
    },
}

this.useGeneInter={
    afgh_ruinsNorth_ob=true,
}

this.helicopterRouteList={
    "lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",
}

this.landingZones={
    "lz_ruinsNorth_S0000|lz_ruinsNorth_S_0000",
}

this.travelRoadGroups={
    travel={
        N={
            "in_lrrpHold_N",
            "out_lrrpHold_N",
        },
        S={
            "in_lrrpHold_S",
            "out_lrrpHold_S",
        },
    },
}

return this