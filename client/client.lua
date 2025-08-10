local RSGCore = exports['rsg-core']:GetCoreObject()
local SpawnedButcherBilps = {}
lib.locale()

--------------------------------------
-- butcher prompts and blips
--------------------------------------
Citizen.CreateThread(function()
    for _,v in pairs(Config.ButcherLocations) do
        if not Config.EnableTarget then
            exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds[Config.KeyBind], locale('cl_lang_1')..v.name, {
                type = 'client',
                event = 'rex-butcher:client:mainmenu',
            })
        end
        if v.showblip == true then
            local ButcherBlip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(ButcherBlip, joaat(Config.Blip.blipSprite), true)
            SetBlipScale(ButcherBlip, Config.Blip.blipScale)
            SetBlipName(ButcherBlip, Config.Blip.blipName)
            table.insert(SpawnedButcherBilps, ButcherBlip)
        end
    end
end)

--------------------------------------
-- butcher main menu
--------------------------------------
RegisterNetEvent('rex-butcher:client:mainmenu', function()
    lib.registerContext(
        {
            id = 'butcher_menu',
            title = locale('cl_lang_5'),
            position = 'top-right',
            options = {
                {
                    title = locale('cl_lang_6'),
                    description = locale('cl_lang_7'),
                    icon = 'fas fa-paw',
                    event = 'rex-butcher:client:sellanimal',
                },
                {
                    title = locale('cl_lang_8'),
                    description = locale('cl_lang_9'),
                    icon = 'fas fa-shopping-basket',
                    serverEvent = 'rex-butcher:server:openShop',
                },
            }
        }
    )
    lib.showContext('butcher_menu')
end)

--------------------------------------
-- sell animals
--------------------------------------
RegisterNetEvent('rex-butcher:client:sellanimal', function()

    local holding = GetFirstEntityPedIsCarrying(cache.ped)
    local model = GetEntityModel(holding)
    local quality = GetPedQuality(holding)

    if holding == 0 then
        lib.notify({ title = locale('cl_lang_10'), description = locale('cl_lang_11'), type = 'error', duration = 5000 })
        return
    end

    for i = 1, #Config.Animal do
        if model == Config.Animal[i].model then
            LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
            local rewardmoney = Config.Animal[i].rewardmoney
            local rewarditem1 = Config.Animal[i].rewarditem1
            local rewarditem2 = Config.Animal[i].rewarditem2
            local rewarditem3 = Config.Animal[i].rewarditem3
            local name = Config.Animal[i].name

            if lib.progressBar({
                duration = Config.SellTime,
                position = 'bottom',
                useWhileDead = false,
                canCancel = false,
                disableControl = true,
                disable = {
                    move = true,
                    mouse = true,
                },
                label = locale('cl_lang_12') .. name,
            }) then
                local deleted = DeleteThis(holding)
                if deleted then
                    if quality == false then
                        TriggerServerEvent('rex-butcher:server:reward', rewardmoney, rewarditem1, rewarditem2, rewarditem3, 'poor', name) -- poor quality reward
                    end
                    if quality == 0 then
                        TriggerServerEvent('rex-butcher:server:reward', rewardmoney, rewarditem1, rewarditem2, rewarditem3, 'poor', name) -- poor quality reward
                    end
                    if quality == 1 then
                        TriggerServerEvent('rex-butcher:server:reward', rewardmoney, rewarditem1, rewarditem2, rewarditem3, 'good', name) -- good quality reward
                    end
                    if quality == 2 then
                        TriggerServerEvent('rex-butcher:server:reward', rewardmoney, rewarditem1, rewarditem2, rewarditem3, 'perfect', name) -- perfect quality reward
                    end
                    if quality == -1 then
                        TriggerServerEvent('rex-butcher:server:reward', rewardmoney, rewarditem1, rewarditem2, rewarditem3, 'perfect', name) -- perfect quality reward
                    end
                else
                    lib.notify({ title = locale('cl_lang_13'), type = 'error', duration = 7000 })
                end
            end
            LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
        end
    end
end)

--------------------------------------
-- delete holding
--------------------------------------
function DeleteThis(holding)
    NetworkRequestControlOfEntity(holding)
    SetEntityAsMissionEntity(holding, true, true)
    Wait(100)
    DeleteEntity(holding)
    Wait(500)
    local entitycheck = GetFirstEntityPedIsCarrying(cache.ped)
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end

--  0: "PED_QUALITY_LOW"
--  1: "PED_QUALITY_MEDIUM"
--  2: "PED_QUALITY_HIGH"
-- -1: you should interpret as "PED_QUALITY_HIGH"
