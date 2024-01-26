--rng_afgh_13_34
local this={}

this.name="13_34"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/13_34/rng_afgh_13_34.fpk",
}

this.soldierDefine={
    afgh_13_34_lrrp={},
}

this.routeSets={
    afgh_13_34_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_13_34_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_13_34_lrrp={},
}

this.useGeneInter={
    afgh_13_34_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_13to34",
            "lrrp_34to13",
            "rp_13to34",
            "rp_34to13",
        }
    },
}

return this