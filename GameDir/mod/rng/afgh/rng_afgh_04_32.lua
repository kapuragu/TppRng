--rng_afgh_04_32
local this={}

this.name="04_32"

this.packs={
    "/Assets/tpp/pack/rng/afgh/lrrp/04_32/rng_afgh_04_32.fpk",
}

this.soldierDefine={
    afgh_04_32_lrrp={},
}

this.routeSets={
    afgh_04_32_lrrp={
        USE_COMMON_ROUTE_SETS=true,
    },
}

this.combatSetting={
    afgh_04_32_lrrp={
        USE_COMMON_COMBAT=true,
    },
}

this.interrogation={
    afgh_04_32_lrrp={},
}

this.useGeneInter={
    afgh_04_32_lrrp=true,
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