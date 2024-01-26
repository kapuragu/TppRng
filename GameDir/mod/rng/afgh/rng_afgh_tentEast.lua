local this={}

this.name="tentEast"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/tentEast/rng_afgh_tentEast.fpk",
}

this.baseList={
    "tentEast",
}

this.soldierDefine={
    afgh_tentEast_ob={
		"sol_tentEast_0000",
		"sol_tentEast_0001",
		"sol_tentEast_0002",
		"sol_tentEast_0003",
    },
}

this.routeSets={
    afgh_tentEast_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_tentEast_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_tentEast_ob={
        normal={
            --out of bounds
            --{name="enqt1000_1f1m10",func=TppGeneInter.InterCall_tentEast_002},
        },
    },
}

this.useGeneInter={
    afgh_tentEast_ob=true,
}

return this