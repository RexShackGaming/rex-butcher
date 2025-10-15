<img width="2948" height="497" alt="rex_scripts" src="https://github.com/user-attachments/assets/bccc94d2-0702-48aa-9868-08b05cc2a8bd" />

# Rex Butcher - Advanced RSG Framework Butcher System

## 📖 Description

Rex Butcher is a comprehensive and performance-optimized butcher system designed specifically for RSG Framework servers running on RedM. This advanced script transforms animal hunting into a profitable and immersive experience with multiple butcher locations, quality-based rewards, and a built-in shop system.

## ✨ Features

### 🦌 **Animal Processing System**
- **70+ Supported Animals** - From common deer to legendary creatures
- **Quality-Based Rewards** - Poor, Good, and Perfect quality multipliers
- **Dynamic Pricing** - Configurable reward multipliers (Poor: 1x, Good: 2x, Perfect: 3x)
- **Legendary Animal Support** - Special high-value rewards for rare animals
- **Anti-Spam Protection** - Server-side cooldowns prevent exploitation

### 🏪 **Multiple Butcher Locations**
- **12 Butcher Shops** strategically placed across the map:
  - Valentine, St Denis, Rhodes, Annesburg
  - Tumbleweed, Blackwater, Strawberry, Van Horn
  - Spider Gorge, Riggs Station, Elysian Pool, Guarma
- **Interactive NPCs** - Unique butcher models at each location
- **Customizable Blips** - Easy navigation with map markers
- **Dual Interaction System** - ox_target support or prompt-based interaction

### 🛒 **Integrated Shop System**
- **Butcher Shop** - Purchase hunting supplies and tools
- **Persistent Stock** - Optional database-saved inventory levels
- **Configurable Items** - Easy customization of shop inventory and prices
- **Full Integration** - Seamless compatibility with rsg-inventory

### ⚡ **Performance Optimization**
- **Advanced Caching** - O(1) animal lookups for instant processing
- **Memory Management** - Automatic cleanup of unused data
- **Configurable Settings** - Adjust spawn distances, update intervals, and cache sizes
- **Real-time Monitoring** - Performance statistics and debugging tools
- **Anti-Exploitation** - Multiple security measures to prevent cheating

### 🌐 **Localization Support**
- **Multi-language Ready** - ox_lib locale system integration
- **Fallback System** - Works without locale files using English defaults
- **Easy Translation** - JSON-based locale files for customization

## 📋 Dependencies

