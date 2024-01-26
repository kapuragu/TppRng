--rng_afgh_01_13
local this={}

this.name="01_13"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/01_13/rng_afgh_01_13.fpk",
}

this.soldierDefine={
    afgh_01_13_lrrp={},
}

this.routeSets={
    afgh_01_13_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_01_13_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_01_13_lrrp={},
}

this.useGeneInter={
    afgh_01_13_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_01to13",
            "lrrp_13to01",
            "rp_01to13",
            "rp_13to01",
        }
    },
}

return this