--rng_afgh_15_35
local this={}

this.name="15_35"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/15_35/rng_afgh_15_35.fpk",
}

this.soldierDefine={
    afgh_15_35_lrrp={},
}

this.routeSets={
    afgh_15_35_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_15_35_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_15_35_lrrp={},
}

this.useGeneInter={
    afgh_15_35_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_14to32",
            "lrrp_32to14",
            "rp_14to32",
            "rp_32to14",
        }
    },
}

return this