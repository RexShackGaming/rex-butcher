Config = {}

---------------------------------
-- shop settings
---------------------------------
Config = {
    ButcherShopItems = {
        { name = 'weapon_melee_knife', amount = 100, price = 5 },  
    },
    PersistStock = true, --should stock save in database and load it after restart, to 'remember' stock value before restart
}

---------------------------------
-- settings
---------------------------------
Config.Debug = false
Config.SellTime = 10000
Config.PoorMultiplier = 1
Config.GoodMultiplier = 2
Config.PerfectMultiplier = 3
Config.KeyBind = 'J'
Config.EnableTarget = true

---------------------------------
-- webhook settings
---------------------------------
Config.WebhookName = 'rexbutcher'
Config.WebhookTitle = 'Rex Butcher'
Config.WebhookColour = 'default'

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0 -- Distance before spawning/despawning the ped. (GTA Units.)
Config.FadeIn = true

---------------------------------
-- blip settings
---------------------------------
Config.Blip = {
    blipName = 'Butcher Shop', -- Config.Blip.blipName
    blipSprite = 'blip_shop_butcher', -- Config.Blip.blipSprite
    blipScale = 0.2 -- Config.Blip.blipScale
}

---------------------------------
-- prompt locations
---------------------------------
Config.ButcherLocations = {

    {   --valentine
        name = 'Valentine Butcher',
        prompt = 'valentine-butcher',
        coords = vector3(-341.05, 767.33, 116.70),
        npcmodel = `u_m_m_valbutcher_01`,
        npccoords = vector4(-339.26, 767.7, 116.57, 103.16),
        showblip = true
    },
    {   --st denis
        name = 'St Denis Butcher',
        prompt = 'stdenis-butcher',
        coords = vector3(2816.37, -1322.24, 46.61),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(2817.6848, -1323.25, 46.607814, 54.587085),
        showblip = true
    },
    {   -- rhodes
        name = 'Rhodes Butcher',
        prompt = 'rhodes-butcher',
        coords = vector3(1296.36, -1279.26, 75.84),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(1297.3735, -1277.661, 75.876304, 158.4201),
        showblip = true
    },
    {   -- annesburg
        name = 'Annesburg Butcher',
        prompt = 'annesburg-butcher',
        coords = vector3(2937.32, 1310.64, 44.48),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(2937.32, 1310.64, 44.48, 87.14),
        showblip = true
    },
    {   -- tumbleweed
        name = 'Tumbleweed Butcher',
        prompt = 'tumbleweed-butcher',
        coords = vector3(-5508.10, -2947.73, -1.87),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(-5509.831, -2947.271, -1.89185, 256.48596),
        showblip = true
    },
    {   -- blackwater
        name = 'Blackwater Butcher',
        prompt = 'blackwater-butcher',
        coords = vector3(-751.102, -1284.896, 43.276576),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(-753.0086, -1284.84, 43.470008, 267.18395),
        showblip = true
    },
    {   -- strawberry
        name = 'Strawberry Butcher',
        prompt = 'strawberry-butcher',
        coords = vector3(-1752.91, -394.74, 156.19),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(-1753.137, -392.8364, 156.24348, 189.32403),
        showblip = true
    },
    {   -- vanhorn
        name = 'Van-Horn Butcher',
        prompt = 'vanhorn-butcher',
        coords = vector3(2994.23, 571.79, 44.35),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(2992.4711, 572.20001, 44.365322, 263.94104),
        showblip = true
    },
    {   -- spidergorge
        name = 'Spider Gorge Butcher',
        prompt = 'spidergorge-butcher',
        coords = vector3(-1355.103, 2420.8293, 307.48272),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(-1356.811, 2420.0056, 307.49148, 301.39794),
        showblip = true
    },
    {   -- riggsstation
        name = 'Riggs Station Butcher',
        prompt = 'riggsstation-butcher',
        coords = vector3(-1005.966, -540.9986, 98.964859),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(-1007.92, -541.2982, 99.108978, 281.41009),
        showblip = true
    },
    {   -- elysian
        name = 'Elysian Butcher',
        prompt = 'elysian-butcher',
        coords = vector3(2540.72, 802.35, 76.38),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(2540.72, 802.35, 76.38, 349.73),
        showblip = true
    },
    {   -- guarma
        name = 'Guarma Butcher',
        prompt = 'guarma-butcher',
        coords = vector3(1248.80, -7043.52, 41.84),
        npcmodel = `s_m_m_unibutchers_01`,
        npccoords = vector4(1248.80, -7043.52, 41.84, 248.12),
        showblip = true
    },

}