### **Required:**
- [rsg-core](https://github.com/Rexshack-RedM/rsg-core) - RSG Framework
- [ox_lib](https://github.com/overextended/ox_lib) - Overextended library
- [ox_target](https://github.com/overextended/ox_target) - Targeting system
- [rsg-inventory](https://github.com/Rexshack-RedM/rsg-inventory) - Inventory system

### **Optional:**
- [rsg-log](https://github.com/Rexshack-RedM/rsg-log) - Transaction logging

## 🚀 Installation

### **Step 1: Download and Extract**
1. Download the rex-butcher resource
2. Extract to your server's `resources` folder
3. Ensure the folder structure is: `resources/rex-butcher/`

### **Step 2: Install Items**
1. Open `installation/shared_items.lua` in the rex-butcher folder
2. Copy the item definitions
3. Add them to your `rsg-core/shared/items.lua` file:

```lua
-- Add this to your rsg-core/shared/items.lua
raw_meat = { 
    name = 'raw_meat', 
    label = 'Raw Meat', 
    weight = 50, 
    type = 'item', 
    image = 'raw_meat.png', 
    unique = false, 
    useable = false, 
    shouldClose = true, 
    description = 'Fresh raw meat from hunted animals'
},
```

### **Step 3: Install Item Images**
1. Locate your `rsg-inventory/html/images/` folder
2. Add the following image files (not included - use your own or find suitable images):
   - `raw_meat.png`
   - Any additional item images you configure

### **Step 4: Configure the Script**
1. Open `shared/config.lua`
2. Adjust settings as needed:
   - Animal rewards and multipliers
   - Butcher shop locations
   - Performance settings
   - Shop items and prices

### **Step 5: Start the Resource**
Add the following line to your `server.cfg`:
```cfg
ensure rex-butcher
```

### **Step 6: Restart Server**
Restart your server or use the command:
```
refresh
start rex-butcher
```

## ⚙️ Configuration

### **Basic Settings**
```lua
Config.Debug = false                    -- Enable debug mode
Config.SellTime = 10000                 -- Time to sell animal (ms)
Config.PoorMultiplier = 1               -- Poor quality multiplier
Config.GoodMultiplier = 2               -- Good quality multiplier
Config.PerfectMultiplier = 3            -- Perfect quality multiplier
Config.KeyBind = 'J'                    -- Interaction keybind
Config.EnableTarget = true              -- Use ox_target (true) or prompts (false)
```

### **Performance Settings**
```lua
Config.Performance = {
    NpcDistanceCheck = 3000,            -- NPC distance check interval (ms)
    NpcSpawnDistance = 20.0,            -- NPC spawn distance
    ProcessCooldown = 1000,             -- Processing cooldown (ms)
    ServerProcessCooldown = 2000,       -- Server cooldown per player (ms)
    CleanupInterval = 300000,           -- Cleanup interval (5 minutes)
}
```

### **Adding Custom Animals**
```lua
Config.Animal = {
    {
        name        = 'Custom Animal',
        model       = 123456789,          -- Animal model hash
        rewardmoney = 10,                 -- Base reward money
        rewarditem1 = 'raw_meat',         -- Primary reward item
        rewarditem2 = nil,                -- Secondary reward (optional)
        rewarditem3 = nil                 -- Tertiary reward (optional)
    },
}
```

## 🎮 Usage

### **For Players:**
1. **Hunt Animals** - Use any hunting method to kill animals
2. **Pick Up Carcass** - Approach and pick up the animal carcass
3. **Visit Butcher** - Go to any of the 12 butcher locations (marked on map)
4. **Sell Animal** - Interact with the butcher and select "Sell Animal"
5. **Shop** - Purchase hunting supplies from the butcher shop

### **Animal Quality System:**
- **Poor Quality** - 1x base reward
- **Good Quality** - 2x base reward  
- **Perfect Quality** - 3x base reward
- **Legendary Animals** - Special high rewards (typically 100x base)

### **Supported Animals Include:**
- **Common:** Deer, Rabbit, Duck, Turkey, Boar, etc.
- **Predators:** Bear, Wolf, Cougar, Panther, Coyote, etc.
- **Birds:** Eagle, Hawk, Owl, Pelican, Vulture, etc.
- **Legendary:** Legendary Bear, Wolf, Cougar, Panther, Beaver

## 🔧 Troubleshooting

### **Common Issues:**

**Script not starting:**
- Verify all dependencies are installed and started
- Check server console for error messages
- Ensure proper folder structure

**Animals not being recognized:**
- Enable debug mode to see console messages
- Check if the animal model is in the config
- Verify the animal quality is being detected

**Shop not opening:**
- Verify rsg-inventory is running
- Check if shop items are configured
- Enable debug mode for detailed logging

**Performance issues:**
- Adjust performance settings in config
- Reduce NPC spawn distances
- Increase cleanup intervals

### **Debug Mode:**
Enable debug mode in config.lua to get detailed console output:
```lua
Config.Debug = true
```

## 📊 Performance Stats

With debug mode enabled, the script provides real-time performance monitoring:
- Rewards processed per minute
- Cache hit rates
- Active player count
- Memory usage optimization

## 🔄 Updates

**Current Version:** 2.1.0

### **Changelog:**
- Advanced performance optimization
- Enhanced anti-spam protection  
- Improved memory management
- Real-time performance monitoring
- Better error handling and validation

## 💬 Support

- **Discord:** https://discord.gg/YUV7ebzkqs
- **YouTube:** https://www.youtube.com/@rexshack/videos
- **Tebex Store:** https://rexshackgaming.tebex.io/

## 📄 License

This resource is protected under escrow and is for authorized use only.

## 🙏 Credits

- **Developer:** RexShackGaming
- **Framework:** RSG-Core Team
- **Libraries:** Overextended (ox_lib, ox_target)

---

*Transform your server's hunting experience with Rex Butcher - where every hunt counts and every animal has value!*
