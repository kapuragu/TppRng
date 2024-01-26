local this={}

this.name="villageWest"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/villageWest/rng_afgh_villageWest.fpk",
}

this.baseList={
    "villageWest",
}

this.soldierDefine={
    afgh_villageWest_ob={
        "sol_villageWest_0000",
        "sol_villageWest_0001",
        "sol_villageWest_0002",
    },
}

this.routeSets={
    afgh_villageWest_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_villageWest_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_villageWest_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_villageWest_002},
        },
    },
}

this.useGeneInter={
    afgh_villageWest_ob=true,
}

return this