-- ═══════════════════════════════════════════════════════════════
-- PHANTOM X - ULTIMATE UNIVERSAL SCRIPT HUB
-- "One Hub. Every Game. Total Domination."
-- ═══════════════════════════════════════════════════════════════
-- Credits: The Invisible Man
-- Version: 3.0.0
-- ═══════════════════════════════════════════════════════════════

-- ██████████████████████████████████████████████████████████████
-- SECTION 1: ANTI-CHEAT OBLITERATION ENGINE
-- ██████████████████████████████████████████████████████████████

local AntiCheatEngine = {
    Initialized = false,
    DefenseLevel = 10,
    Active = true
}

function AntiCheatEngine:Initialize()
    if self.Initialized then return end
    
    local player = game.Players.LocalPlayer
    if not player then return end
    
    -- Hijack metatable to intercept all calls
    local mt = getrawmetatable(game)
    if mt then
        local old_namecall = mt.__namecall
        local old_index = mt.__index
        local old_newindex = mt.__newindex
        
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            if method and type(method) == "string" then
                local lower = method:lower()
                if lower:find("kick") or lower:find("ban") or lower:find("detect") or lower:find("admin") then
                    return nil
                end
            end
            return old_namecall(self, unpack(args))
        end)
        
        mt.__index = newcclosure(function(self, key)
            if type(key) == "string" then
                local lower = key:lower()
                if lower:find("anti") or lower:find("cheat") or lower:find("detect") or lower:find("ban") then
                    return nil
                end
            end
            return old_index(self, key)
        end)
        
        mt.__newindex = newcclosure(function(self, key, value)
            if type(key) == "string" then
                local lower = key:lower()
                if lower:find("anti") or lower:find("cheat") or lower:find("detect") or lower:find("ban") then
                    return nil
                end
            end
            return old_newindex(self, key, value)
        end)
        
        setreadonly(mt, true)
    end
    
    -- Destroy anti-cheat remotes
    local function nukeRemotes(parent)
        for i, v in pairs(parent:GetChildren()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local name = v.Name:lower()
                local keywords = {"anti", "cheat", "detect", "ban", "kick", "mod", "guard", "security", "protect", "verify", "validate", "monitor", "watch", "scan", "audit"}
                for _, kw in ipairs(keywords) do
                    if name:find(kw) then
                        v:Destroy()
                        break
                    end
                end
            end
            if v:IsA("Folder") or v:IsA("Model") or v:IsA("ScreenGui") then
                nukeRemotes(v)
            end
        end
    end
    
    local locations = {game, game:GetService("ReplicatedStorage"), game:GetService("Workspace"), game:GetService("ServerStorage"), player, player.PlayerGui, player.PlayerScripts}
    for _, loc in ipairs(locations) do
        if loc then pcall(nukeRemotes, loc) end
    end
    
    -- Disable kick
    if player.Kick then
        local oldKick = player.Kick
        player.Kick = function(...)
            local args = {...}
            if args[1] and type(args[1]) == "string" then
                local lower = args[1]:lower()
                if lower:find("cheat") or lower:find("exploit") or lower:find("hack") or lower:find("ban") then
                    return nil
                end
            end
            return oldKick(player, unpack(args))
        end
    end
    
    -- Destroy anti-cheat GUIs
    for i, v in pairs(player.PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            local name = v.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("ban") or name:find("mod") then
                v:Destroy()
            end
        end
    end
    
    -- Destroy anti-cheat scripts
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
            local name = v.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("moder") or name:find("security") then
                v:Destroy()
            end
        end
    end
    
    self.Initialized = true
    print("[Phantom X] Anti-Cheat: Neutralized")
end

-- Continuous monitoring
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local player = game.Players.LocalPlayer
        if not player then return end
        
        for i, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("ban") or name:find("kick") then
                    v:Destroy()
                end
            end
            if v:IsA("Script") or v:IsA("LocalScript") then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") then
                    v:Destroy()
                end
            end
            if v:IsA("ScreenGui") and v.Parent == player.PlayerGui then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("ban") then
                    v:Destroy()
                end
            end
        end
        
        -- Prevent ban teleport
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if hrp.Position.Y < -1000 or hrp.Position.Y > 5000 then
                hrp.CFrame = CFrame.new(0, 100, 0)
            end
        end
    end)
end)

AntiCheatEngine:Initialize()

-- ██████████████████████████████████████████████████████████████
-- SECTION 2: SIRIUS UI - MAIN WINDOW
-- ██████████████████████████████████████████████████████████████

