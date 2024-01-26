--rng_afgh_02_34
local this={}

this.name="02_34"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/02_34/rng_afgh_02_34.fpk",
}

this.soldierDefine={
    afgh_02_34_lrrp={},
}

this.routeSets={
    afgh_02_34_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_02_34_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_02_34_lrrp={},
}

this.useGeneInter={
    afgh_02_34_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_02to34",
            "lrrp_34to02",
            "rp_02to34",
            "rp_34to02",
        }
    },
}

return this