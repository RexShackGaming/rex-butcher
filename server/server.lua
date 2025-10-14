local RSGCore = exports['rsg-core']:GetCoreObject()
lib.locale()

-- Performance optimization variables
local AnimalValidationCache = {}
local QualityMultipliers = {
    poor = Config.PoorMultiplier or 1,
    good = Config.GoodMultiplier or 2,
    perfect = Config.PerfectMultiplier or 3
}
local ItemQuantities = {
    poor = 1,
    good = 2,
    perfect = 3
}
local LocaleCache = {}
local PlayerCooldowns = {} -- Anti-spam protection
local PROCESS_COOLDOWN = Config.Performance and Config.Performance.ServerProcessCooldown or 2000

-- Initialize caches
CreateThread(function()
    Wait(1000) -- Ensure config is loaded
    
    -- Build animal validation cache for O(1) lookup
    for i = 1, #Config.Animal do
        local animal = Config.Animal[i]
        AnimalValidationCache[animal.model] = {
            name = animal.name,
            rewardmoney = animal.rewardmoney,
            rewarditem1 = animal.rewarditem1,
            rewarditem2 = animal.rewarditem2,
            rewarditem3 = animal.rewarditem3
        }
    end
    
    -- Cache locale strings (with safe error handling)
    local locale_func = nil
    
    -- Try to get locale function safely
    if lib and lib.locale then
        local success, result = pcall(lib.locale)
        if success and type(result) == 'function' then
            locale_func = result
        end
    end
    
    -- Load locale strings or use fallbacks
    if locale_func then
        local success1, lang1 = pcall(locale_func, 'sv_lang_1')
        local success2, lang2 = pcall(locale_func, 'sv_lang_2')
        local success3, lang3 = pcall(locale_func, 'sv_lang_3')
        local success4, lang4 = pcall(locale_func, 'sv_lang_4')
        
        LocaleCache.lang_1 = (success1 and lang1) or ' Sold a poor '
        LocaleCache.lang_2 = (success2 and lang2) or ' Sold a good '
        LocaleCache.lang_3 = (success3 and lang3) or ' Sold a perfect '
        LocaleCache.lang_4 = (success4 and lang4) or ' for $'
        
        print('[rex-butcher] Locale strings loaded successfully')
    else
        -- Fallback locale strings
        LocaleCache.lang_1 = ' Sold a poor '
        LocaleCache.lang_2 = ' Sold a good '
        LocaleCache.lang_3 = ' Sold a perfect '
        LocaleCache.lang_4 = ' for $'
        print('[rex-butcher] Warning: Locale system not available, using fallback strings')
    end
    
    print('[rex-butcher] Server cache initialized with ' .. #Config.Animal .. ' animals')
    
    -- Start performance monitoring if debug is enabled
    if Config.Debug then
        StartPerformanceMonitoring()
    end
end)

-- Performance monitoring system
local PerformanceStats = {
    totalRewards = 0,
    totalPlayers = 0,
    cacheHits = 0,
    cacheMisses = 0,
    startTime = GetGameTimer()
}

function StartPerformanceMonitoring()
    CreateThread(function()
        while true do
            Wait(60000) -- Report every minute
            local uptime = (GetGameTimer() - PerformanceStats.startTime) / 1000
            local rewardsPerMinute = (PerformanceStats.totalRewards / uptime) * 60
            local cacheHitRate = PerformanceStats.cacheHits / (PerformanceStats.cacheHits + PerformanceStats.cacheMisses) * 100
            
            print(string.format('[rex-butcher] Performance Stats - Uptime: %.1fs, Rewards/min: %.1f, Cache Hit Rate: %.1f%%, Active Players: %d', 
                uptime, rewardsPerMinute, cacheHitRate, #GetPlayers()))
            
            -- Clean up old cooldown entries
            CleanupPlayerCooldowns()
        end
    end)
end

-- Memory management
function CleanupPlayerCooldowns()
    local currentTime = GetGameTimer()
    local cleaned = 0
    local maxEntries = Config.Performance and Config.Performance.MaxPlayerCooldowns or 100
    
    -- Remove old entries
    for playerId, lastTime in pairs(PlayerCooldowns) do
        if (currentTime - lastTime) > (PROCESS_COOLDOWN * 10) then -- 10x cooldown time
            PlayerCooldowns[playerId] = nil
            cleaned = cleaned + 1
        end
    end
    
    -- If still too many entries, remove oldest ones
    local count = 0
    for _ in pairs(PlayerCooldowns) do count = count + 1 end
    
    if count > maxEntries then
        local entries = {}
        for playerId, lastTime in pairs(PlayerCooldowns) do
            table.insert(entries, {id = playerId, time = lastTime})
        end
        
        table.sort(entries, function(a, b) return a.time < b.time end)
        
        for i = 1, count - maxEntries do
            PlayerCooldowns[entries[i].id] = nil
            cleaned = cleaned + 1
        end
    end
    
    if Config.Debug and cleaned > 0 then
        print('[rex-butcher] Cleaned up ' .. cleaned .. ' old cooldown entries')
    end
end

-- Optimized validation functions with performance tracking
local function IsValidAnimal(model)
    local result = AnimalValidationCache[model]
    if Config.Debug then
        if result then
            PerformanceStats.cacheHits = PerformanceStats.cacheHits + 1
        else
            PerformanceStats.cacheMisses = PerformanceStats.cacheMisses + 1
        end
    end
    return result
end

local function IsValidQuality(quality)
    return QualityMultipliers[quality] ~= nil
end

-- Player cooldown management
local function IsPlayerOnCooldown(src)
    local currentTime = GetGameTimer()
    local lastProcess = PlayerCooldowns[src]
    
    if lastProcess and (currentTime - lastProcess) < PROCESS_COOLDOWN then
        return true
    end
    
    PlayerCooldowns[src] = currentTime
    return false
end

-- Optimized reward processing function
local function ProcessReward(src, animalData, quality)
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return false end
    
    local multiplier = QualityMultipliers[quality]
    local quantity = ItemQuantities[quality]
    local finalMoney = animalData.rewardmoney * multiplier
    
    -- Add money
    Player.Functions.AddMoney('cash', finalMoney)
    
    -- Add items efficiently
    local itemsToAdd = {}
    if animalData.rewarditem1 then
        itemsToAdd[#itemsToAdd + 1] = { item = animalData.rewarditem1, count = quantity }
    end
    if animalData.rewarditem2 then
        itemsToAdd[#itemsToAdd + 1] = { item = animalData.rewarditem2, count = quantity }
    end
    if animalData.rewarditem3 then
        itemsToAdd[#itemsToAdd + 1] = { item = animalData.rewarditem3, count = quantity }
    end
    
    -- Batch add items and trigger client events
    for _, itemData in ipairs(itemsToAdd) do
        Player.Functions.AddItem(itemData.item, itemData.count)
        TriggerClientEvent('rsg-inventory:client:ItemBox', src, RSGCore.Shared.Items[itemData.item], 'add', itemData.count)
    end
    
    -- Log the transaction if enabled
    if not Config.Performance or Config.Performance.LoggingEnabled then
        local logMessage = GetPlayerName(src) .. (LocaleCache['lang_' .. (quality == 'poor' and '1' or quality == 'good' and '2' or '3')] or ' sold a ' .. quality .. ' ') .. animalData.name .. (LocaleCache.lang_4 or ' for $') .. finalMoney
        TriggerEvent('rsg-log:server:CreateLog', Config.WebhookName, Config.WebhookTitle, Config.WebhookColour, logMessage, false)
    end
    
    -- Update performance stats
    if Config.Debug then
        PerformanceStats.totalRewards = PerformanceStats.totalRewards + 1
    end
    
    return true
end

RegisterServerEvent('rex-butcher:server:reward')
AddEventHandler('rex-butcher:server:reward', function(model, quality, name)
    local src = source
    
    -- Anti-spam protection
    if IsPlayerOnCooldown(src) then
        if Config.Debug then
            print('[rex-butcher] Player ' .. GetPlayerName(src) .. ' is on cooldown')
        end
        return
    end
    
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then return end
    
    -- Quick parameter validation
    if not model or not quality or not name or type(model) ~= 'number' or type(quality) ~= 'string' or type(name) ~= 'string' then
        print('[rex-butcher] Invalid parameters from player: ' .. GetPlayerName(src))
        return
    end
    
    -- Fast cache lookup for animal validation
    local animalData = IsValidAnimal(model)
    if not animalData then
        print('[rex-butcher] Invalid animal model from player: ' .. GetPlayerName(src) .. ' Model: ' .. tostring(model))
        return
    end
    
    -- Validate quality
    if not IsValidQuality(quality) then
        print('[rex-butcher] Invalid quality from player: ' .. GetPlayerName(src) .. ' Quality: ' .. tostring(quality))
        return
    end
    
    -- Process the reward
    local success = ProcessReward(src, animalData, quality)
    
    if Config.Debug and success then
        print('[rex-butcher] Processed ' .. quality .. ' ' .. animalData.name .. ' for ' .. GetPlayerName(src))
    end
end)

--------------------------------------
-- register butcher shop (optimized)
--------------------------------------
CreateThread(function()
    -- Only create shop if there are items configured
    if Config.ButcherShopItems and #Config.ButcherShopItems > 0 then
        exports['rsg-inventory']:CreateShop({
            name = 'butcher',
            label = 'Butcher Shop',
            slots = #Config.ButcherShopItems,
            items = Config.ButcherShopItems,
            persistentStock = Config.PersistStock or false,
        })
        
        if Config.Debug then
            print('[rex-butcher] Butcher shop created with ' .. #Config.ButcherShopItems .. ' items')
        end
    else
        print('[rex-butcher] Warning: No shop items configured')
    end
end)

--------------------------------------
-- open butcher shop (with validation)
--------------------------------------
RegisterNetEvent('rex-butcher:server:openShop', function()
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if not Player then
        print('[rex-butcher] Invalid player tried to open shop: ' .. tostring(src))
        return
    end
    
    -- Check if shop exists before opening
    if Config.ButcherShopItems and #Config.ButcherShopItems > 0 then
        exports['rsg-inventory']:OpenShop(src, 'butcher')
        
        if Config.Debug then
            print('[rex-butcher] Opened shop for player: ' .. GetPlayerName(src))
        end
    else
        TriggerClientEvent('lib:notify', src, {
            title = 'Shop Unavailable',
            description = 'The butcher shop is currently unavailable.',
            type = 'error',
            duration = 5000
        })
    end
end)

--------------------------------------
-- cleanup on player disconnect
--------------------------------------
AddEventHandler('playerDropped', function()
    local src = source
    -- Clean up player cooldown data
    if PlayerCooldowns[src] then
        PlayerCooldowns[src] = nil
    end
end)
