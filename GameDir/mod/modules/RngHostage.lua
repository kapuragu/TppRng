--RngHostage.lua
local this={}

local StrCode32 = Fox.StrCode32
local IsTypeTable = Tpp.IsTypeTable
local ApendArray = Tpp.ApendArray
local GetGameObjectId = GameObject.GetGameObjectId
local SendCommand = GameObject.SendCommand
local NULL_ID = GameObject.NULL_ID

--CARRY MONOLOGUE

local svarCntSuf="_carimono"
local carryStartSuf="_CarryTalkStart"
local timerSuf="_NextMonologue"

function this.IsCarried(gameObjectId)
    local command = { id = "GetStatus", }
    local actionStatus = SendCommand( gameObjectId, command )
    if actionStatus == TppGameObject.NPC_STATE_CARRIED then
        InfCore.Log("RngHostage hostageName is Carring!!!")
        return true
    end
    return false
end

function this.CallMonologue(gameObjectId,labelName)
    InfCore.Log("RngHostage Monologue labelName Play!!!".. tostring(labelName))
    SendCommand(gameObjectId,{id="CallMonologue",label=labelName,reset=true})
end

function this.RegisterSVarsForCariMono(cariMonoTable)
    local saveVars={}
    if not IsTypeTable(cariMonoTable) then
        return saveVars
    end
    for hostageName, cariMono in pairs(cariMonoTable) do
        local svarName = hostageName..svarCntSuf
        saveVars[svarName] = 0
    end
    InfCore.PrintInspect(saveVars,"RngHostage: declareSVars")
    return TppSequence.MakeSVarsTable(saveVars)
end

function this.RegisterMessagesForCariMono(cariMonoTable)
    local messages={}
    if not IsTypeTable(cariMonoTable) then
        return messages
    end
    for hostageName, cariMono in pairs(cariMonoTable) do
        local svarName = hostageName..svarCntSuf
        local monoTable = cariMono.monologues
        local carryCount = #monoTable
        local timerName = hostageName..carryStartSuf
        local timerNames={
            timerName,
        }
        local timerList={
            carryTalkStart={
                timerName = timerName,
                time = 7,
                onFinish = function()
                    mvars.isCarryTalkStart=mvars.isCarryTalkStart or{}
                    mvars.isCarryTalkStart[hostageName] = true
                    local gameObjectId = GetGameObjectId( hostageName )
                    local monologueIndex = svars[svarName]+1
                    if monologueIndex < carryCount then
                        local monologue = monoTable[monologueIndex]
                        local labelName = monologue.label
                        if this.IsCarried(gameObjectId) then
                            this.CallMonologue(gameObjectId,labelName)
                        else
                            InfCore.Log("RngHostage "..hostageName.." Monologue Player Not Carry Hostage!!!".. tostring(labelName))
                        end
                    end
                end,
            }
        }
        for index, monologue in ipairs(monoTable) do
            if monologue.nextDelay then
                local monologueTimerName=monologue.label..timerSuf
                table.insert(timerNames,monologueTimerName)
                local carryTimer={
                    timerName=monologueTimerName,
                    time=monologue.nextDelay,
                    onFinish=function()
                        local gameObjectId = GetGameObjectId(hostageName)
                        if RngHostage.IsCarried(gameObjectId) then
                            local monologueIndex = svars[svarName]+1
                            local monologue = monoTable[monologueIndex]
                            local labelName = monologue.label
                            RngHostage.CallMonologue(gameObjectId,labelName)
                        end
                    end
                }
                timerList[monologue.label]=carryTimer
            end
        end
        local cariMonoMessages={
            GameObject={
                {
                    msg = "Carried",
                    sender = hostageName,
                    func = function(gameObjectId,carriedState)
                        mvars.isCarryTalkStart=mvars.isCarryTalkStart or{}
                        if svars[svarName] < carryCount then
                            if not mvars.isCarryTalkStart[hostageName] then
                                Rng.SetTimer{ timerList = timerList.carryTalkStart}
                                return
                            end
                            if carriedState == TppGameObject.NPC_CARRIED_STATE_IDLE_START then
                                InfCore.Log("RngHostage "..hostageName.." Carried End!!!")
                                local monologueIndex = svars[svarName]+1
                                local labelName = monoTable[monologueIndex].label
                                this.CallMonologue(gameObjectId,labelName)
                            else
                                InfCore.Log("RngHostage "..hostageName.." Carried Start!!!")
                            end
                        else
                            if mvars.isCarryTalkStart[hostageName] then
                                mvars.isCarryTalkStart[hostageName]=nil
                            end
                        end
                    end
                },
                {
                    msg = "MonologueEnd",
                    sender = hostageName,
                    func = function(gameObjectId,labelNameS32,isSuccess)
                        if isSuccess == 1 then
                            local monologueIndex = svars[svarName]+1
                            local labelName = monoTable[monologueIndex].label
                            if labelNameS32 == StrCode32(labelName) then
                                InfCore.Log("RngHostage Monologue speechLabel "..labelName)
                                InfCore.Log("RngHostage Monologue speechLabel ".. tostring(svars[svarName]))
                                svars[svarName] = svars[svarName] + 1
                                if RngHostage.IsCarried(gameObjectId) then
                                    Rng.SetTimer{timerList=timerList[labelName]}
                                end
                            end
                        else
                            InfCore.Log("RngHostage Monologue failed !!")
                        end
                    end
                },
            },
            Timer = {
                {
                    msg = "Finish",
                    sender = timerNames,
                    func = function(timerNameS32)
                        for timerListName, _timerList in pairs(timerList) do
                            if timerNameS32==StrCode32(_timerList.timerName) then
                                if _timerList.onFinish then
                                    _timerList.onFinish()
                                end
                            end
                        end
                    end
                },
            },
        }
        Rng.AppendMessages(messages,cariMonoMessages)
    end
    return messages
end

--DEAD CALLBACK

function this.RegisterOnDeadGameOverMessage(deadGameOverLocators)
    local messages={}
    if not IsTypeTable(deadGameOverLocators) then
        return messages
    end
    local deadGameOverMessage={
        GameObject={
            {
                msg = "Dead",
                sender = deadGameOverLocators,
                func = function(gameObjectId,attackerGameObjectId,playerPhase,deadMessageFlag)
                    mvars.deadNPCId=gameObjectId
                    TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.TARGET_DEAD,TppDefine.GAME_OVER_RADIO.TARGET_DEAD)
                end,
            },
        },
    }
    Rng.AppendMessages(messages,deadGameOverMessage)
    return messages
end

function this.SystemCallbackOnGameOver(deadGameOverLocators)
    if mvars.deadNPCId==nil then
        return
    end
    local gameObjectName
    for index, _gameObjectName in ipairs(deadGameOverLocators) do
        if GetGameObjectId(_gameObjectName) ~= NULL_ID then
            if GetGameObjectId(_gameObjectName) == mvars.deadNPCId then
                gameObjectName=_gameObjectName
                break
            end
        end
    end
    if gameObjectName then
        if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.TARGET_DEAD ) then
            TppPlayer.SetTargetDeadCamera{ gameObjectId = mvars.deadNPCId }
            mvars.deadNPCId=nil
            TppMission.ShowGameOverMenu{ delayTime = TppDefine.GAME_OVER_TARGET_DEAD_DEMO_TIME }
            return true
        end
    end
end

return this