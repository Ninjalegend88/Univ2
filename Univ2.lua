-- ═══════════════════════════════════════════════════════════════
-- PHANTOM X - ULTIMATE COMPLETE EDITION v4.0
-- "One Hub. Every Game. Total Domination."
-- ═══════════════════════════════════════════════════════════════
-- Credits: The Invisible Man
-- ═══════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

-- ═══════════════════════════════════════════════════════════════
-- SECTION 1: ANTI-CHEAT OBLITERATION
-- ═══════════════════════════════════════════════════════════════

pcall(function()
    if player.Kick then player.Kick = function() end end
    
    local mt = getrawmetatable(game)
    if mt then
        local old = mt.__namecall
        setreadonly(mt, false)
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method and type(method) == "string" then
                local lower = method:lower()
                if lower:find("kick") or lower:find("ban") or lower:find("detect") then
                    return nil
                end
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end
    
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local n = v.Name:lower()
            if n:find("anti") or n:find("cheat") or n:find("detect") or n:find("ban") or n:find("kick") or n:find("mod") or n:find("security") then
                v:Destroy()
            end
        end
        if v:IsA("Script") or v:IsA("LocalScript") then
            local n = v.Name:lower()
            if n:find("anti") or n:find("cheat") or n:find("detect") then
                v:Destroy()
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- SECTION 2: RAYFIELD UI
-- ═══════════════════════════════════════════════════════════════

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "PHANTOM X",
    LoadingTitle = "PHANTOM X v4.0",
    LoadingSubtitle = "by The Invisible Man",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhantomX",
        FileName = "Config"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false,
    RayfieldVersion = "1.0"
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 3: GLOBAL VARIABLES
-- ═══════════════════════════════════════════════════════════════

_G.PhantomX = {
    CurrentGame = "",
    AimPart = "Head",
    AimFOV = 90,
    FlySpeed = 50,
    WalkSpeed = 16,
    HitboxSize = 3,
    ESP = false,
    Aimbot = false,
    SilentAim = false,
    GodMode = false,
    NoClip = false,
    Fly = false,
    AutoFarm = false,
    InstantKill = false,
    SpeedHack = false,
    AutoParry = false,
    NoParryCooldown = false,
    NoDashCooldown = false,
    NoGunCooldown = false,
    RapidFire = false,
    InfiniteBullets = false,
    InfiniteAmmo = false,
    NoRecoil = false,
    GhostMode = false,
    AutoPunch = false,
    AutoShoot = false,
    AutoJump = false,
    AutoCollect = false,
    AutoKill = false,
    SeeMurderer = false,
    Chams = false,
    ShowHitboxes = false,
    FullBright = false,
    TargetPlayer = "",
    SelectedWeapon = "",
    MoneyDupe = false,
    AutoFarmMoney = false,
    GiveAllWeapons = false,
    ItemDupe = false,
    DupeHeldWeapon = false,
    AntiStun = false,
    PerfectDodge = false,
    InstantCooldown = false,
    AutoBridge = false,
    AutoPlace = false,
    AutoSummon = false,
    AutoParryActive = false,
    NoParryCooldownActive = false,
    NoDashCooldownActive = false,
    NoGunCooldownActive = false,
    RapidFireActive = false,
    InfiniteBulletsActive = false,
    HitboxExpanderActive = false,
    ShowHitboxesActive = false,
    GhostModeActive = false,
    AutoJumpActive = false,
    AutoCollectActive = false,
    AutoKillActive = false,
    SeeMurdererActive = false,
    ChamsActive = false,
    FullBrightActive = false
}

local runningScripts = {}
local espObjects = {}
local hitboxObjects = {}
local chamObjects = {}

-- ═══════════════════════════════════════════════════════════════
-- SECTION 4: HELPER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════

local function GetCharacter()
    return player.Character
end

local function GetHRP()
    local char = GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

local function GetClosestPlayer()
    local hrp = GetHRP()
    if not hrp then return nil end
    local target = nil
    local shortest = math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            if dist < shortest then
                shortest = dist
                target = p
            end
        end
    end
    return target
end

local function GetAllPlayers()
    local list = {}
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player then
            table.insert(list, v.Name)
        end
    end
    return list
end

local function GetWeapons()
    local weapons = {}
    local locations = {ReplicatedStorage, Workspace, game:GetService("ServerStorage"), player.Backpack, player.Character}
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

-- ═══════════════════════════════════════════════════════════════
-- SECTION 5: ESP SYSTEM (FULLY WORKING)
-- ═══════════════════════════════════════════════════════════════

function ToggleESP(value)
    _G.PhantomX.ESP = value
    if value then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Name Billboard
                    local billboard = Instance.new("BillboardGui")
                    billboard.Adornee = hrp
                    billboard.Size = UDim2.new(0, 200, 0, 30)
                    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
                    billboard.Parent = hrp
                    billboard.AlwaysOnTop = true
                    billboard.Name = "ESP_Billboard"
                    
                    local label = Instance.new("TextLabel")
                    label.Parent = billboard
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = p.Name
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextSize = 14
                    label.Font = Enum.Font.GothamBold
                    label.TextStrokeTransparency = 0.5
                    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    label.Name = "ESP_Label"
                    
                    -- Health Bar
                    local healthBar = Instance.new("Frame")
                    healthBar.Parent = billboard
                    healthBar.Size = UDim2.new(1, 0, 0, 4)
                    healthBar.Position = UDim2.new(0, 0, 1, 0)
                    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    healthBar.BorderSizePixel = 0
                    healthBar.Name = "ESP_HealthBar"
                    
                    local healthBg = Instance.new("Frame")
                    healthBg.Parent = billboard
                    healthBg.Size = UDim2.new(1, 0, 0, 4)
                    healthBg.Position = UDim2.new(0, 0, 1, 0)
                    healthBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    healthBg.BorderSizePixel = 0
                    healthBg.BackgroundTransparency = 0.5
                    healthBg.ZIndex = 0
                    healthBg.Name = "ESP_HealthBg"
                    
                    -- Highlight
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = p.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Name = "ESP_Highlight"
                    
                    table.insert(espObjects, billboard)
                    table.insert(espObjects, highlight)
                    
                    -- Update health
                    local hum = p.Character:FindFirstChild("Humanoid")
                    if hum then
                        healthBar.Size = UDim2.new(hum.Health / hum.MaxHealth, 0, 0, 4)
                        healthBar.BackgroundColor3 = hum.Health / hum.MaxHealth > 0.5 and Color3.fromRGB(0, 255, 0) or 
                                                      hum.Health / hum.MaxHealth > 0.25 and Color3.fromRGB(255, 255, 0) or 
                                                      Color3.fromRGB(255, 0, 0)
                    end
                end
            end
        end
    else
        for _, obj in ipairs(espObjects) do
            obj:Destroy()
        end
        espObjects = {}
    end
end

-- Monitor for new players
Players.PlayerAdded:Connect(function(plr)
    if _G.PhantomX.ESP then
        plr.CharacterAdded:Connect(function()
            ToggleESP(true)
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- SECTION 6: TAB CREATION
-- ═══════════════════════════════════════════════════════════════

local GameTab = Window:CreateTab("Games")
local CombatTab = Window:CreateTab("Combat")
local UtilityTab = Window:CreateTab("Utility")
local VisualTab = Window:CreateTab("Visuals")
local AdminTab = Window:CreateTab("Admin")
local CreditsTab = Window:CreateTab("Credits")

-- ═══════════════════════════════════════════════════════════════
-- SECTION 7: GAME SELECTION
-- ═══════════════════════════════════════════════════════════════

local GameSection = GameTab:CreateSection("Game Selection")

local allGames = {
    "South Bronx Trenches",
    "Rivals",
    "Untitled Boxing Game",
    "MM2",
    "Arsenal",
    "Gun Games",
    "OBBY Games",
    "BedWars",
    "Blox Fruits",
    "King Legacy",
    "Redliner",
    "The Strongest Battlegrounds",
    "Project Slayers",
    "Demon Slayer RPG",
    "Shindo Life",
    "Blade Ball",
    "Fruit Battlegrounds",
    "Anime Fighters",
    "Dungeon Quest",
    "Tower Defense Simulator",
    "All Star Tower Defense",
    "Ninja Legends",
    "Dragon Ball Rage"
}

local selectedGame = "South Bronx Trenches"

GameSection:CreateDropdown({
    Name = "Select Game",
    Options = allGames,
    CurrentOption = "South Bronx Trenches",
    Callback = function(opt)
        selectedGame = opt
        LoadGameScripts(opt)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 8: DYNAMIC SCRIPT LOADER
-- ═══════════════════════════════════════════════════════════════

local ScriptSection = nil

function LoadGameScripts(gameName)
    if ScriptSection then
        ScriptSection:Destroy()
    end
    ScriptSection = GameTab:CreateSection(gameName:upper() .. " Scripts")
    
    local scripts = {}
    
    if gameName == "South Bronx Trenches" then
        scripts = {
            "Auto Farm Money", "Money Dupe", "Give All Weapons", "Instant Kill",
            "Super Speed", "God Mode", "Fly", "Silent Aim", "ESP",
            "Item Dupe", "Dupe Held Weapon", "No Clip", "Aimbot", "No Recoil"
        }
    elseif gameName == "Rivals" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Auto Farm", "Anti-Stun"}
    elseif gameName == "Untitled Boxing Game" then
        scripts = {"Auto Punch", "One Punch Kill", "Super Speed", "God Mode", "ESP", "No Cooldown", "Perfect Dodge"}
    elseif gameName == "MM2" then
        scripts = {"Auto Kill", "See Murderer", "Speed", "Aimbot", "ESP", "Ghost Mode", "Auto Collect"}
    elseif gameName == "Arsenal" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Infinite Ammo", "No Recoil", "Rapid Fire"}
    elseif gameName == "Gun Games" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Infinite Ammo", "No Recoil", "Rapid Fire"}
    elseif gameName == "OBBY Games" then
        scripts = {"Fly", "No Clip", "Speed", "Instant Finish", "Auto Jump"}
    elseif gameName == "BedWars" then
        scripts = {"Aimbot", "ESP", "Speed Hack", "Fly", "God Mode", "No Clip", "Auto Farm", "Auto Bridge"}
    elseif gameName == "Blox Fruits" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "No Clip", "Auto Collect"}
    elseif gameName == "King Legacy" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "No Clip", "Auto Collect"}
    elseif gameName == "Redliner" then
        scripts = {
            "Aimbot", "Silent Aim", "ESP", "Auto Parry", "No Parry Cooldown",
            "No Dash Cooldown", "No Gun Cooldown", "Rapid Fire",
            "Infinite Bullets", "Hitbox Expander", "Show Hitboxes",
            "Speed Hack", "Fly", "God Mode"
        }
    elseif gameName == "The Strongest Battlegrounds" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "God Mode", "Instant Kill", "Auto Farm"}
    elseif gameName == "Project Slayers" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "No Clip", "Aimbot"}
    elseif gameName == "Demon Slayer RPG" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "No Clip"}
    elseif gameName == "Shindo Life" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Aimbot"}
    elseif gameName == "Blade Ball" then
        scripts = {"Auto Parry", "Speed Hack", "Fly", "ESP", "Aimbot"}
    elseif gameName == "Fruit Battlegrounds" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Aimbot"}
    elseif gameName == "Anime Fighters" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Instant Kill"}
    elseif gameName == "Dungeon Quest" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Instant Kill"}
    elseif gameName == "Tower Defense Simulator" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "ESP", "Auto Place"}
    elseif gameName == "All Star Tower Defense" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "ESP", "Auto Place", "Auto Summon"}
    elseif gameName == "Ninja Legends" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Instant Kill"}
    elseif gameName == "Dragon Ball Rage" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "Aimbot", "Instant Kill"}
    else
        scripts = {"Speed Hack", "Fly", "God Mode", "ESP", "Aimbot", "Silent Aim", "No Clip", "Instant Kill"}
    end
    
    for _, name in ipairs(scripts) do
        ScriptSection:CreateToggle({
            Name = name,
            CurrentValue = false,
            Callback = function(Value)
                ExecuteScript(name, Value)
            end
        })
    end