local Sirius = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sirius-Scripting/Sirius/main/source'))()

local Window = Sirius:CreateWindow({
    Name = "✦ PHANTOM X ✦",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 700, 0, 500),
    Theme = "Dark",
    Transparency = 0
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 3: GLOBAL VARIABLES
-- ██████████████████████████████████████████████████████████████

_G.PhantomX = {
    CurrentGame = "",
    SelectedWeapon = "",
    TargetPlayer = "",
    AimPart = "Head",
    FlySpeed = 50,
    ESP = false,
    Aimbot = false,
    SilentAim = false,
    GodMode = false,
    NoClip = false,
    AutoFarm = false,
    InstantKill = false,
    SpeedHack = false,
    Fly = false
}

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- ██████████████████████████████████████████████████████████████
-- SECTION 4: HELPER FUNCTIONS
-- ██████████████████████████████████████████████████████████████

local function GetPlayer()
    return game.Players.LocalPlayer
end

local function GetCharacter()
    local p = GetPlayer()
    return p and p.Character
end

local function GetHRP()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function GetAllPlayers()
    local list = {}
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= GetPlayer() then
            table.insert(list, v.Name)
        end
    end
    return list
end

local function GetClosestPlayer()
    local hrp = GetHRP()
    if not hrp then return nil end
    
    local target = nil
    local shortest = math.huge
    
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= GetPlayer() and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < shortest then
                shortest = dist
                target = v
            end
        end
    end
    
    return target
end

local function GetWeapons()
    local weapons = {}
    local locations = {
        game.ReplicatedStorage,
        game.Workspace,
        game.ServerStorage,
        game.Players.LocalPlayer.Backpack,
        game.Players.LocalPlayer.Character
    }
    
    for _, loc in ipairs(locations) do
        if loc then
            for _, child in ipairs(loc:GetChildren()) do
                if child:IsA("Tool") then
                    table.insert(weapons, child.Name)
                end
                if child:IsA("Folder") or child:IsA("Model") then
                    for _, sub in ipairs(child:GetChildren()) do
                        if sub:IsA("Tool") then
                            table.insert(weapons, sub.Name)
                        end
                    end
                end
            end
        end
    end
    
    local unique = {}
    for _, v in ipairs(weapons) do
        if not table.find(unique, v) then
            table.insert(unique, v)
        end
    end
    table.sort(unique)
    return unique
end

-- ██████████████████████████████████████████████████████████████
-- SECTION 5: MAIN TABS CREATION
-- ██████████████████████████████████████████████████████████████

local GameTab = Window:CreateTab("✦ Games ✦")
local CombatTab = Window:CreateTab("✦ Combat ✦")
local UtilityTab = Window:CreateTab("✦ Utility ✦")
local VisualTab = Window:CreateTab("✦ Visuals ✦")
local AdminTab = Window:CreateTab("✦ Admin ✦")
local CreditsTab = Window:CreateTab("✦ Credits ✦")

-- ██████████████████████████████████████████████████████████████
-- SECTION 6: GAME SELECTION
-- ██████████████████████████████████████████████████████████████

local GameSelection = GameTab:CreateSection("🎮 Game Selection")

-- Detect current game
pcall(function()
    _G.PhantomX.CurrentGame = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

GameSelection:CreateLabel("Current Game: " .. _G.PhantomX.CurrentGame)

local AllGames = {
    "Rivals",
    "Untitled Boxing Game",
    "South Bronx Trenches",
    "OBBY Games",
    "Gun Games",
    "MM2",
    "Arsenal",
    "BedWars",
    "Blox Fruits",
    "King Legacy",
    "Anime Adventures",
    "All Star Tower Defense",
    "Dungeon Quest",
    "Tower Defense Simulator",
    "Ninja Legends",
    "Dragon Ball Rage",
    "Project Slayers",
    "Demon Slayer RPG",
    "Shindo Life",
    "Anime Fighters",
    "The Strongest Battlegrounds",
    "Peroxide",
    "Type Soul",
    "YBA",
    "AUT",
    "Sword Fighters Simulator",
    "Blade Ball",
    "Fruit Battlegrounds",
    "Kaizen",
    "Arcane Odyssey"
}

local selectedGame = AllGames[1]

GameSelection:CreateDropdown({
    Name = "Select Game",
    Options = AllGames,
    Default = selectedGame,
    Callback = function(option)
        selectedGame = option
        LoadGameScripts(option)
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 7: DYNAMIC GAME SCRIPT LOADER
-- ██████████████████████████████████████████████████████████████

local CurrentScriptSection = nil
local ScriptToggles = {}

function LoadGameScripts(gameName)
    if CurrentScriptSection then
        CurrentScriptSection:Destroy()
        CurrentScriptSection = nil
    end
    
    CurrentScriptSection = GameTab:CreateSection("✦ " .. gameName:upper() .. " Scripts ✦")
    ScriptToggles = {}
    
    local scripts = {}
    
    -- ███ GAME-SPECIFIC SCRIPT DEFINITIONS ███
    
    if gameName == "South Bronx Trenches" then
        scripts = {
            {name = "Auto Farm Money", type = "toggle"},
            {name = "Money Dupe", type = "button"},
            {name = "Give All Weapons", type = "button"},
            {name = "Instant Kill", type = "toggle"},
            {name = "Super Speed", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "Silent Aim", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Item Dupe", type = "button"},
            {name = "Dupe Held Weapon", type = "button"},
            {name = "No Clip", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Rivals" then
        scripts = {
            {name = "Auto Aim", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "See All Players", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "Auto Farm Points", type = "toggle"},
            {name = "Silent Aim", type = "toggle"},
            {name = "Anti-Stun", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Untitled Boxing Game" then
        scripts = {
            {name = "Auto Punch", type = "toggle"},
            {name = "One Punch Kill", type = "toggle"},
            {name = "Super Speed", type = "toggle"},
            {name = "Infinite Health", type = "toggle"},
            {name = "Auto Farm Wins", type = "toggle"},
            {name = "Perfect Dodge", type = "toggle"},
            {name = "Instant Cooldown", type = "toggle"},
            {name = "ESP Players", type = "toggle"},
            {name = "Fly", type = "toggle"}
        }
    elseif gameName == "OBBY Games" then
        scripts = {
            {name = "Auto Jump", type = "toggle"},
            {name = "Speed", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "No Clip", type = "toggle"},
            {name = "Instant Finish", type = "button"},
            {name = "Auto Reset", type = "toggle"},
            {name = "Teleport to End", type = "button"}
        }
    elseif gameName == "Gun Games" then
        scripts = {
            {name = "Auto Aim", type = "toggle"},
            {name = "Infinite Ammo", type = "toggle"},
            {name = "One Shot Kill", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Aimbot", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Give All Guns", type = "button"},
            {name = "No Recoil", type = "toggle"},
            {name = "Silent Aim", type = "toggle"},
            {name = "Fly", type = "toggle"}
        }
    elseif gameName == "MM2" then
        scripts = {
            {name = "Auto Kill", type = "toggle"},
            {name = "See Murderer", type = "toggle"},
            {name = "Auto Shoot", type = "toggle"},
            {name = "Speed", type = "toggle"},
            {name = "Auto Collect", type = "toggle"},
            {name = "Aimbot", type = "toggle"},
            {name = "Ghost Mode", type = "toggle"},
            {name = "Auto Farm Coins", type = "toggle"},
            {name = "Fly", type = "toggle"}
        }
    elseif gameName == "Arsenal" then
        scripts = {
            {name = "Aimbot", type = "toggle"},
            {name = "Silent Aim", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "Infinite Ammo", type = "toggle"},
            {name = "No Recoil", type = "toggle"},
            {name = "Auto Farm", type = "toggle"}
        }
    elseif gameName == "BedWars" then
        scripts = {
            {name = "Auto Bridge", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "No Clip", type = "toggle"},
            {name = "Aimbot", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Auto Farm", type = "toggle"}
        }
    elseif gameName == "Blox Fruits" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "No Clip", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "Auto Collect", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "King Legacy" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "No Clip", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "Auto Collect", type = "toggle"}
        }
    elseif gameName == "Anime Adventures" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "Auto Summon", type = "toggle"}
        }
    elseif gameName == "All Star Tower Defense" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Auto Place", type = "toggle"}
        }
    elseif gameName == "Dungeon Quest" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"}
        }
    elseif gameName == "Tower Defense Simulator" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Auto Place", type = "toggle"}
        }
    elseif gameName == "Ninja Legends" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"}
        }
    elseif gameName == "Dragon Ball Rage" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Project Slayers" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Demon Slayer RPG" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"}
        }
    elseif gameName == "Shindo Life" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Anime Fighters" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"}
        }
    elseif gameName == "The Strongest Battlegrounds" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"},
            {name = "Silent Aim", type = "toggle"}
        }
    elseif gameName == "Peroxide" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Type Soul" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "YBA" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "AUT" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Sword Fighters Simulator" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "Instant Kill", type = "toggle"},
            {name = "ESP", type = "toggle"}
        }
    elseif gameName == "Blade Ball" then
        scripts = {
            {name = "Auto Parry", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Fruit Battlegrounds" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Kaizen" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    elseif gameName == "Arcane Odyssey" then
        scripts = {
            {name = "Auto Farm", type = "toggle"},
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"}
        }
    else
        -- Generic fallback
        scripts = {
            {name = "Speed Hack", type = "toggle"},
            {name = "Fly", type = "toggle"},
            {name = "No Clip", type = "toggle"},
            {name = "God Mode", type = "toggle"},
            {name = "ESP", type = "toggle"},
            {name = "Aimbot", type = "toggle"},
            {name = "Auto Farm", type = "toggle"},
            {name = "Instant Kill", type = "toggle"}
        }
    end
    
    -- ███ CREATE UI ELEMENTS ███
    
    for _, script in ipairs(scripts) do
        if script.type == "toggle" then
            local toggle = CurrentScriptSection:CreateToggle({
                Name = script.name,
                Default = false,
                Callback = function(value)
                    _G.PhantomX[script.name:gsub(" ", "_")] = value
                    ExecuteScript(script.name, value)
                end
            })
            ScriptToggles[script.name] = toggle
        elseif script.type == "button" then
            CurrentScriptSection:CreateButton({
                Name = script.name,
                Callback = function()
                    ExecuteScript(script.name, true)
                end
            })
        end
    end
end

-- ██████████████████████████████████████████████████████████████
-- SECTION 8: SCRIPT EXECUTION ENGINE (MASTER)
-- ██████████████████████████████████████████████████████████████

function ExecuteScript(scriptName, value)
    local player = GetPlayer()
    local char = GetCharacter()
    local hrp = GetHRP()
    local hum = GetHumanoid()
    
    if not player then return end
    
    -- ███ AUTO FARM - Universal ███
    if scriptName == "Auto Farm" or scriptName == "Auto Farm Money" or scriptName == "Auto Farm Points" or scriptName == "Auto Farm Wins" or scriptName == "Auto Farm Coins" then
        _G.PhantomX.AutoFarm = value
        while _G.PhantomX.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local targets = game.Players:GetPlayers()
                if #targets < 2 then return end
                local target = targets[math.random(2, #targets)]
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    if hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        task.wait(0.05)
                        for _, remote in ipairs(game.ReplicatedStorage:GetDescendants()) do
                            if remote:IsA("RemoteEvent") then
                                local name = remote.Name:lower()
                                if name:find("kill") or name:find("damage") or name:find("attack") or name:find("hit") then
                                    remote:FireServer(target)
                                end
                            end
                        end
                    end
                end
            end)
        end
        
    -- ███ MONEY DUPE ███
    elseif scriptName == "Money Dupe" then
        while task.wait() do
            pcall(function()
                for _, remote in ipairs(game.ReplicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") then
                        local name = remote.Name:lower()
                        if name:find("money") or name:find("cash") or name:find("bank") or name:find("coin") then
                            remote:FireServer(999999)
                            remote:FireServer("AddMoney", 999999)
                            remote:FireServer(999999, player)
                        end
                    end
                end
            end)
        end
        
    -- ███ GIVE ALL WEAPONS ███
    elseif scriptName == "Give All Weapons" or scriptName == "Give All Guns" then
        pcall(function()
            for _, v in ipairs(game.ReplicatedStorage:GetDescendants()) do
                if v:IsA("Tool") then
                    local cloned = v:Clone()
                    cloned.Parent = player.Backpack
                    task.wait(0.01)
                end
            end
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("Tool") then
                    local cloned = v:Clone()
                    cloned.Parent = player.Backpack
                    task.wait(0.01)
                end
            end
        end)
        
    -- ███ ITEM DUPE ███
    elseif scriptName == "Item Dupe" then
        pcall(function()
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then
                local cloned = tool:Clone()
                cloned.Parent = player.Backpack
            end
        end)
        
    -- ███ DUPE HELD WEAPON ███
    elseif scriptName == "Dupe Held Weapon" then
        pcall(function()
            local weapon = char and char:FindFirstChildOfClass("Tool")
            if weapon then
                for i = 1, 10 do
                    local cloned = weapon:Clone()
                    cloned.Parent = player.Backpack
                    task.wait(0.01)
                end
            end
        end)
        
    -- ███ INSTANT KILL ███
    elseif scriptName == "Instant Kill" or scriptName == "One Punch Kill" or scriptName == "One Shot Kill" then
        _G.PhantomX.InstantKill = value
        while _G.PhantomX.InstantKill do
            task.wait(0.1)
            pcall(function()
                for _, v in ipairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
                        v.Character.Humanoid.Health = 0
                    end
                end
                for _, v in ipairs(game.Workspace:GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent and v.Parent ~= char then
                        v.Health = 0
                    end
                end
            end)
        end
        
    -- ███ SPEED HACK ███
    elseif scriptName == "Speed Hack" or scriptName == "Super Speed" or scriptName == "Speed" then
        _G.PhantomX.SpeedHack = value
        if hum then
            hum.WalkSpeed = value and 200 or 16
            hum.JumpPower = value and 100 or 50
        end
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if _G.PhantomX.SpeedHack and hum then
                    hum.WalkSpeed = 200
                    hum.JumpPower = 100
                end
            end)
        end
        
    -- ███ FLY ███
    elseif scriptName == "Fly" then
        _G.PhantomX.Fly = value
        if value and hrp then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp
            
            local flying = true
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.PhantomX.Fly then
                    bv:Destroy()
                    flying = false
                    return
                end
                if flying then
                    local speed = _G.PhantomX.FlySpeed or 50
                    local move = Vector3.new()
                    local uis = game:GetService("UserInputService")
                    
                    if uis:IsKeyDown(Enum.KeyCode.W) then
                        move = move + hrp.CFrame.LookVector * speed
                    end
                    if uis:IsKeyDown(Enum.KeyCode.S) then
                        move = move - hrp.CFrame.LookVector * speed
                    end
                    if uis:IsKeyDown(Enum.KeyCode.A) then
                        move = move - hrp.CFrame.RightVector * speed
                    end
                    if uis:IsKeyDown(Enum.KeyCode.D) then
                        move = move + hrp.CFrame.RightVector * speed
                    end
                    if uis:IsKeyDown(Enum.KeyCode.Space) then
                        move = move + Vector3.new(0, speed, 0)
                    end
                    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then
                        move = move - Vector3.new(0, speed, 0)
                    end
                    
                    bv.Velocity = move
                end
            end)
        end
        
    -- ███ GOD MODE ███
    elseif scriptName == "God Mode" or scriptName == "Infinite Health" then
        _G.PhantomX.GodMode = value
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.PhantomX.GodMode and hum then
                hum.Health = hum.MaxHealth
                hum.BreakJointsOnDeath = false
            end
        end)
        
    -- ███ NO CLIP ███
    elseif scriptName == "No Clip" then
        _G.PhantomX.NoClip = value
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.PhantomX.NoClip and char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
    -- ███ ESP ███
    elseif scriptName == "ESP" or scriptName == "See All Players" or scriptName == "ESP Players" then
        _G.PhantomX.ESP = value
        if value then
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character then
                    for _, part in ipairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = part
                            highlight.Adornee = part
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        end
                    end
                end
            end
        else
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character then
                    for _, part in ipairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            for _, h in ipairs(part:GetChildren()) do
                                if h:IsA("Highlight") then
                                    h:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end
        
    -- ███ AIMBOT ███
    elseif scriptName == "Aimbot" or scriptName == "Auto Aim" then
        _G.PhantomX.Aimbot = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.PhantomX.Aimbot then return end
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.PhantomX.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end)
        end
        
    -- ███ SILENT AIM ███
    elseif scriptName == "Silent Aim" then
        _G.PhantomX.SilentAim = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.PhantomX.SilentAim then return end
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.PhantomX.AimPart or "Head")
                        if aimPart then
                            -- Silent aim - redirects bullets without moving camera
                            local screenPos = game.Workspace.CurrentCamera:WorldToScreenPoint(aimPart.Position)
                            if screenPos then
                                mouse.Hit = CFrame.new(aimPart.Position)
                            end
                        end
                    end
                end)
            end)
        end
        
    -- ███ AUTO SHOOT ███
    elseif scriptName == "Auto Shoot" then
        _G.PhantomX.AutoShoot = value
        while _G.PhantomX.AutoShoot do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game.ReplicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") then
                        local name = remote.Name:lower()
                        if name:find("shoot") or name:find("fire") or name:find("gun") then
                            remote:FireServer()
                        end
                    end
                end
            end)
        end
        
    -- ███ AUTO PUNCH ███
    elseif scriptName == "Auto Punch" then
        _G.PhantomX.AutoPunch = value
        while _G.PhantomX.AutoPunch do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game.ReplicatedStorage:GetDescendants()) do
                    if remote:IsA("RemoteEvent") then
                        local name = remote.Name:lower()
                        if name:find("punch") or name:find("attack") or name:find("hit") then
                            remote:FireServer()
                        end
                    end
                end
            end)
        end
        
    -- ███ INSTANT FINISH ███
    elseif scriptName == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    local name = v.Name:lower()
                    if name:find("finish") or name:find("end") or name:find("goal") or name:find("win") then
                        if hrp then
                            hrp.CFrame = v.CFrame
                        end
                    end
                end
            end
        end)
        
    -- ███ TELEPORT TO END ███
    elseif scriptName == "Teleport to End" then
        pcall(function()
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    local name = v.Name:lower()
                    if name:find("end") or name:find("finish") or name:find("goal") or name:find("win") or name:find("portal") then
                        if hrp then
                            hrp.CFrame = v.CFrame
                        end
                    end
                end
            end
        end)
        
    -- ███ SEE MURDERER ███
    elseif scriptName == "See Murderer" then
        _G.PhantomX.SeeMurderer = value
        if value then
            pcall(function()
                for _, v in ipairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character then
                        -- Check if this player is the murderer
                        if v:FindFirstChild("Murderer") or v.Backpack:FindFirstChild("Knife") then
                            for _, part in ipairs(v.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local highlight = Instance.new("Highlight")
                                    highlight.Parent = part
                                    highlight.Adornee = part
                                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                    highlight.FillTransparency = 0.3
                                end
                            end
                        end
                    end
                end
            end)
        end
        
    -- ███ GHOST MODE ███
    elseif scriptName == "Ghost Mode" then
        _G.PhantomX.GhostMode = value
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = value and 0.5 or 0
                end
            end
        end
        
    -- ███ AUTO JUMP ███
    elseif scriptName == "Auto Jump" then
        _G.PhantomX.AutoJump = value
        if hum then
            hum.Jump = value
        end
        
    -- ███ ANTI-STUN ███
    elseif scriptName == "Anti-Stun" then
        _G.PhantomX.AntiStun = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if _G.PhantomX.AntiStun and hum then
                    hum.PlatformStand = false
                end
            end)
        end
        
    -- ███ PERFECT DODGE ███
    elseif scriptName == "Perfect Dodge" then
        _G.PhantomX.PerfectDodge = value
        
    -- ███ INSTANT COOLDOWN ███
    elseif scriptName == "Instant Cooldown" then
        _G.PhantomX.InstantCooldown = value
        if value then
            for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                    v.Value = 0
                end
            end
        end
        
    -- ███ INFINITE AMMO ███
    elseif scriptName == "Infinite Ammo" then
        _G.PhantomX.InfiniteAmmo = value
        if value then
            for _, v in ipairs(player.Backpack:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                    v.Ammo.Value = 999
                end
            end
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                    v.Ammo.Value = 999
                end
            end
        end
        
    -- ███ NO RECOIL ███
    elseif scriptName == "No Recoil" then
        _G.PhantomX.NoRecoil = value
        if value then
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name:lower():find("recoil") then
                    v:Destroy()
                end
            end
        end
        
    -- ███ AUTO COLLECT ███
    elseif scriptName == "Auto Collect" then
        _G.PhantomX.AutoCollect = value
        while _G.PhantomX.AutoCollect do
            task.wait(0.1)
            pcall(function()
                for _, v in ipairs(game.Workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name:lower():find("coin") or v.Name:lower():find("gem") or v.Name:lower():find("drop") then
                        if hrp then
                            hrp.CFrame = v.CFrame
                        end
                    end
                end
            end)
        end
        
    -- ███ AUTO BRIDGE ███
    elseif scriptName == "Auto Bridge" then
        _G.PhantomX.AutoBridge = value
        
    -- ███ AUTO PLACE ███
    elseif scriptName == "Auto Place" then
        _G.PhantomX.AutoPlace = value
        
    -- ███ AUTO SUMMON ███
    elseif scriptName == "Auto Summon" then
        _G.PhantomX.AutoSummon = value
        
    -- ███ AUTO PARRY ███
    elseif scriptName == "Auto Parry" then
        _G.PhantomX.AutoParry = value
        
    -- ███ AUTO RESET ███
    elseif scriptName == "Auto Reset" then
        _G.PhantomX.AutoReset = value
        while _G.PhantomX.AutoReset do
            task.wait(0.5)
            pcall(function()
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.Health = 0
                end
                player:LoadCharacter()
            end)
        end
    end
end

-- ██████████████████████████████████████████████████████████████
-- SECTION 9: COMBAT SETTINGS TAB
-- ██████████████████████████████████████████████████████████████

local CombatSection = CombatTab:CreateSection("⚔️ Aim Settings")

CombatSection:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "Torso", "HumanoidRootPart", "LowerTorso", "UpperTorso", "RightArm", "LeftArm", "RightLeg", "LeftLeg"},
    Default = "Head",
    Callback = function(option)
        _G.PhantomX.AimPart = option
    end
})

