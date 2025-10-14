local RSGCore = exports['rsg-core']:GetCoreObject()
local SpawnedButcherBlips = {}

-- Performance cache variables
local AnimalLookupCache = {}
local MenuContextCache = nil
local LocaleCache = {}
local LastProcessedTime = 0
local ProcessCooldown = Config.Performance and Config.Performance.ProcessCooldown or 1000

-- Initialize locale cache with safe error handling
CreateThread(function()
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
        local localeKeys = {
            {key = 'cl_lang_1', fallback = 'Open '},
            {key = 'cl_lang_5', fallback = 'Butcher Shop'},
            {key = 'cl_lang_6', fallback = 'Sell Animal'},
            {key = 'cl_lang_7', fallback = 'sell your animal'},
            {key = 'cl_lang_8', fallback = 'Open Shop'},
            {key = 'cl_lang_9', fallback = 'buy items from the butcher'},
            {key = 'cl_lang_10', fallback = 'Not Holding Animal'},
            {key = 'cl_lang_11', fallback = "don't have an animal on you"},
            {key = 'cl_lang_12', fallback = 'Selling '},
            {key = 'cl_lang_13', fallback = 'Selling Failed!'}
        }
        
        for _, locale in ipairs(localeKeys) do
            local success, result = pcall(locale_func, locale.key)
            local cacheKey = locale.key:gsub('cl_', ''):gsub('_', '_')
            LocaleCache['lang_' .. cacheKey:match('%d+')] = (success and result) or locale.fallback
        end
        
        if Config.Debug then
            print('[rex-butcher] Client locale strings loaded successfully')
        end
    else
        -- Fallback locale strings
        LocaleCache.lang_1 = 'Open '
        LocaleCache.lang_5 = 'Butcher Shop'
        LocaleCache.lang_6 = 'Sell Animal'
        LocaleCache.lang_7 = 'sell your animal'
        LocaleCache.lang_8 = 'Open Shop'
        LocaleCache.lang_9 = 'buy items from the butcher'
        LocaleCache.lang_10 = 'Not Holding Animal'
        LocaleCache.lang_11 = "don't have an animal on you"
        LocaleCache.lang_12 = 'Selling '
        LocaleCache.lang_13 = 'Selling Failed!'
        
        if Config.Debug then
            print('[rex-butcher] Client locale system not available, using fallback strings')
        end
    end
end)

