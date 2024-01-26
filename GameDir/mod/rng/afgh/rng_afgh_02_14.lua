--rng_afgh_02_14
local this={}

this.name="02_14"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/02_14/rng_afgh_02_14.fpk",
}

this.soldierDefine={
    afgh_02_14_lrrp={},
}

this.routeSets={
    afgh_02_14_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_02_14_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_02_14_lrrp={},
}

this.useGeneInter={
    afgh_02_14_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_02to14",
            "lrrp_14to02",
            "rp_02to14",
            "rp_14to02",
        }
    },
}

return this