CombatSection:CreateSlider({
    Name = "Aim FOV",
    Range = {1, 360},
    Increment = 1,
    Default = 90,
    Callback = function(value)
        _G.PhantomX.AimFOV = value
    end
})

CombatSection:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 200},
    Increment = 1,
    Default = 50,
    Callback = function(value)
        _G.PhantomX.FlySpeed = value
    end
})

CombatSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 1,
    Default = 16,
    Callback = function(value)
        _G.PhantomX.WalkSpeed = value
        local hum = GetHumanoid()
        if hum then
            hum.WalkSpeed = value
        end
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 10: WEAPON GIVER (UTILITY TAB)
-- ██████████████████████████████████████████████████████████████

local WeaponSection = UtilityTab:CreateSection("🔫 Weapon Giver")

local weaponList = GetWeapons()
local selectedWeapon = weaponList[1] or "No Weapons Found"

WeaponSection:CreateDropdown({
    Name = "Select Weapon",
    Options = weaponList,
    Default = selectedWeapon,
    Callback = function(option)
        selectedWeapon = option
    end
})

WeaponSection:CreateButton({
    Name = "Give Selected Weapon",
    Callback = function()
        if selectedWeapon and selectedWeapon ~= "No Weapons Found" then
            pcall(function()
                local found = false
                local locations = {game.ReplicatedStorage, game.Workspace, game.ServerStorage}
                
                for _, loc in ipairs(locations) do
                    if loc then
                        local tool = loc:FindFirstChild(selectedWeapon)
                        if tool and tool:IsA("Tool") then
                            tool:Clone().Parent = player.Backpack
                            found = true
                            break
                        end
                        for _, child in ipairs(loc:GetChildren()) do
                            if child:IsA("Folder") then
                                local tool = child:FindFirstChild(selectedWeapon)
                                if tool and tool:IsA("Tool") then
                                    tool:Clone().Parent = player.Backpack
                                    found = true
                                    break
                                end
                            end
                        end
                    end
                end
                
                if not found then
                    local newTool = Instance.new("Tool")
                    newTool.Name = selectedWeapon
                    newTool.RequiresHandle = false
                    newTool.Parent = player.Backpack
                end
            end)
        end
    end
})

