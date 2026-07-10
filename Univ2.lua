```lua
-- ═══════════════════════════════════════════════════════════════
-- PHANTOM X - UNIVERSAL SCRIPT HUB
-- "One Hub. Every Game. Total Domination."
-- ═══════════════════════════════════════════════════════════════
-- Credits: The Invisible Man
-- ═══════════════════════════════════════════════════════════════

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "PHANTOM X",
    LoadingTitle = "PHANTOM X",
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

-- ██████  ANTI-CHEAT OBLITERATOR  ██████

local function ObliterateAntiCheat()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if self == game.Players.LocalPlayer then
            return old(self, unpack(args))
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
    
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local name = v.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("ban") or 
               name:find("exploit") or name:find("hack") or name:find("admin") or name:find("kick") or
               name:find("moderat") or name:find("security") then
                v:Destroy()
            end
        end
    end
    
    local player = game.Players.LocalPlayer
    if player.Kick then player.Kick = function() end end
    for i, v in pairs(player.PlayerScripts:GetChildren()) do
        if v.Name:lower():find("anti") or v.Name:lower():find("moder") then
            v:Destroy()
        end
    end
end

ObliterateAntiCheat()

-- ██████  GAME DETECTION & AUTO-LOAD  ██████

local CurrentGame = ""
local function DetectGame()
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    CurrentGame = gameName
    return gameName
end

DetectGame()

-- ██████  MAIN TABS  ██████

local GameTab = Window:CreateTab("Games")
local CombatTab = Window:CreateTab("Combat")
local UtilityTab = Window:CreateTab("Utility")
local VisualTab = Window:CreateTab("Visuals")
local AdminTab = Window:CreateTab("Admin")
local CreditsTab = Window:CreateTab("Credits")

-- ██████  GAME SELECTION - UNIVERSAL HUB  ██████

local GameSection = GameTab:CreateSection("Select Your Game")

GameSection:CreateParagraph({
    Text = "Current Game: " .. CurrentGame
})

local function GetGameList()
    return {
        "Rivals",
        "Untitled Boxing Game",
        "South Bronx Trenches",
        "OBBY Games",
        "Gun Games",
        "MM2 (Murder Mystery 2)",
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
        "YBA (Your Bizarre Adventure)",
        "Aut (A Universal Time)",
        "Sword Fighters Simulator",
        "Blade Ball",
        "Fruit Battlegrounds",
        "Kaizen",
        "Arcane Odyssey"
    }
end

local GameDropdown = GameSection:CreateDropdown({
    Name = "Select Game",
    Options = GetGameList(),
    CurrentOption = "Select Game",
    Callback = function(Option)
        _G.SelectedGame = Option
        LoadGameScripts(Option)
    end
})

-- ██████  DYNAMIC GAME SCRIPT LOADER  ██████

function LoadGameScripts(gameName)
    -- Clear previous game scripts section
    for i, v in pairs(GameTab:GetChildren()) do
        if v:IsA("Section") and v.Name ~= "Select Your Game" then
            v:Destroy()
        end
    end
    
    local GameScripts = GameTab:CreateSection(gameName:upper() .. " Scripts")
    
    -- Game-specific scripts
    local scripts = {}
    
    if gameName == "Rivals" then
        scripts = {
            "Auto Aim",
            "Speed Hack",
            "Instant Kill",
            "See All Players",
            "Fly",
            "Auto Farm Points",
            "Silent Aim",
            "Anti-Stun"
        }
    elseif gameName == "Untitled Boxing Game" then
        scripts = {
            "Auto Punch",
            "One Punch Kill",
            "Super Speed",
            "Infinite Health",
            "Auto Farm Wins",
            "Perfect Dodge",
            "Instant Cooldown",
            "ESP Players"
        }
    elseif gameName == "South Bronx Trenches" then
        scripts = {
            "Auto Farm Money",
            "Money Dupe",
            "Give All Weapons",
            "Instant Kill",
            "Super Speed",
            "God Mode",
            "Silent Aim",
            "ESP",
            "Fly",
            "Item Dupe",
            "Dupe Held Weapon"
        }
    elseif gameName == "OBBY Games" or gameName:lower():find("obby") then
        scripts = {
            "Auto Jump",
            "Speed",
            "Fly",
            "No Clip",
            "Instant Finish",
            "Auto Reset",
            "Teleport to End"
        }
    elseif gameName == "Gun Games" or gameName:lower():find("gun") then
        scripts = {
            "Auto Aim",
            "Infinite Ammo",
            "One Shot Kill",
            "Speed Hack",
            "Aimbot",
            "ESP",
            "Give All Guns",
            "No Recoil",
            "Silent Aim"
        }
    elseif gameName == "MM2 (Murder Mystery 2)" or gameName:lower():find("mm2") then
        scripts = {
            "Auto Kill",
            "See Murderer",
            "Auto Shoot",
            "Speed",
            "Auto Collect",
            "Aimbot",
            "Ghost Mode",
            "Auto Farm Coins"
        }
    else
        -- Generic universal scripts
        scripts = {
            "Speed Hack",
            "Fly",
            "No Clip",
            "God Mode",
            "ESP",
            "Aimbot",
            "Auto Farm",
            "Instant Kill"
        }
    end
    
    -- Create buttons for each script
    for _, scriptName in ipairs(scripts) do
        GameScripts:CreateToggle({
            Name = scriptName,
            CurrentValue = false,
            Callback = function(Value)
                _G[scriptName:gsub(" ", "_")] = Value
                ExecuteScript(scriptName, Value, gameName)
            end
        })
    end
end

-- ██████  SCRIPT EXECUTION ENGINE  ██████

function ExecuteScript(scriptName, value, gameName)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if scriptName == "Auto Farm Money" or scriptName == "Auto Farm Points" or scriptName == "Auto Farm Wins" or scriptName == "Auto Farm" or scriptName == "Auto Farm Coins" then
        _G.AutoFarm = value
        while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local players = game:GetService("Players"):GetPlayers()
                local target = players[math.random(2, #players)]
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    if hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        task.wait(0.05)
                        for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if remote:IsA("RemoteEvent") and remote.Name:lower():find("kill") or remote.Name:lower():find("damage") or remote.Name:lower():find("attack") then
                                remote:FireServer(target)
                            end
                        end
                    end
                end
            end)
        end
        
    elseif scriptName == "Money Dupe" then
        while task.wait() do
            pcall(function()
                for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("money") or remote.Name:lower():find("cash") or remote.Name:lower():find("bank") then
                        remote:FireServer(999999)
                    end
                end
            end)
        end
        
    elseif scriptName == "Give All Weapons" or scriptName == "Give All Guns" then
        pcall(function()
            for _, v in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("Tool") then
                    local cloned = v:Clone()
                    cloned.Parent = player.Backpack
                end
            end
        end)
        
    elseif scriptName == "Item Dupe" then
        pcall(function()
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                local cloned = tool:Clone()
                cloned.Parent = player.Backpack
            end
        end)
        
    elseif scriptName == "Dupe Held Weapon" then
        pcall(function()
            local weapon = char:FindFirstChildOfClass("Tool")
            if weapon then
                for i = 1, 10 do
                    local cloned = weapon:Clone()
                    cloned.Parent = player.Backpack
                end
            end
        end)
        
    elseif scriptName == "Instant Kill" or scriptName == "One Punch Kill" or scriptName == "One Shot Kill" then
        _G.InstantKill = value
        while _G.InstantKill do
            task.wait(0.1)
            pcall(function()
                for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
                        v.Character.Humanoid.Health = 0
                    end
                end
                for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                    if v:IsA("Humanoid") and v.Parent ~= char then
                        v.Health = 0
                    end
                end
            end)
        end
        
    elseif scriptName == "Speed Hack" or scriptName == "Super Speed" or scriptName == "Speed" then
        _G.SpeedHack = value
        if hum then
            hum.WalkSpeed = value and 200 or 16
            hum.JumpPower = value and 100 or 50
        end
        
    elseif scriptName == "Fly" then
        _G.Fly = value
        if value then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp
            local flying = true
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.Fly then
                    bv:Destroy()
                    flying = false
                    return
                end
                if flying then
                    local speed = _G.FlySpeed or 50
                    local move = Vector3.new()
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                        move = move + hrp.CFrame.LookVector * speed
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                        move = move - hrp.CFrame.LookVector * speed
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                        move = move - hrp.CFrame.RightVector * speed
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                        move = move + hrp.CFrame.RightVector * speed
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                        move = move + Vector3.new(0, speed, 0)
                    end
                    if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then
                        move = move - Vector3.new(0, speed, 0)
                    end
                    bv.Velocity = move
                end
            end)
        end
        
    elseif scriptName == "God Mode" or scriptName == "Infinite Health" then
        _G.GodMode = value
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.GodMode and hum then
                hum.Health = hum.MaxHealth
            end
        end)
        
    elseif scriptName == "No Clip" then
        _G.NoClip = value
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.NoClip and char then
                for _, part in ipairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        
    elseif scriptName == "ESP" or scriptName == "See All Players" or scriptName == "ESP Players" then
        _G.ESP = value
        
    elseif scriptName == "Auto Aim" or scriptName == "Aimbot" then
        _G.Aimbot = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.Aimbot then return end
                pcall(function()
                    local target = nil
                    local shortest = math.huge
                    for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if dist < shortest then
                                shortest = dist
                                target = v
                            end
                        end
                    end
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            local mouse = player:GetMouse()
                            local screenPos = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(aimPart.Position)
                            if screenPos then
                                mouse.Hit = CFrame.new(aimPart.Position)
                            end
                        end
                    end
                end)
            end)
        end
        
    elseif scriptName == "Silent Aim" then
        _G.SilentAim = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.SilentAim then return end
                pcall(function()
                    local target = nil
                    local shortest = math.huge
                    for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                        if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (v.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if dist < shortest then
                                shortest = dist
                                target = v
                            end
                        end
                    end
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            local mouse = player:GetMouse()
                            local screenPos = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(aimPart.Position)
                            if screenPos then
                                mouse.Hit = CFrame.new(aimPart.Position)
                            end
                        end
                    end
                end)
            end)
        end
        
    elseif scriptName == "Auto Shoot" then
        _G.AutoShoot = value
        while _G.AutoShoot do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("shoot") or remote.Name:lower():find("fire") then
                        remote:FireServer()
                    end
                end
            end)
        end
        
    elseif scriptName == "Auto Punch" then
        _G.AutoPunch = value
        while _G.AutoPunch do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("punch") or remote.Name:lower():find("attack") then
                        remote:FireServer()
                    end
                end
            end)
        end
        
    elseif scriptName == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("finish") or v.Name:lower():find("end") then
                    hrp.CFrame = v.CFrame
                end
            end
        end)
        
    elseif scriptName == "Teleport to End" then
        pcall(function()
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("end") or v.Name:lower():find("finish") or v.Name:lower():find("goal") then
                    hrp.CFrame = v.CFrame
                end
            end
        end)
        
    elseif scriptName == "See Murderer" then
        _G.SeeMurderer = value
        -- Would highlight murderer
        
    elseif scriptName == "Ghost Mode" then
        _G.GhostMode = value
        if char then
            char.Transparency = value and 0.5 or 0
        end
        
    elseif scriptName == "Auto Jump" then
        _G.AutoJump = value
        if hum then
            hum.Jump = value
        end
        
    elseif scriptName == "Anti-Stun" then
        _G.AntiStun = value
        if value then
            game:GetService("RunService").RenderStepped:Connect(function()
                if _G.AntiStun and hum then
                    hum.PlatformStand = false
                end
            end)
        end
        
    elseif scriptName == "Perfect Dodge" then
        _G.PerfectDodge = value
        
    elseif scriptName == "Instant Cooldown" then
        _G.InstantCooldown = value
        if value then
            for _, v in ipairs(player.PlayerGui:GetDescendants()) do
                if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                    v.Value = 0
                end
            end
        end
        
    elseif scriptName == "Infinite Ammo" then
        _G.InfiniteAmmo = value
        if value then
            for _, v in ipairs(player.Backpack:GetChildren()) do
                if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                    v.Ammo.Value = 999
                end
            end
        end
        
    elseif scriptName == "No Recoil" then
        _G.NoRecoil = value
        if value then
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("Part") and v.Name:lower():find("recoil") then
                    v:Destroy()
                end
            end
        end
    end
end

-- ██████  COMBAT TAB - UNIVERSAL  ██████

local CombatSection = CombatTab:CreateSection("Combat Settings")

CombatSection:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "Torso", "HumanoidRootPart", "LowerTorso", "UpperTorso", "RightArm", "LeftArm", "RightLeg", "LeftLeg"},
    CurrentOption = "Head",
    Callback = function(Option)
        _G.AimPart = Option
    end
})

CombatSection:CreateSlider({
    Name = "Aim FOV",
    Range = {1, 360},
    Increment = 1,
    Suffix = " degrees",
    CurrentValue = 90,
    Callback = function(Value)
        _G.AimFOV = Value
    end
})

CombatSection:CreateSlider({
    Name = "Fly Speed",
    Range = {1, 200},
    Increment = 1,
    Suffix = " speed",
    CurrentValue = 50,
    Callback = function(Value)
        _G.FlySpeed = Value
    end
})

-- ██████  ADMIN TAB - PLAYER CONTROL  ██████

local AdminSection = AdminTab:CreateSection("Player Control")

local function GetAllPlayers()
    local players = {}
    for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(players, v.Name)
        end
    end
    return players
end

local PlayerDropdown = AdminSection:CreateDropdown({
    Name = "Select Target",
    Options = {"Loading Players..."},
    CurrentOption = "Loading Players...",
    Callback = function(Option)
        _G.TargetPlayer = Option
    end
})

local function RefreshPlayers()
    local players = GetAllPlayers()
    if #players == 0 then
        table.insert(players, "No Players Found")
    end
    table.sort(players)
    Rayfield:UpdateDropdown(PlayerDropdown, players)
end

task.wait(1)
RefreshPlayers()

AdminSection:CreateButton({
    Name = "Bring Player to Me",
    Callback = function()
        if not _G.TargetPlayer or _G.TargetPlayer == "No Players Found" then
            return
        end
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(_G.TargetPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end
        end)
    end
})

AdminSection:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if not _G.TargetPlayer or _G.TargetPlayer == "No Players Found" then
            return
        end
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(_G.TargetPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            end
        end)
    end
})

-- ██████  VISUAL TAB - ESP  ██████

local VisualSection = VisualTab:CreateSection("Visual Settings")

VisualSection:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(Value)
        _G.ESP = Value
    end
})

VisualSection:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Callback = function(Value)
        _G.Chams = Value
        if Value then
            for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    for _, part in ipairs(v.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            local highlight = Instance.new("Highlight")
                            highlight.Parent = part
                            highlight.Adornee = part
                            highlight.FillColor = Color3.fromRGB(255, 0, 0)
                            highlight.FillTransparency = 0.5
                        end
                    end
                end
            end
        end
    end
})

-- ██████  CREDITS  ██████

local CreditsSection = CreditsTab:CreateSection("The Invisible Man")

CreditsSection:CreateParagraph({
    Text = "PHANTOM X\n\nDeveloped by: The Invisible Man\n\nThey said it couldn't be done.\n\nThey were wrong.\n\nAll Rights Reserved"
})

print("PHANTOM X LOADED SUCCESSFULLY")
print("BY THE INVISIBLE MAN")
print("ENJOY THE RIDE")
```
