local this={}

this.description = "RNG"
this.missionCode = 13069
this.location = "CYPR" --vague location image
this.missionPacks = RngPack.missionPacks
this.isNoOrderBoxMission=true
this.enableOOB = true
this.fovaSetupFunc = RngFova.fovaSetupFunc

return this