WeaponSection:CreateButton({
    Name = "Refresh Weapon List",
    Callback = function()
        local newList = GetWeapons()
        if #newList == 0 then
            table.insert(newList, "No Weapons Found")
        end
        -- Update dropdown
        -- Note: Would need to recreate dropdown for full refresh
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 11: UTILITY TOGGLES
-- ██████████████████████████████████████████████████████████████

local UtilitySection = UtilityTab:CreateSection("🛠️ Utility")

UtilitySection:CreateToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(value)
        _G.PhantomX.NoClip = value
        ExecuteScript("No Clip", value)
    end
})

UtilitySection:CreateToggle({
    Name = "Fly",
    Default = false,
    Callback = function(value)
        _G.PhantomX.Fly = value
        ExecuteScript("Fly", value)
    end
})

UtilitySection:CreateToggle({
    Name = "Speed Hack",
    Default = false,
    Callback = function(value)
        _G.PhantomX.SpeedHack = value
        ExecuteScript("Speed Hack", value)
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 12: VISUAL SETTINGS TAB
-- ██████████████████████████████████████████████████████████████

local VisualSection = VisualTab:CreateSection("👁️ Visual Settings")

VisualSection:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(value)
        _G.PhantomX.ESP = value
        ExecuteScript("ESP", value)
    end
})

