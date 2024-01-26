local this={}

this.name="villageEast"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/villageEast/rng_afgh_villageEast.fpk",
}

this.baseList={
    "villageEast",
}

this.soldierDefine={
    afgh_villageEast_ob={
        "sol_villageEast_0000",
        "sol_villageEast_0001",
        "sol_villageEast_0002",
        "sol_villageEast_0003",
    },
}

this.routeSets={
    afgh_villageEast_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_villageEast_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_villageEast_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_villageEast_002},
        },
    },
}

this.useGeneInter={
    afgh_villageEast_ob=true,
}

return this