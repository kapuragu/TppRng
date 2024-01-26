--rng_afgh_01_32
local this={}

this.name="01_32"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/01_32/rng_afgh_01_32.fpk",
}

this.soldierDefine={
    afgh_01_32_lrrp={},
}

this.routeSets={
    afgh_01_32_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_01_32_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_01_32_lrrp={},
}

this.useGeneInter={
    afgh_01_32_lrrp=true,
}

this.travelRoadGroups={
    travel={
        lrrp={
            "lrrp_01to32",
            "lrrp_32to01",
            "rp_01to32",
            "rp_32to01",
        }
    },
}

return this