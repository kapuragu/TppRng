local this={}

this.name="fieldEast"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/fieldEast/rng_afgh_fieldEast.fpk",
}

this.baseList={
    "fieldEast",
}

this.soldierDefine={
    afgh_fieldEast_ob={
		"sol_fieldEast_0000",
		"sol_fieldEast_0001",
		"sol_fieldEast_0002",
    },
}

this.routeSets={
    afgh_fieldEast_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_fieldEast_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_fieldEast_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_fieldEast_002},
        },
    },
}

this.useGeneInter={
    afgh_fieldEast_ob=true,
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
        B01={
            "out_lrrpHold_B01",
        },
        B02={
            "out_lrrpHold_B02",
        },
    },
}

return this