-- Build animal lookup cache for O(1) access
CreateThread(function()
    Wait(500) -- Ensure config is loaded
    for i = 1, #Config.Animal do
        local animal = Config.Animal[i]
        AnimalLookupCache[animal.model] = {
            index = i,
            name = animal.name,
            rewardmoney = animal.rewardmoney,
            rewarditem1 = animal.rewarditem1,
            rewarditem2 = animal.rewarditem2,
            rewarditem3 = animal.rewarditem3
        }
    end
    if Config.Debug then
        print('[rex-butcher] Animal cache built with ' .. #Config.Animal .. ' entries')
    end
end)

--------------------------------------
-- butcher prompts and blips
--------------------------------------
CreateThread(function()
    -- Wait for locale cache to be ready
    while not LocaleCache.lang_1 do Wait(100) end
    
    -- Pre-calculate blip sprite hash for performance
    local blipSpriteHash = joaat(Config.Blip.blipSprite)
    
    for _, v in pairs(Config.ButcherLocations) do
        if not Config.EnableTarget then
            exports['rsg-core']:createPrompt(v.prompt, v.coords, RSGCore.Shared.Keybinds[Config.KeyBind], LocaleCache.lang_1 .. v.name, {
                type = 'client',
                event = 'rex-butcher:client:mainmenu',
            })
        end
        if v.showblip then -- Simplified boolean check
            local ButcherBlip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(ButcherBlip, blipSpriteHash, true)
            SetBlipScale(ButcherBlip, Config.Blip.blipScale)
            SetBlipName(ButcherBlip, Config.Blip.blipName)
            SpawnedButcherBlips[#SpawnedButcherBlips + 1] = ButcherBlip -- More efficient than table.insert
        end
    end
    
    if Config.Debug then
        print('[rex-butcher] Created ' .. #SpawnedButcherBlips .. ' blips')
    end
end)

--------------------------------------
-- butcher main menu (cached)
--------------------------------------
RegisterNetEvent('rex-butcher:client:mainmenu', function()
    -- Create menu context cache if not exists
    if not MenuContextCache then
        MenuContextCache = {
            id = 'butcher_menu',
            title = LocaleCache.lang_5 or 'Butcher Shop',
            position = 'top-right',
            options = {
                {
                    title = LocaleCache.lang_6 or 'Sell Animal',
                    description = LocaleCache.lang_7 or 'sell your animal',
                    icon = 'fas fa-paw',
                    event = 'rex-butcher:client:sellanimal',
                },
                {
                    title = LocaleCache.lang_8 or 'Open Shop',
                    description = LocaleCache.lang_9 or 'buy items from the butcher',
                    icon = 'fas fa-shopping-basket',
                    serverEvent = 'rex-butcher:server:openShop',
                },
            }
        }
    end
    
    lib.registerContext(MenuContextCache)
    lib.showContext('butcher_menu')
end)

--------------------------------------
-- sell animals (optimized)
--------------------------------------
RegisterNetEvent('rex-butcher:client:sellanimal', function()
    -- Anti-spam protection
    local currentTime = GetGameTimer()
    if currentTime - LastProcessedTime < ProcessCooldown then
        if Config.Debug then
            print('[rex-butcher] Processing cooldown active')
        end
        return
    end
    
    local holding = GetFirstEntityPedIsCarrying(cache.ped)
    if holding == 0 then
        lib.notify({ 
            title = LocaleCache.lang_10 or 'Not Holding Animal', 
            description = LocaleCache.lang_11 or "don't have an animal on you", 
            type = 'error', 
            duration = 5000 
        })
        return
    end
    
    local model = GetEntityModel(holding)
    local animalData = AnimalLookupCache[model] -- O(1) lookup instead of O(n) loop
    
    if not animalData then
        lib.notify({ 
            title = LocaleCache.lang_10 or 'Not Holding Animal', 
            description = 'Unknown animal type', 
            type = 'error', 
            duration = 5000 
        })
        return
    end
    
    LastProcessedTime = currentTime
    LocalPlayer.state:set("inv_busy", true, true) -- lock inventory
    
    local quality = GetPedQuality(holding)
    local qualityType = (quality == 1 and 'good') or (quality == 2 or quality == -1) and 'perfect' or 'poor'
    
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
        label = (LocaleCache.lang_12 or 'Selling ') .. animalData.name,
    }) then
        local deleted = DeleteThis(holding)
        if deleted then
            TriggerServerEvent('rex-butcher:server:reward', model, qualityType, animalData.name)
        else
            lib.notify({ 
                title = LocaleCache.lang_13 or 'Selling Failed!', 
                type = 'error', 
                duration = 7000 
            })
        end
    end
    
    LocalPlayer.state:set("inv_busy", false, true) -- unlock inventory
end)

--------------------------------------
-- delete holding (optimized)
--------------------------------------
function DeleteThis(holding)
    if not DoesEntityExist(holding) then
        if Config.Debug then
            print('[rex-butcher] Entity does not exist for deletion')
        end
        return false
    end
    
    -- More efficient entity deletion
    local success = false
    local attempts = 0
    local maxAttempts = 3
    
    while not success and attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Request control with timeout
        NetworkRequestControlOfEntity(holding)
        local controlTimeout = 0
        while not NetworkHasControlOfEntity(holding) and controlTimeout < 20 do
            Wait(50)
            controlTimeout = controlTimeout + 1
        end
        
        if NetworkHasControlOfEntity(holding) then
            SetEntityAsMissionEntity(holding, true, true)
            Wait(50) -- Reduced wait time
            DeleteEntity(holding)
            Wait(100) -- Reduced wait time
            
            -- Verify deletion
            if not DoesEntityExist(holding) then
                success = true
            else
                -- Force deletion if still exists
                SetEntityCoords(holding, 0.0, 0.0, -1000.0) -- Move far away first
                Wait(50)
                DeleteEntity(holding)
                success = not DoesEntityExist(holding)
            end
        else
            if Config.Debug then
                print('[rex-butcher] Failed to get control of entity, attempt ' .. attempts)
            end
            Wait(100)
        end
    end
    
    -- Final verification
    if success then
        local finalCheck = GetFirstEntityPedIsCarrying(cache.ped)
        success = (finalCheck == 0 or not DoesEntityExist(finalCheck))
    end
    
    if Config.Debug then
        print('[rex-butcher] Entity deletion ' .. (success and 'successful' or 'failed') .. ' after ' .. attempts .. ' attempts')
    end
    
    return success
end

--  0: "PED_QUALITY_LOW"
--  1: "PED_QUALITY_MEDIUM"
--  2: "PED_QUALITY_HIGH"
-- -1: you should interpret as "PED_QUALITY_HIGH"