VisualSection:CreateToggle({
    Name = "Chams",
    Default = false,
    Callback = function(value)
        _G.PhantomX.Chams = value
        if value then
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character then
                    for _, part in ipairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = part
                            highlight.Adornee = part
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.FillTransparency = 0.3
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.OutlineTransparency = 0
                        end
                    end
                end
            end
        else
            for _, v in ipairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character then
                    for _, part in ipairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            for _, h in ipairs(part:GetChildren()) do
                                if h:IsA("Highlight") then
                                    h:Destroy()
                                end
                            end
                        end
                    end
                end
            end
        end
    end
})

VisualSection:CreateToggle({
    Name = "Full Bright",
    Default = false,
    Callback = function(value)
        if value then
            game.Lighting.Brightness = 10
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            game.Lighting.GlobalShadows = false
        else
            game.Lighting.Brightness = 2
            game.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            game.Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            game.Lighting.GlobalShadows = true
        end
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 13: ADMIN TAB - PLAYER CONTROL
-- ██████████████████████████████████████████████████████████████

local AdminSection = AdminTab:CreateSection("👑 Player Control")

local function RefreshPlayerList()
    local players = GetAllPlayers()
    if #players == 0 then
        table.insert(players, "No Players Found")
    end
    return players
end

local targetPlayer = "No Players Found"
local playerList = RefreshPlayerList()

if #playerList > 0 then
    targetPlayer = playerList[1]
end

AdminSection:CreateDropdown({
    Name = "Target Player",
    Options = playerList,
    Default = targetPlayer,
    Callback = function(option)
        targetPlayer = option
        _G.PhantomX.TargetPlayer = option
    end
})

AdminSection:CreateButton({
    Name = "Bring Player to Me",
    Callback = function()
        if targetPlayer and targetPlayer ~= "No Players Found" then
            pcall(function()
                local target = game.Players:FindFirstChild(targetPlayer)
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    if hrp then
                        target.Character.HumanoidRootPart.CFrame = hrp.CFrame
                    end
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if targetPlayer and targetPlayer ~= "No Players Found" then
            pcall(function()
                local target = game.Players:FindFirstChild(targetPlayer)
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                    if hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                    end
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Kill Player",
    Callback = function()
        if targetPlayer and targetPlayer ~= "No Players Found" then
            pcall(function()
                local target = game.Players:FindFirstChild(targetPlayer)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.Health = 0
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Freeze Player",
    Callback = function()
        if targetPlayer and targetPlayer ~= "No Players Found" then
            pcall(function()
                local target = game.Players:FindFirstChild(targetPlayer)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.WalkSpeed = 0
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Unfreeze Player",
    Callback = function()
        if targetPlayer and targetPlayer ~= "No Players Found" then
            pcall(function()
                local target = game.Players:FindFirstChild(targetPlayer)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.WalkSpeed = 16
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        local newList = RefreshPlayerList()
        -- Would need to recreate dropdown
    end
})

-- ██████████████████████████████████████████████████████████████
-- SECTION 14: CREDITS TAB
-- ██████████████████████████████████████████████████████████████

local CreditsSection = CreditsTab:CreateSection("✦ The Invisible Man ✦")

CreditsSection:CreateLabel("═══════════════════════════")
CreditsSection:CreateLabel("        PHANTOM X")
CreditsSection:CreateLabel("═══════════════════════════")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("Developed by: The Invisible Man")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("'They said it couldn't be done.'")
CreditsSection:CreateLabel("'They were wrong.'")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("═══════════════════════════")
CreditsSection:CreateLabel("All Rights Reserved")
CreditsSection:CreateLabel("═══════════════════════════")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("Version: 3.0.0")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("✨ Thank you for using Phantom X ✨")

-- ██████████████████████████████████████████████████████████████
-- SECTION 15: INITIALIZATION
-- ██████████████████████████████████████████████████████████████

-- Load default game scripts
LoadGameScripts(AllGames[1])

-- Print success message
print("════════════════════════════════════════════════════════════")
print("✦ PHANTOM X LOADED SUCCESSFULLY ✦")
print("════════════════════════════════════════════════════════════")
print("✦ By: The Invisible Man")
print("✦ Version: 3.0.0")
print("✦ Games Supported: " .. #AllGames)
print("✦ Scripts: Dynamic Loading")
print("✦ Anti-Cheat: Neutralized")
print("════════════════════════════════════════════════════════════")

-- ██████████████████████████████████████████████████████████████
-- SECTION 16: KEYBINDS (Optional)
-- ██████████████████████████████████████████████████████████████

local function SetupKeybinds()
    -- Toggle GUI with Insert
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Insert then
            Window:Toggle()
        end
    end)
    
    -- Quick Fly toggle with F
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F then
            _G.PhantomX.Fly = not _G.PhantomX.Fly
            ExecuteScript("Fly", _G.PhantomX.Fly)
        end
    end)
end

pcall(SetupKeybinds)

-- ██████████████████████████████████████████████████████████████
-- END OF SCRIPT
-- ██████████████████████████████████████████████████████████████