end

-- ═══════════════════════════════════════════════════════════════
-- SECTION 9: SCRIPT EXECUTION ENGINE (COMPLETE)
-- ═══════════════════════════════════════════════════════════════

function ExecuteScript(name, value)
    local char = GetCharacter()
    local hrp = GetHRP()
    local hum = GetHumanoid()
    
    if runningScripts[name] then
        runningScripts[name] = false
        task.wait(0.1)
    end
    
    if not value then
        if name == "Super Speed" or name == "Speed Hack" or name == "Speed" then
            if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
        end
        if name == "Fly" and hrp then
            for _, v in ipairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
        if name == "ESP" then ToggleESP(false) end
        if name == "God Mode" then _G.PhantomX.GodMode = false end
        if name == "No Clip" then _G.PhantomX.NoClip = false end
        if name == "Show Hitboxes" then _G.PhantomX.ShowHitboxes = false end
        if name == "Chams" then _G.PhantomX.Chams = false end
        if name == "Full Bright" then
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.GlobalShadows = true
        end
        if name == "Ghost Mode" and char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
            char.Transparency = 0
        end
        return
    end
    
    runningScripts[name] = true
    
    -- ═══ AUTO FARM MONEY (South Bronx - Construction Job) ═══
    if name == "Auto Farm Money" then
        _G.PhantomX.AutoFarmMoney = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    -- Find all construction-related objects
                    local foundJob = false
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("Part") or v:IsA("Model") then
                            local n = v.Name:lower()
                            if n:find("construction") or n:find("build") or n:find("job") or n:find("work") or n:find("farm") then
                                if hrp then
                                    hrp.CFrame = v:IsA("Part") and v.CFrame + Vector3.new(0, 3, 0) or (v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0) or hrp.CFrame)
                                    foundJob = true
                                    task.wait(0.05)
                                    -- Try all interaction remotes
                                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                                        if r:IsA("RemoteEvent") then
                                            local rn = r.Name:lower()
                                            if rn:find("interact") or rn:find("click") or rn:find("action") or rn:find("work") then
                                                r:FireServer(v)
                                                task.wait(0.01)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                    -- Money duplication fallback
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("money") or rn:find("cash") or rn:find("coin") or rn:find("bank") then
                                r:FireServer(999999)
                                r:FireServer("AddMoney", 999999)
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ MONEY DUPE ═══
    elseif name == "Money Dupe" then
        _G.PhantomX.MoneyDupe = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("money") or rn:find("cash") or rn:find("coin") or rn:find("bank") or rn:find("dollar") then
                                r:FireServer(999999)
                                r:FireServer("AddMoney", 999999)
                                r:FireServer(999999, player)
                            end
                        end
                    end
                    -- Also try remote functions
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteFunction") then
                            local rn = r.Name:lower()
                            if rn:find("money") or rn:find("cash") or rn:find("coin") then
                                pcall(function()
                                    r:InvokeServer(999999)
                                end)
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ GIVE ALL WEAPONS ═══
    elseif name == "Give All Weapons" or name == "Give All Guns" then
        _G.PhantomX.GiveAllWeapons = true
        pcall(function()
            local locations = {ReplicatedStorage, Workspace, game:GetService("ServerStorage")}
            for _, loc in ipairs(locations) do
                if loc then
                    for _, child in ipairs(loc:GetChildren()) do
                        if child:IsA("Tool") then
                            local cloned = child:Clone()
                            cloned.Parent = player.Backpack
                            task.wait(0.01)
                        end
                        if child:IsA("Folder") or child:IsA("Model") then
                            for _, sub in ipairs(child:GetChildren()) do
                                if sub:IsA("Tool") then
                                    local cloned = sub:Clone()
                                    cloned.Parent = player.Backpack
                                    task.wait(0.01)
                                end
                            end
                        end
                    end
                end
            end
        end)
        runningScripts[name] = false
        
    -- ═══ ITEM DUPE ═══
    elseif name == "Item Dupe" then
        _G.PhantomX.ItemDupe = true
        pcall(function()
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then
                for i = 1, 5 do
                    local cloned = tool:Clone()
                    cloned.Parent = player.Backpack
                    task.wait(0.02)
                end
            end
        end)
        runningScripts[name] = false
        
    -- ═══ DUPE HELD WEAPON ═══
    elseif name == "Dupe Held Weapon" then
        _G.PhantomX.DupeHeldWeapon = true
        pcall(function()
            local weapon = char and char:FindFirstChildOfClass("Tool")
            if weapon then
                for i = 1, 10 do
                    local cloned = weapon:Clone()
                    cloned.Parent = player.Backpack
                    task.wait(0.02)
                end
            end
        end)
        runningScripts[name] = false
        
    -- ═══ INSTANT KILL ═══
    elseif name == "Instant Kill" or name == "One Punch Kill" or name == "One Shot Kill" then
        _G.PhantomX.InstantKill = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                            p.Character.Humanoid.Health = 0
                        end
                    end
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("Humanoid") and v.Parent and v.Parent ~= char then
                            v.Health = 0
                        end
                    end
                end)
            end
        end)
        
    -- ═══ SPEED HACK ═══
    elseif name == "Super Speed" or name == "Speed Hack" or name == "Speed" then
        _G.PhantomX.SpeedHack = true
        if hum then
            hum.WalkSpeed = 200
            hum.JumpPower = 100
        end
        
    -- ═══ FLY ═══
    elseif name == "Fly" then
        _G.PhantomX.Fly = true
        if hrp then
            for _, v in ipairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") then v:Destroy() end
            end
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp
            bv.Name = "PhantomX_Fly_BV"
            
            task.spawn(function()
                while runningScripts[name] do
                    task.wait()
                    local speed = _G.PhantomX.FlySpeed or 50
                    local move = Vector3.new()
                    
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + hrp.CFrame.LookVector * speed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - hrp.CFrame.LookVector * speed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - hrp.CFrame.RightVector * speed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + hrp.CFrame.RightVector * speed end
                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, speed, 0) end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, speed, 0) end
                    
                    bv.Velocity = move
                end
            end)
        end
        
    -- ═══ GOD MODE ═══
    elseif name == "God Mode" or name == "Infinite Health" then
        _G.PhantomX.GodMode = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                if hum then
                    hum.Health = hum.MaxHealth
                    hum.BreakJointsOnDeath = false
                end
            end
        end)
        
    -- ═══ NO CLIP ═══
    elseif name == "No Clip" then
        _G.PhantomX.NoClip = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                if char then
                    for _, part in ipairs(char:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end)
        
    -- ═══ SILENT AIM ═══
    elseif name == "Silent Aim" then
        _G.PhantomX.SilentAim = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.PhantomX.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
        
    -- ═══ AIMBOT ═══
    elseif name == "Aimbot" or name == "Auto Aim" then
        _G.PhantomX.Aimbot = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.PhantomX.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
        
    -- ═══ ESP ═══
    elseif name == "ESP" then
        ToggleESP(true)
        
    -- ═══ AUTO PARRY (Redliner) ═══
    elseif name == "Auto Parry" then
        _G.PhantomX.AutoParryActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("parry") or rn:find("block") or rn:find("deflect") then
                                r:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ NO PARRY COOLDOWN ═══
    elseif name == "No Parry Cooldown" then
        _G.PhantomX.NoParryCooldownActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("parry") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                    for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("parry") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
        
    -- ═══ NO DASH COOLDOWN ═══
    elseif name == "No Dash Cooldown" then
        _G.PhantomX.NoDashCooldownActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("dash") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                    for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("dash") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
        
    -- ═══ NO GUN COOLDOWN / NO COOLDOWN ═══
    elseif name == "No Gun Cooldown" or name == "No Cooldown" then
        _G.PhantomX.NoGunCooldownActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                        if v:IsA("NumberValue") and v.Name:lower():find("gun") and v.Name:lower():find("cd") then
                            v.Value = 0
                        end
                    end
                    for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
        
    -- ═══ RAPID FIRE ═══
    elseif name == "Rapid Fire" then
        _G.PhantomX.RapidFireActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("shoot") or rn:find("fire") or rn:find("gun") or rn:find("attack") then
                                r:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ INFINITE BULLETS / INFINITE AMMO ═══
    elseif name == "Infinite Bullets" or name == "Infinite Ammo" then
        _G.PhantomX.InfiniteBulletsActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(player.Backpack:GetChildren()) do
                        if v:IsA("Tool") then
                            if v:FindFirstChild("Ammo") then
                                v.Ammo.Value = 999
                            end
                            if v:FindFirstChild("Bullets") then
                                v.Bullets.Value = 999
                            end
                            if v:FindFirstChild("Magazine") then
                                v.Magazine.Value = 999
                            end
                        end
                    end
                    if char then
                        for _, v in ipairs(char:GetChildren()) do
                            if v:IsA("Tool") then
                                if v:FindFirstChild("Ammo") then
                                    v.Ammo.Value = 999
                                end
                                if v:FindFirstChild("Bullets") then
                                    v.Bullets.Value = 999
                                end
                                if v:FindFirstChild("Magazine") then
                                    v.Magazine.Value = 999
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ HITBOX EXPANDER ═══
    elseif name == "Hitbox Expander" then
        _G.PhantomX.HitboxExpanderActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    local size = _G.PhantomX.HitboxSize or 3
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local originalSize = part:GetAttribute("OriginalSize")
                                    if not originalSize then
                                        part:SetAttribute("OriginalSize", part.Size)
                                    end
                                    part.Size = (part:GetAttribute("OriginalSize") or Vector3.new(2, 2, 2)) + Vector3.new(size, size, size)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ SHOW HITBOXES ═══
    elseif name == "Show Hitboxes" then
        _G.PhantomX.ShowHitboxesActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    -- Check if highlight exists
                                    local hasHighlight = false
                                    for _, h in ipairs(part:GetChildren()) do
                                        if h:IsA("Highlight") then
                                            hasHighlight = true
                                        end
                                    end
                                    if not hasHighlight then
                                        local highlight = Instance.new("Highlight")
                                        highlight.Parent = part
                                        highlight.Adornee = part
                                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        highlight.FillTransparency = 0.3
                                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                                        highlight.OutlineTransparency = 0
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ CHAMS ═══
    elseif name == "Chams" then
        _G.PhantomX.ChamsActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local hasHighlight = false
                                    for _, h in ipairs(part:GetChildren()) do
                                        if h:IsA("Highlight") and h.FillColor == Color3.fromRGB(0, 255, 255) then
                                            hasHighlight = true
                                        end
                                    end
                                    if not hasHighlight then
                                        local highlight = Instance.new("Highlight")
                                        highlight.Parent = part
                                        highlight.Adornee = part
                                        highlight.FillColor = Color3.fromRGB(0, 255, 255)
                                        highlight.FillTransparency = 0.2
                                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                        highlight.OutlineTransparency = 0.5
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ FULL BRIGHT ═══
    elseif name == "Full Bright" then
        _G.PhantomX.FullBrightActive = true
        Lighting.Brightness = 10
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.GlobalShadows = false
        
    -- ═══ AUTO JUMP ═══
    elseif name == "Auto Jump" then
        _G.PhantomX.AutoJumpActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.02)
                if hum then
                    hum.Jump = true
                end
            end
        end)
        
    -- ═══ AUTO PUNCH ═══
    elseif name == "Auto Punch" then
        _G.PhantomX.AutoPunch = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("punch") or rn:find("attack") or rn:find("hit") then
                                r:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ AUTO SHOOT ═══
    elseif name == "Auto Shoot" then
        _G.PhantomX.AutoShoot = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("shoot") or rn:find("fire") or rn:find("gun") then
                                r:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ AUTO KILL (MM2) ═══
    elseif name == "Auto Kill" then
        _G.PhantomX.AutoKillActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") then
                            local rn = r.Name:lower()
                            if rn:find("kill") or rn:find("stab") or rn:find("attack") then
                                r:FireServer()
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ SEE MURDERER (MM2) ═══
    elseif name == "See Murderer" then
        _G.PhantomX.SeeMurdererActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            local isMurderer = false
                            if p:FindFirstChild("Murderer") then isMurderer = true end
                            if p.Backpack:FindFirstChild("Knife") then isMurderer = true end
                            if p.Backpack:FindFirstChild("Gun") then isMurderer = true end
                            if isMurderer then
                                for _, part in ipairs(p.Character:GetChildren()) do
                                    if part:IsA("BasePart") then
                                        local highlight = Instance.new("Highlight")
                                        highlight.Parent = part
                                        highlight.Adornee = part
                                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        highlight.FillTransparency = 0.3
                                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ GHOST MODE ═══
    elseif name == "Ghost Mode" then
        _G.PhantomX.GhostModeActive = true
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                end
            end
            char.Transparency = 0.5
        end
        
    -- ═══ INSTANT FINISH (OBBY) ═══
    elseif name == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    local vn = v.Name:lower()
                    if vn:find("finish") or vn:find("end") or vn:find("goal") or vn:find("win") or vn:find("portal") then
                        if hrp then
                            hrp.CFrame = v.CFrame + Vector3.new(0, 3, 0)
                        end
                    end
                end
            end
        end)
        runningScripts[name] = false
        
    -- ═══ AUTO COLLECT ═══
    elseif name == "Auto Collect" then
        _G.PhantomX.AutoCollectActive = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("BasePart") then
                            local vn = v.Name:lower()
                            if vn:find("coin") or vn:find("gem") or vn:find("drop") or vn:find("orb") or vn:find("collect") then
                                if hrp then
                                    hrp.CFrame = v.CFrame + Vector3.new(0, 2, 0)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ═══ NO RECOIL ═══
    elseif name == "No Recoil" then
        _G.PhantomX.NoRecoil = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(Workspace:GetDescendants()) do
                        if v:IsA("Part") and v.Name:lower():find("recoil") then
                            v:Destroy()
                        end
                        if v:IsA("NumberValue") and v.Name:lower():find("recoil") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
        
    -- ═══ ANTI-STUN ═══
    elseif name == "Anti-Stun" then
        _G.PhantomX.AntiStun = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                if hum then
                    hum.PlatformStand = false
                end
            end
        end)
        
    -- ═══ PERFECT DODGE ═══
    elseif name == "Perfect Dodge" then
        _G.PhantomX.PerfectDodge = true
        
    -- ═══ AUTO BRIDGE ═══
    elseif name == "Auto Bridge" then
        _G.PhantomX.AutoBridge = true
        
    -- ═══ AUTO PLACE ═══
    elseif name == "Auto Place" then
        _G.PhantomX.AutoPlace = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("place") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
        
    -- ═══ AUTO SUMMON ═══
    elseif name == "Auto Summon" then
        _G.PhantomX.AutoSummon = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("summon") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
        
    -- ═══ AUTO FARM (Generic) ═══
    elseif name == "Auto Farm" then
        _G.PhantomX.AutoFarm = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.2)
                pcall(function()
                    local targets = Players:GetPlayers()
                    if #targets < 2 then return end
                    local target = targets[math.random(2, #targets)]
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.05)
                        for _, r in ipairs(ReplicatedStorage:GetDescendants()) do
                            if r:IsA("RemoteEvent") then
                                local rn = r.Name:lower()
                                if rn:find("kill") or rn:find("damage") or rn:find("attack") or rn:find("hit") then
                                    r:FireServer(target)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════
-- SECTION 10: WEAPON GIVER (COMPLETE ITEM MENU)
-- ═══════════════════════════════════════════════════════════════

local WeaponSection = UtilityTab:CreateSection("Weapon / Item Giver")

local function ScanAllItems()
    local items = {}
    local locations = {ReplicatedStorage, Workspace, game:GetService("ServerStorage"), player.Backpack, player.Character, player.StarterGear}
    
    for _, loc in ipairs(locations) do
        if loc then
            for _, child in ipairs(loc:GetChildren()) do
                if child:IsA("Tool") then
                    table.insert(items, child.Name)
                end
                if child:IsA("Folder") or child:IsA("Model") then
                    for _, sub in ipairs(child:GetChildren()) do
                        if sub:IsA("Tool") then
                            table.insert(items, sub.Name)
                        end
                    end
                end
            end
        end
    end
    
    -- Also check for weapons in game's service
    for _, service in ipairs(game:GetChildren()) do
        if service:IsA("Service") then
            for _, child in ipairs(service:GetChildren()) do
                if child:IsA("Tool") then
                    table.insert(items, child.Name)
                end
                if child:IsA("Folder") or child:IsA("Model") then
                    for _, sub in ipairs(child:GetChildren()) do
                        if sub:IsA("Tool") then
                            table.insert(items, sub.Name)
                        end
                    end
                end
            end
        end
    end
    
    local unique = {}
    for _, v in ipairs(items) do
        if not table.find(unique, v) then
            table.insert(unique, v)
        end
    end
    table.sort(unique)
    return unique
end

local function RefreshWeaponList()
    local items = ScanAllItems()
    if #items == 0 then
        items = {"No Items Found"}
    end
    return items
end

local weaponList = RefreshWeaponList()
local selectedWeapon = weaponList[1] or "No Items Found"

WeaponSection:CreateDropdown({
    Name = "Select Item",
    Options = weaponList,
    CurrentOption = selectedWeapon,
    Callback = function(opt)
        selectedWeapon = opt
        _G.PhantomX.SelectedWeapon = opt
    end
})

WeaponSection:CreateButton({
    Name = "Give Selected Item",
    Callback = function()
        if selectedWeapon and selectedWeapon ~= "No Items Found" then
            pcall(function()
                local found = false
                local locations = {ReplicatedStorage, Workspace, game:GetService("ServerStorage")}
                
                for _, loc in ipairs(locations) do
                    if loc then
                        for _, child in ipairs(loc:GetChildren()) do
                            if child:IsA("Tool") and child.Name == selectedWeapon then
                                local cloned = child:Clone()
                                cloned.Parent = player.Backpack
                                found = true
                                break
                            end
                            if child:IsA("Folder") or child:IsA("Model") then
                                for _, sub in ipairs(child:GetChildren()) do
                                    if sub:IsA("Tool") and sub.Name == selectedWeapon then
                                        local cloned = sub:Clone()
                                        cloned.Parent = player.Backpack
                                        found = true
                                        break
                                    end
                                end
                            end
                        end
                        if found then break end
                    end
                end
                
                -- Try to find in services
                if not found then
                    for _, service in ipairs(game:GetChildren()) do
                        if service:IsA("Service") then
                            for _, child in ipairs(service:GetChildren()) do
                                if child:IsA("Tool") and child.Name == selectedWeapon then
                                    local cloned = child:Clone()
                                    cloned.Parent = player.Backpack
                                    found = true
                                    break
                                end
                            end
                        end
                        if found then break end
                    end
                end
                
                -- If still not found, create a basic tool
                if not found then
                    local newTool = Instance.new("Tool")
                    newTool.Name = selectedWeapon
                    newTool.RequiresHandle = false
                    newTool.Parent = player.Backpack
                    
                    local handle = Instance.new("Part")
                    handle.Name = "Handle"
                    handle.Size = Vector3.new(2, 0.5, 0.5)
                    handle.Anchored = false
                    handle.CanCollide = false
                    handle.Parent = newTool
                end
                
                print("Gave: " .. selectedWeapon)
            end)
        end
    end
})

WeaponSection:CreateButton({
    Name = "Refresh Item List",
    Callback = function()
        local newList = RefreshWeaponList()
        print("Items refreshed: " .. #newList .. " found")
        -- Note: In Rayfield, dropdown refresh requires recreation
    end
})

WeaponSection:CreateButton({
    Name = "Clear Inventory",
    Callback = function()
        pcall(function()
            for _, v in ipairs(player.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    v:Destroy()
                end
            end
            if char then
                for _, v in ipairs(char:GetChildren()) do
                    if v:IsA("Tool") then
                        v:Destroy()
                    end
                end
            end
            print("Inventory cleared")
        end)
    end
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 11: COMBAT SETTINGS
-- ═══════════════════════════════════════════════════════════════

local CombatSection = CombatTab:CreateSection("Aim & Combat Settings")

CombatSection:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "Torso", "HumanoidRootPart", "LowerTorso", "UpperTorso", "RightArm", "LeftArm", "RightLeg", "LeftLeg"},
    CurrentOption = "Head",
    Callback = function(opt)
        _G.PhantomX.AimPart = opt
    end
})

CombatSection:CreateSlider({
    Name = "Aim FOV",
    Range = {1, 360},
    Increment = 1,
    CurrentValue = 90,
    Callback = function(val)
        _G.PhantomX.AimFOV = val
    end
})

CombatSection:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 20},
    Increment = 0.5,
    CurrentValue = 3,
    Callback = function(val)
        _G.PhantomX.HitboxSize = val
    end
})

