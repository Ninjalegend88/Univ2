-- ═══════════════════════════════════════════════════════════════
-- PHANTOM X - UNIVERSAL SCRIPT HUB
-- "One Hub. Every Game. Total Domination."
-- ═══════════════════════════════════════════════════════════════
-- Credits: The Invisible Man
-- ═══════════════════════════════════════════════════════════════

-- ██████  ANTI-CHEAT BYPASS (LIGHTWEIGHT)  ██████

local function BypassAntiCheat()
    -- Hijack kick function
    local player = game.Players.LocalPlayer
    if player.Kick then
        player.Kick = function() end
    end
    
    -- Remove common anti-cheat remotes
    for i, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            local name = v.Name:lower()
            local keywords = {"anti", "cheat", "detect", "ban", "kick", "moderat", "security"}
            for _, kw in ipairs(keywords) do
                if name:find(kw) then
                    v:Destroy()
                    break
                end
            end
        end
    end
end

pcall(BypassAntiCheat)

-- ██████  SIRIUS UI  ██████

local Sirius = loadstring(game:HttpGet('https://raw.githubusercontent.com/Sirius-Scripting/Sirius/main/source'))()

local Window = Sirius:CreateWindow({
    Name = "PHANTOM X",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 600, 0, 450),
    Theme = "Dark",
    Transparency = 0
})

-- ██████  GAME DETECTION  ██████

local CurrentGame = ""
pcall(function()
    CurrentGame = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

-- ██████  TABS  ██████

local GameTab = Window:CreateTab("Games")
local CombatTab = Window:CreateTab("Combat")
local UtilityTab = Window:CreateTab("Utility")
local VisualTab = Window:CreateTab("Visuals")
local AdminTab = Window:CreateTab("Admin")
local CreditsTab = Window:CreateTab("Credits")

-- ██████  GAME SELECTION  ██████

local GameSection = GameTab:CreateSection("Select Your Game")
GameSection:CreateLabel("Current Game: " .. CurrentGame)

local function GetGameList()
    return {
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
end

local selectedGame = "Select Game"
local GameDropdown = GameSection:CreateDropdown({
    Name = "Select Game",
    Options = GetGameList(),
    Default = "Select Game",
    Callback = function(Option)
        selectedGame = Option
        LoadGameScripts(Option)
    end
})

-- ██████  DYNAMIC GAME SCRIPT LOADER  ██████

local scriptSection = nil

function LoadGameScripts(gameName)
    if scriptSection then
        scriptSection:Destroy()
    end
    
    scriptSection = GameTab:CreateSection(gameName:upper() .. " Scripts")
    
    local scripts = {}
    
    if gameName == "Rivals" then
        scripts = {"Auto Aim", "Speed Hack", "Instant Kill", "Fly", "Auto Farm Points", "Silent Aim"}
    elseif gameName == "Untitled Boxing Game" then
        scripts = {"Auto Punch", "One Punch Kill", "Super Speed", "Infinite Health", "Auto Farm Wins"}
    elseif gameName == "South Bronx Trenches" then
        scripts = {"Auto Farm Money", "Money Dupe", "Give All Weapons", "Instant Kill", "Super Speed", "God Mode", "Silent Aim", "ESP", "Fly", "Item Dupe", "Dupe Held Weapon"}
    elseif gameName == "OBBY Games" or gameName:lower():find("obby") then
        scripts = {"Auto Jump", "Speed", "Fly", "No Clip", "Instant Finish"}
    elseif gameName == "Gun Games" or gameName:lower():find("gun") then
        scripts = {"Auto Aim", "Infinite Ammo", "One Shot Kill", "Aimbot", "ESP", "No Recoil"}
    elseif gameName == "MM2" or gameName:lower():find("mm2") then
        scripts = {"Auto Kill", "See Murderer", "Auto Shoot", "Speed", "Aimbot", "Ghost Mode"}
    else
        scripts = {"Speed Hack", "Fly", "No Clip", "God Mode", "ESP", "Aimbot", "Auto Farm", "Instant Kill"}
    end
    
    for _, scriptName in ipairs(scripts) do
        scriptSection:CreateToggle({
            Name = scriptName,
            Default = false,
            Callback = function(Value)
                _G[scriptName:gsub(" ", "_")] = Value
                ExecuteScript(scriptName, Value)
            end
        })
    end
end

-- ██████  SCRIPT EXECUTION ENGINE  ██████

function ExecuteScript(scriptName, value)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if scriptName == "Auto Farm Money" or scriptName == "Auto Farm Points" or scriptName == "Auto Farm Wins" or scriptName == "Auto Farm" then
        _G.AutoFarm = value
        while _G.AutoFarm do
            task.wait(0.1)
            pcall(function()
                local players = game:GetService("Players"):GetPlayers()
                local target = players[math.random(2, #players)]
                if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                    if hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                        for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                            if remote:IsA("RemoteEvent") and remote.Name:lower():find("kill") then
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
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("money") then
                        remote:FireServer(999999)
                    end
                end
            end)
        end
        
    elseif scriptName == "Give All Weapons" then
        pcall(function()
            for _, v in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if v:IsA("Tool") then
                    v:Clone().Parent = player.Backpack
                end
            end
        end)
        
    elseif scriptName == "Item Dupe" then
        pcall(function()
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                tool:Clone().Parent = player.Backpack
            end
        end)
        
    elseif scriptName == "Dupe Held Weapon" then
        pcall(function()
            local weapon = char:FindFirstChildOfClass("Tool")
            if weapon then
                for i = 1, 10 do
                    weapon:Clone().Parent = player.Backpack
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
            end)
        end
        
    elseif scriptName == "Speed Hack" or scriptName == "Super Speed" or scriptName == "Speed" then
        if hum then
            hum.WalkSpeed = value and 200 or 16
            hum.JumpPower = value and 100 or 50
        end
        
    elseif scriptName == "Fly" then
        _G.Fly = value
        if value and hrp then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = hrp
            game:GetService("RunService").RenderStepped:Connect(function()
                if not _G.Fly then bv:Destroy() return end
                local speed = 50
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
        
    elseif scriptName == "ESP" then
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
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end)
        end
        
    elseif scriptName == "Silent Aim" then
        _G.SilentAim = value
        
    elseif scriptName == "Auto Shoot" then
        _G.AutoShoot = value
        while _G.AutoShoot do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("shoot") then
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
                    if remote:IsA("RemoteEvent") and remote.Name:lower():find("punch") then
                        remote:FireServer()
                    end
                end
            end)
        end
        
    elseif scriptName == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("finish") then
                    hrp.CFrame = v.CFrame
                end
            end
        end)
        
    elseif scriptName == "See Murderer" then
        _G.SeeMurderer = value
        
    elseif scriptName == "Ghost Mode" then
        if char then
            char.Transparency = value and 0.5 or 0
        end
        
    elseif scriptName == "Auto Jump" then
        if hum then
            hum.Jump = value
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

-- ██████  COMBAT SETTINGS  ██████

local CombatSection = CombatTab:CreateSection("Combat Settings")

CombatSection:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(Option)
        _G.AimPart = Option
    end
})

