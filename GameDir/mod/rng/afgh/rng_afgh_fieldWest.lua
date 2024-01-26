local this={}

this.name="fieldWest"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/fieldWest/rng_afgh_fieldWest.fpk",
    "/Assets/tpp/pack/rng/afgh/op/fieldWest/rng_afgh_fieldWest_heli.fpk",
}

this.baseList={
    "fieldWest",
}

this.soldierDefine={
    afgh_fieldWest_ob={
		"sol_fieldWest_0000",
		"sol_fieldWest_0001",
		"sol_fieldWest_0002",
    },
}

this.routeSets={
    afgh_fieldWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_fieldWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_fieldWest_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_fieldWest_002},
        },
    },
}

this.useGeneInter={
    afgh_fieldWest_ob=true,
}

this.helicopterRouteList={
    "lz_drp_fieldWest_S0000|rt_drp_fiieldWest_S_0000",
}

this.landingZones={
    "lz_fieldWest_S0000|lz_fieldWest_S_0000",
}

this.travelRoadGroups={
    travel={
        S={
            "in_lrrpHold_S",
        },
        B01={
            "out_lrrpHold_B01",
        },
        B02={
            "out_lrrpHold_B02",
        },
        B03={
            "out_lrrpHold_B03",
        },
    },
}

return this