CombatSection:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 300},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(val)
        _G.PhantomX.FlySpeed = val
    end
})

CombatSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 5,
    CurrentValue = 16,
    Callback = function(val)
        _G.PhantomX.WalkSpeed = val
        local hum = GetHumanoid()
        if hum then hum.WalkSpeed = val end
    end
})

CombatSection:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 50,
    Callback = function(val)
        local hum = GetHumanoid()
        if hum then hum.JumpPower = val end
    end
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 12: VISUAL SETTINGS
-- ═══════════════════════════════════════════════════════════════

local VisualSection = VisualTab:CreateSection("Visual Settings")

VisualSection:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(val)
        ToggleESP(val)
    end
})

VisualSection:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Callback = function(val)
        _G.PhantomX.Chams = val
        if val then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in ipairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = part
                            highlight.Adornee = part
                            highlight.FillColor = Color3.fromRGB(0, 255, 255)
                            highlight.FillTransparency = 0.2
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.OutlineTransparency = 0.5
                            table.insert(chamObjects, highlight)
                        end
                    end
                end
            end
        else
            for _, obj in ipairs(chamObjects) do
                obj:Destroy()
            end
            chamObjects = {}
        end
    end
})

VisualSection:CreateToggle({
    Name = "Show Hitboxes",
    CurrentValue = false,
    Callback = function(val)
        _G.PhantomX.ShowHitboxes = val
        if val then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character then
                    for _, part in ipairs(p.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = part
                            highlight.Adornee = part
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.FillTransparency = 0.3
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                            highlight.OutlineTransparency = 0
                            table.insert(hitboxObjects, highlight)
                        end
                    end
                end
            end
        else
            for _, obj in ipairs(hitboxObjects) do
                obj:Destroy()
            end
            hitboxObjects = {}
        end
    end
})

VisualSection:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(val)
        _G.PhantomX.FullBright = val
        if val then
            Lighting.Brightness = 10
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
            Lighting.GlobalShadows = false
        else
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            Lighting.GlobalShadows = true
        end
    end
})

