local this={}

this.name="villageNorth"

this.packs={
    "/Assets/tpp/pack/rng/afgh/op/villageNorth/rng_afgh_villageNorth.fpk",
}

this.baseList={
    "villageNorth",
}

this.soldierDefine={
    afgh_villageNorth_ob={
        "sol_villageNorth_0000",
        "sol_villageNorth_0001",
        "sol_villageNorth_0002",
        "sol_villageNorth_0003",
    },
}

this.routeSets={
    afgh_villageNorth_ob={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_villageNorth_ob={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_villageNorth_ob={
        normal={
            {name="enqt1000_1f1m10",func=TppGeneInter.InterCall_villageNorth_002},
        },
    },
}

this.useGeneInter={
    afgh_villageNorth_ob=true,
}

return this