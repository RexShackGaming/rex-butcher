local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

RegisterServerEvent('rex-butcher:server:reward')
AddEventHandler('rex-butcher:server:reward', function(rewardmoney, rewarditem1, rewarditem2, rewarditem3, quality, name)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    if quality == 'poor' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.PoorMultiplier)
        if rewarditem1 ~= nil then
            Player.Functions.AddItem(rewarditem1, 1)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem1], 'add', 1)
        end
        if rewarditem2 ~= nil then
            Player.Functions.AddItem(rewarditem2, 1)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem2], 'add', 1)
        end
        if rewarditem3 ~= nil then
            Player.Functions.AddItem(rewarditem3, 1)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem3], 'add', 1)
        end
        TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, GetPlayerName(src) .. locale('sv_lang_1') .. name .. locale('sv_lang_4') .. rewardmoney * Config.PoorMultiplier, false)
    end
    if quality == 'good' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.GoodMultiplier)
        if rewarditem1 ~= nil then
            Player.Functions.AddItem(rewarditem1, 2)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem1], 'add', 2)
        end
        if rewarditem2 ~= nil then
            Player.Functions.AddItem(rewarditem2, 2)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem2], 'add', 2)
        end
        if rewarditem3 ~= nil then
            Player.Functions.AddItem(rewarditem3, 2)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem3], 'add', 2)
        end
        TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, GetPlayerName(src) .. locale('sv_lang_2') .. name .. locale('sv_lang_4') .. rewardmoney * Config.GoodMultiplier, false)
    end
    if quality == 'perfect' then
        Player.Functions.AddMoney('cash', rewardmoney * Config.PerfectMultiplier)
        if rewarditem1 ~= nil then
            Player.Functions.AddItem(rewarditem1, 3)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem1], 'add', 3)
        end
        if rewarditem2 ~= nil then
            Player.Functions.AddItem(rewarditem2, 3)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem2], 'add', 3)
        end
        if rewarditem3 ~= nil then
            Player.Functions.AddItem(rewarditem3, 3)
            TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[rewarditem3], 'add', 3)
        end
        TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, GetPlayerName(src) .. locale('sv_lang_3') .. name .. locale('sv_lang_4') .. rewardmoney * Config.PerfectMultiplier, false)
    end
end)

--------------------------------------
-- register butcher shop
--------------------------------------
CreateThread(function() 
    exports['rsg-inventory']:CreateShop({
        name = 'butcher',
        label = 'Butcher Shop',
        slots = #Config.ButcherShopItems,
        items = Config.ButcherShopItems,
        persistentStock = Config.PersistStock,
    })
end)

--------------------------------------
-- open butcher shop
--------------------------------------
RegisterNetEvent('rex-butcher:server:openShop', function() 
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    exports['rsg-inventory']:OpenShop(src, 'butcher')
end)