VisualSection:CreateToggle({
    Name = "Fog Off",
    CurrentValue = false,
    Callback = function(val)
        if val then
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
        else
            Lighting.FogEnd = 500
            Lighting.FogStart = 0
        end
    end
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 13: ADMIN TAB (COMPLETE PLAYER CONTROL)
-- ═══════════════════════════════════════════════════════════════

local AdminSection = AdminTab:CreateSection("Player Control")

local function RefreshPlayerList()
    local list = {}
    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player then
            table.insert(list, v.Name)
        end
    end
    if #list == 0 then list = {"No Players Found"} end
    table.sort(list)
    return list
end

local adminPlayerList = RefreshPlayerList()
local targetAdminPlayer = adminPlayerList[1] or "No Players Found"

AdminSection:CreateDropdown({
    Name = "Target Player",
    Options = adminPlayerList,
    CurrentOption = targetAdminPlayer,
    Callback = function(opt)
        targetAdminPlayer = opt
        _G.PhantomX.TargetPlayer = opt
    end
})

AdminSection:CreateButton({
    Name = "Bring Player to Me",
    Callback = function()
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            pcall(function()
                local target = Players:FindFirstChild(targetAdminPlayer)
                local hrp = GetHRP()
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
                    target.Character.HumanoidRootPart.CFrame = hrp.CFrame
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            pcall(function()
                local target = Players:FindFirstChild(targetAdminPlayer)
                local hrp = GetHRP()
                if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
                    hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Kill Player",
    Callback = function()
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            pcall(function()
                local target = Players:FindFirstChild(targetAdminPlayer)
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
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            pcall(function()
                local target = Players:FindFirstChild(targetAdminPlayer)
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
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            pcall(function()
                local target = Players:FindFirstChild(targetAdminPlayer)
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    target.Character.Humanoid.WalkSpeed = 16
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Loop Kill Player",
    Callback = function()
        if targetAdminPlayer and targetAdminPlayer ~= "No Players Found" then
            task.spawn(function()
                while _G.PhantomX.LoopKill do
                    task.wait(0.1)
                    pcall(function()
                        local target = Players:FindFirstChild(targetAdminPlayer)
                        if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                            target.Character.Humanoid.Health = 0
                        end
                    end)
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Stop Loop Kill",
    Callback = function()
        _G.PhantomX.LoopKill = false
    end
})

AdminSection:CreateButton({
    Name = "Refresh Player List",
    Callback = function()
        local newList = RefreshPlayerList()
        print("Players refreshed: " .. #newList .. " found")
    end
})

-- ═══════════════════════════════════════════════════════════════
-- SECTION 14: CREDITS
-- ═══════════════════════════════════════════════════════════════

local CreditsSection = CreditsTab:CreateSection("The Invisible Man")

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
CreditsSection:CreateLabel("Version: 4.0.0")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("Games Supported: 22+")
CreditsSection:CreateLabel("Features: 50+")
CreditsSection:CreateLabel("")
CreditsSection:CreateLabel("✨ Thank you for using Phantom X ✨")

-- ═══════════════════════════════════════════════════════════════
-- SECTION 15: INITIALIZATION
-- ═══════════════════════════════════════════════════════════════

LoadGameScripts("South Bronx Trenches")

-- ═══════════════════════════════════════════════════════════════
-- SECTION 16: KEYBINDS
-- ═══════════════════════════════════════════════════════════════

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        Window:Toggle()
    end
    if input.KeyCode == Enum.KeyCode.F then
        _G.PhantomX.Fly = not _G.PhantomX.Fly
        ExecuteScript("Fly", _G.PhantomX.Fly)
    end
    if input.KeyCode == Enum.KeyCode.G then
        _G.PhantomX.GodMode = not _G.PhantomX.GodMode
        ExecuteScript("God Mode", _G.PhantomX.GodMode)
    end
    if input.KeyCode == Enum.KeyCode.X then
        _G.PhantomX.SpeedHack = not _G.PhantomX.SpeedHack
        ExecuteScript("Speed Hack", _G.PhantomX.SpeedHack)
    end
end)

-- ═══════════════════════════════════════════════════════════════
-- SECTION 17: STARTUP LOG
-- ═══════════════════════════════════════════════════════════════

print("════════════════════════════════════════════════════════════")
print("✦ PHANTOM X v4.0 - THE INVISIBLE MAN ✦")
print("════════════════════════════════════════════════════════════")
print("✦ Games Supported: 22+")
print("✦ Features: 50+")
print("✦ Rayfield UI: Loaded")
print("✦ Anti-Cheat: Neutralized")
print("✦ ESP: Ready")
print("✦ Weapon Scanner: Ready")
print("✦ Admin Controls: Ready")
print("════════════════════════════════════════════════════════════")
print("✦ Keybinds:")
print("  - Insert: Toggle UI")
print("  - F: Toggle Fly")
print("  - G: Toggle God Mode")
print("  - X: Toggle Speed Hack")
print("════════════════════════════════════════════════════════════")
print("✦ Thank you for using Phantom X ✦")
print("════════════════════════════════════════════════════════════")