---------------------------------
-- animals
---------------------------------
Config.Animal = {

    {
        name        = 'Bear',
        model       = -1124266369,
        rewardmoney = 14,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Big Horn Ram',
        model       = -1568716381, 
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Boar',
        model       = 2028722809,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Buck',
        model       = -1963605336,
        rewardmoney = 7,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Bison',
        model       = 1556473961,
        rewardmoney = 10,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Bull',
        model       = 195700131,
        rewardmoney = 8,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Deer',
        model       = 1110710183,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Duck',
        model       = -1003616053,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Eagle',
        model       = 1459778951,
        rewardmoney = 6,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Egret',
        model       = 831859211,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Elk',
        model       = -2021043433,
        rewardmoney = 5,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'American Red Fox',
        model       = 252669332,
        rewardmoney = 5,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Big Grey Wolf',
        model       = -1143398950,
        rewardmoney = 6,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Medium Grey Wolf',
        model       = -885451903,
        rewardmoney = 5,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Small Grey Wolf',
        model       = -829273561,
        rewardmoney = 4,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Vulture',
        model       = 1104697660,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Snapping Turtle',
        model       = -407730502,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Wild Turkey',
        model       = -466054788,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Wild Turkey',
        model       = -2011226991,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Wild Turkey',
        model       = -166054593,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Water Snake',
        model       = -229688157,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Snake Red Boa',
        model       = -1790499186,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Snake Fer-De-Lance',
        model       = 1464167925,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Black-Tailed Rattlesnake',
        model       = 846659001, 
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Western Rattlesnake',
        model       = 545068538,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Striped Skunk',
        model       = -1211566332,
        rewardmoney = 8,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Merino Sheep',
        model       = 40345436,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Herring Seagull',
        model       = -164963696,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Roseate Spoonbill',
        model       = -1076508705,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Dominique Rooster',
        model       = 2023522846,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Red-Footed Booby',
        model       = -466687768,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Wester Raven',
        model       = -575340245,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'North American Racoon',
        model       = 1458540991,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Black-Tailed Jackrabbit',
        model       = -541762431,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'American Pronghorn Doe',
        model       = 1755643085,
        rewardmoney = 1,
        rewarditem  = 'raw_meat'
    },
    {
        name        = 'Greater Prairie Chicken',
        model       = 2079703102,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Wirginia Possum',
        model       = -1414989025,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Berkshire Pig',
        model       = 1007418994,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Ring-Necked Pheasant',
        model       = 1416324601,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'American White Pelican',
        model       = 1265966684,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Blue And Yellow Macaw',
        model       = -1797450568,
        rewardmoney = 6,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Panther',
        model       = 1654513481,
        rewardmoney = 30,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Californian Condor',
        model       = 1205982615,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Dominique Chicken',
        model       = -2063183075,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Double-Crested Cormorant',
        model       = -2073130256,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Cougar',
        model       = 90264823,
        rewardmoney = 25,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Florida Cracker Cow',
        model       = -50684386,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Coyote',
        model       = 480688259,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Whooping Crane',
        model       = -564099192,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },   
    {
        name        = 'Gila Monster',
        model       = 457416415,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Alpine Goat',
        model       = -753902995,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Canada Goose',
        model       = 723190474,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Ferruinous Hawk',
        model       = -2145890973,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Great Blue Heron',
        model       = 1095117488,
        rewardmoney = 4,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Green Iguana',
        model       = -1854059305,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Desert Iguana',
        model       = -593056309,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Peccary Pig',
        model       = 1751700893,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Common Loon',
        model       = 386506078,
        rewardmoney = 13,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Moose',
        model       = -1098441944,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'American Muskrat',
        model       = -1134449699,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Great Horned Owl',
        model       = -861544272,
        rewardmoney = 3,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Angus Ox',
        model       = 556355544,
        rewardmoney = 1,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Alligator',
        model       = -1892280447,
        rewardmoney = 4,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'North American Beaver',
        model       = 759906147,
        rewardmoney = 2,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'American Black Bear',
        model       = 730092646,
        rewardmoney = 4,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Alligator',
        model       = -1295720802,
        rewardmoney = 4,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Legendary Moon Beaver',
        model       = -1149999295,
        rewardmoney = 100,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Legendary Maza Cougar',
        model       = -1433814131,
        rewardmoney = 100,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Legendary Midnight Paw Coyote',
        model       = -1307757043,
        rewardmoney = 100,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Legendary Ghost Panther',
        model       = -1189368951,
        rewardmoney = 100,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    {
        name        = 'Legendary Onyx Wolf',
        model       = -1392359921,
        rewardmoney = 100,
        rewarditem1 = 'raw_meat',
        rewarditem2 = nil,
        rewarditem3 = nil
    },
    
}