-- ██████  ADMIN - PLAYER CONTROL  ██████

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
    Options = GetAllPlayers(),
    Default = "Select Player",
    Callback = function(Option)
        _G.TargetPlayer = Option
    end
})

AdminSection:CreateButton({
    Name = "Bring Player to Me",
    Callback = function()
        if not _G.TargetPlayer then return end
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(_G.TargetPlayer)
            if target and target.Character then
                target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            end
        end)
    end
})

AdminSection:CreateButton({
    Name = "Teleport to Player",
    Callback = function()
        if not _G.TargetPlayer then return end
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(_G.TargetPlayer)
            if target and target.Character then
                player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end)
    end
})

-- ██████  VISUAL SETTINGS  ██████

local VisualSection = VisualTab:CreateSection("Visual Settings")

VisualSection:CreateToggle({
    Name = "ESP",
    Default = false,
    Callback = function(Value)
        _G.ESP = Value
    end
})

-- ██████  CREDITS  ██████

local CreditsSection = CreditsTab:CreateSection("The Invisible Man")

CreditsSection:CreateLabel("PHANTOM X")
CreditsSection:CreateLabel("Developed by: The Invisible Man")
CreditsSection:CreateLabel("They said it couldn't be done.")
CreditsSection:CreateLabel("They were wrong.")

-- ██████  INITIALIZE  ██████

LoadGameScripts(GetGameList()[1])

print("PHANTOM X LOADED SUCCESSFULLY")
print("BY THE INVISIBLE MAN")
