-- ═══════════════════════════════════════════════════════════════
-- PHANTOM X - UNIVERSAL SCRIPT HUB (HARDENED)
-- "One Hub. Every Game. Total Domination."
-- ═══════════════════════════════════════════════════════════════
-- Credits: The Invisible Man
-- ═══════════════════════════════════════════════════════════════

-- ██████  NUCLEAR ANTI-CHEAT OBLITERATOR  ██████

local function NuclearObliterator()
    -- Get the local player
    local player = game.Players.LocalPlayer
    
    -- Hijack the entire metatable to make detection impossible
    local mt = getrawmetatable(game)
    if mt then
        local old_namecall = mt.__namecall
        local old_index = mt.__index
        local old_newindex = mt.__newindex
        
        setreadonly(mt, false)
        
        -- Intercept ALL function calls and filter out anti-cheat checks
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            -- Block any anti-cheat related methods
            if method and method:lower():find("kick") or method:lower():find("ban") or method:lower():find("detect") then
                return nil
            end
            
            return old_namecall(self, unpack(args))
        end)
        
        -- Block any attempts to read anti-cheat variables
        mt.__index = newcclosure(function(self, key)
            if type(key) == "string" and key:lower():find("anti") or key:lower():find("cheat") or key:lower():find("detect") then
                return nil
            end
            return old_index(self, key)
        end)
        
        -- Block any attempts to write anti-cheat variables
        mt.__newindex = newcclosure(function(self, key, value)
            if type(key) == "string" and key:lower():find("anti") or key:lower():find("cheat") or key:lower():find("detect") then
                return nil
            end
            return old_newindex(self, key, value)
        end)
        
        setreadonly(mt, true)
    end
    
    -- Destroy ALL remote events that could be anti-cheat
    local function nukeRemotes(parent)
        for i, v in pairs(parent:GetChildren()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local name = v.Name:lower()
                local shouldNuke = false
                
                -- Check for anti-cheat keywords
                local keywords = {"anti", "cheat", "detect", "ban", "exploit", "hack", "admin", "kick", "moderat", "security", "mod", "guard", "protect", "verify", "validate", "check", "monitor", "watch", "scan", "audit"}
                
                for _, kw in ipairs(keywords) do
                    if name:find(kw) then
                        shouldNuke = true
                        break
                    end
                end
                
                -- Also check if it's a suspicious remote
                if not shouldNuke and name:len() < 8 and name:match("^[A-Z]+$") then
                    shouldNuke = true
                end
                
                if shouldNuke then
                    v:Destroy()
                end
            end
            
            -- Recursively check children
            if v:IsA("Folder") or v:IsA("Model") or v:IsA("ScreenGui") then
                nukeRemotes(v)
            end
        end
    end
    
    -- Nuke all common locations
    local locations = {
        game,
        game:GetService("ReplicatedStorage"),
        game:GetService("Workspace"),
        game:GetService("ServerStorage"),
        game:GetService("Players"),
        game:GetService("StarterGui"),
        player,
        player.PlayerGui,
        player.PlayerScripts,
        player.Backpack,
        player.Character
    }
    
    for _, loc in ipairs(locations) do
        if loc then
            pcall(nukeRemotes, loc)
        end
    end
    
    -- Disable kick function
    if player.Kick then
        local oldKick = player.Kick
        player.Kick = function(...)
            local args = {...}
            -- Check if the kick is from anti-cheat
            if args[1] and args[1]:lower():find("cheat") or args[1]:lower():find("exploit") or args[1]:lower():find("hack") then
                return nil
            end
            return oldKick(player, unpack(args))
        end
    end
    
    -- Disable teleport function (some games teleport you to a ban room)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local oldCFrame = hrp.CFrame
        hrp:GetPropertyChangedSignal("CFrame"):Connect(function()
            -- Check if teleported to suspicious location
            if hrp.Position.Y < -500 or hrp.Position.Y > 5000 then
                hrp.CFrame = oldCFrame
            end
            if hrp.Position.X > 5000 or hrp.Position.X < -5000 then
                hrp.CFrame = oldCFrame
            end
            if hrp.Position.Z > 5000 or hrp.Position.Z < -5000 then
                hrp.CFrame = oldCFrame
            end
            oldCFrame = hrp.CFrame
        end)
    end
    
    -- Disable any anti-cheat GUI that appears
    for i, v in pairs(player.PlayerGui:GetChildren()) do
        if v:IsA("ScreenGui") then
            local name = v.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("ban") or name:find("kick") then
                v:Destroy()
            end
        end
    end
    
    -- Block anti-cheat scripts from running
    for i, script in pairs(game:GetDescendants()) do
        if script:IsA("Script") or script:IsA("LocalScript") or script:IsA("ModuleScript") then
            local name = script.Name:lower()
            if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("moder") or name:find("security") then
                script:Destroy()
            end
        end
    end
    
    -- Disable all character checks
    if player.Character then
        for i, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("detect") then
                    v:Destroy()
                end
            end
        end
    end
    
    -- Hook the print function to block anti-cheat messages
    local oldPrint = print
    print = function(...)
        local args = {...}
        local message = table.concat(args, " ")
        if message and message:lower():find("cheat") or message:lower():find("hack") or message:lower():find("exploit") then
            return nil
        end
        return oldPrint(unpack(args))
    end
    
    -- Hook warn function
    local oldWarn = warn
    warn = function(...)
        local args = {...}
        local message = table.concat(args, " ")
        if message and message:lower():find("cheat") or message:lower():find("hack") or message:lower():find("exploit") then
            return nil
        end
        return oldWarn(unpack(args))
    end
    
    -- Hook error function
    local oldError = error
    error = function(...)
        local args = {...}
        local message = table.concat(args, " ")
        if message and message:lower():find("cheat") or message:lower():find("hack") or message:lower():find("exploit") then
            return nil
        end
        return oldError(unpack(args))
    end
    
    -- Disable all game specific anti-cheat variables
    for i, v in pairs(getfenv()) do
        if type(v) == "table" then
            for key, _ in pairs(v) do
                if type(key) == "string" and key:lower():find("anti") or key:lower():find("cheat") or key:lower():find("detect") then
                    v[key] = nil
                end
            end
        end
    end
    
    print("[Phantom X] Anti-Cheat System Completely Neutralized")
end

-- Execute the nuclear obliterator
pcall(NuclearObliterator)

-- ██████  CONTINUOUS ANTI-CHEAT DEFENSE  ██████

-- Monitor for new anti-cheat instances
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        local player = game.Players.LocalPlayer
        
        -- Check for new anti-cheat scripts
        for i, v in pairs(game:GetDescendants()) do
            if v:IsA("Script") or v:IsA("LocalScript") or v:IsA("ModuleScript") then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("moder") or name:find("security") then
                    v:Destroy()
                end
            end
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("moder") or name:find("security") then
                    v:Destroy()
                end
            end
            if v:IsA("ScreenGui") and v.Parent == player.PlayerGui then
                local name = v.Name:lower()
                if name:find("anti") or name:find("cheat") or name:find("detect") or name:find("ban") then
                    v:Destroy()
                end
            end
        end
        
        -- Check for suspicious teleportation
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if hrp.Position.Y < -1000 or hrp.Position.Y > 2000 then
                hrp.CFrame = CFrame.new(0, 100, 0)
            end
        end
    end)
end)

-- ██████  GAME DETECTION  ██████

local CurrentGame = ""
pcall(function()
    CurrentGame = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
end)

-- ██████  CREATE UI  ██████

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "PhantomX"

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 25)
MainFrame.BackgroundTransparency = 0
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 8)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
TitleBar.BackgroundTransparency = 0
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.Parent = TitleBar
TitleCorner.CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "PHANTOM X"
TitleLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Position = UDim2.new(0, 15, 0, 0)

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.Size = UDim2.new(1, 0, 0, 35)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
TabBar.BackgroundTransparency = 0
TabBar.BorderSizePixel = 0

local function CreateTabButton(name, position)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.Size = UDim2.new(0, 70, 1, 0)
    btn.Position = UDim2.new(0, position, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    return btn
end

local Tabs = {}
local CurrentTab = "Games"

local function SwitchTab(tabName)
    CurrentTab = tabName
    for i, v in pairs(Tabs) do
        v.Visible = (i == tabName)
    end
end

-- Tab Containers
local TabContainer = Instance.new("Frame")
TabContainer.Parent = MainFrame
TabContainer.Size = UDim2.new(1, 0, 1, -75)
TabContainer.Position = UDim2.new(0, 0, 0, 75)
TabContainer.BackgroundTransparency = 1

local function CreateTabContainer(name)
    local frame = Instance.new("ScrollingFrame")
    frame.Parent = TabContainer
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
    frame.Visible = false
    Tabs[name] = frame
    return frame
end

-- Create tabs
local GameTab = CreateTabContainer("Games")
local CombatTab = CreateTabContainer("Combat")
local UtilityTab = CreateTabContainer("Utility")
local VisualTab = CreateTabContainer("Visuals")
local AdminTab = CreateTabContainer("Admin")
local CreditsTab = CreateTabContainer("Credits")

-- Tab buttons
local function CreateTabButtons()
    local tabNames = {"Games", "Combat", "Utility", "Visuals", "Admin", "Credits"}
    local xPos = 10
    for _, name in ipairs(tabNames) do
        local btn = CreateTabButton(name, xPos)
        btn.MouseButton1Click:Connect(function()
            SwitchTab(name)
        end)
        xPos = xPos + 75
    end
end
CreateTabButtons()

-- ██████  UI HELPER FUNCTIONS  ██████

local function CreateSection(parent, title)
    local section = Instance.new("Frame")
    section.Parent = parent
    section.Size = UDim2.new(1, -20, 0, 30)
    section.Position = UDim2.new(0, 10, 0, 5)
    section.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = section
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(100, 150, 255)
    label.TextSize = 16
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    return section
end

local function CreateButton(parent, text, callback, yOffset)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(0, 200, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yOffset or 40)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = text
    btn.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.Parent = btn
    corner.CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function CreateToggle(parent, text, callback, yOffset)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(0, 200, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, yOffset or 40)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 150, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 14
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = frame
    toggle.Size = UDim2.new(0, 40, 0, 25)
    toggle.Position = UDim2.new(0, 160, 0, 2.5)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(200, 200, 220)
    toggle.TextSize = 12
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.Parent = toggle
    corner.CornerRadius = UDim.new(0, 4)
    
    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "ON" or "OFF"
        toggle.BackgroundColor3 = state and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(40, 40, 70)
        callback(state)
    end)
    
    return frame
end

local function CreateDropdown(parent, text, options, callback, yOffset)
    local frame = Instance.new("Frame")
    frame.Parent = parent
    frame.Size = UDim2.new(0, 200, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, yOffset or 40)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 80, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 14
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local dropdown = Instance.new("TextButton")
    dropdown.Parent = frame
    dropdown.Size = UDim2.new(0, 110, 0, 25)
    dropdown.Position = UDim2.new(0, 90, 0, 2.5)
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    dropdown.Text = options[1] or "Select"
    dropdown.TextColor3 = Color3.fromRGB(200, 200, 220)
    dropdown.TextSize = 12
    dropdown.Font = Enum.Font.GothamSemibold
    dropdown.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.Parent = dropdown
    corner.CornerRadius = UDim.new(0, 4)
    
    local selected = options[1] or ""
    dropdown.MouseButton1Click:Connect(function()
        -- Simple cycle through options
        local idx = 1
        for i, v in ipairs(options) do
            if v == selected then
                idx = i + 1
                if idx > #options then idx = 1 end
                break
            end
        end
        selected = options[idx]
        dropdown.Text = selected
        callback(selected)
    end)
    
    return frame
end

-- ██████  GAME SELECTION  ██████

local GameSection = CreateSection(GameTab, "Select Your Game - " .. CurrentGame)

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

local gameList = GetGameList()
local selectedGame = gameList[1]

local GameDropdown = CreateDropdown(GameTab, "Game:", gameList, function(option)
    selectedGame = option
    LoadGameScripts(option)
end, 40)

-- ██████  DYNAMIC GAME SCRIPT LOADER  ██████

local scriptYOffset = 80
local scriptButtons = {}

function LoadGameScripts(gameName)
    -- Clear previous scripts
    for i, v in pairs(scriptButtons) do
        v:Destroy()
    end
    scriptButtons = {}
    scriptYOffset = 80
    
    local scripts = {}
    
    if gameName == "Rivals" then
        scripts = {"Auto Aim", "Speed Hack", "Instant Kill", "See All Players", "Fly", "Auto Farm Points", "Silent Aim", "Anti-Stun"}
    elseif gameName == "Untitled Boxing Game" then
        scripts = {"Auto Punch", "One Punch Kill", "Super Speed", "Infinite Health", "Auto Farm Wins", "Perfect Dodge", "Instant Cooldown", "ESP Players"}
    elseif gameName == "South Bronx Trenches" then
        scripts = {"Auto Farm Money", "Money Dupe", "Give All Weapons", "Instant Kill", "Super Speed", "God Mode", "Silent Aim", "ESP", "Fly", "Item Dupe", "Dupe Held Weapon"}
    elseif gameName == "OBBY Games" or gameName:lower():find("obby") then
        scripts = {"Auto Jump", "Speed", "Fly", "No Clip", "Instant Finish", "Auto Reset", "Teleport to End"}
    elseif gameName == "Gun Games" or gameName:lower():find("gun") then
        scripts = {"Auto Aim", "Infinite Ammo", "One Shot Kill", "Speed Hack", "Aimbot", "ESP", "Give All Guns", "No Recoil", "Silent Aim"}
    elseif gameName == "MM2" or gameName:lower():find("mm2") then
        scripts = {"Auto Kill", "See Murderer", "Auto Shoot", "Speed", "Auto Collect", "Aimbot", "Ghost Mode", "Auto Farm Coins"}
    else
        scripts = {"Speed Hack", "Fly", "No Clip", "God Mode", "ESP", "Aimbot", "Auto Farm", "Instant Kill"}
    end
    
    for _, scriptName in ipairs(scripts) do
        local btn = CreateToggle(GameTab, scriptName, function(value)
            _G[scriptName:gsub(" ", "_")] = value
            ExecuteScript(scriptName, value)
        end, scriptYOffset)
        table.insert(scriptButtons, btn)
        scriptYOffset = scriptYOffset + 40
    end
    
    -- Update canvas size
    GameTab.CanvasSize = UDim2.new(0, 0, 0, scriptYOffset + 20)
end

-- ██████  SCRIPT EXECUTION ENGINE  ██████

function ExecuteScript(scriptName, value)
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
                            if remote:IsA("RemoteEvent") and (remote.Name:lower():find("kill") or remote.Name:lower():find("damage") or remote.Name:lower():find("attack")) then
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
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("money") or remote.Name:lower():find("cash") or remote.Name:lower():find("bank")) then
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
        
    elseif scriptName == "Auto Shoot" then        _G.AutoShoot = value
        while _G.AutoShoot do
            task.wait(0.1)
            pcall(function()
                for _, remote in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("shoot") or remote.Name:lower():find("fire")) then
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
                    if remote:IsA("RemoteEvent") and (remote.Name:lower():find("punch") or remote.Name:lower():find("attack")) then
                        remote:FireServer()
                    end
                end
            end)
        end
        
    elseif scriptName == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("finish") or v.Name:lower():find("end")) then
                    hrp.CFrame = v.CFrame
                end
            end
        end)
        
    elseif scriptName == "Teleport to End" then
        pcall(function()
            for _, v in ipairs(game:GetService("Workspace"):GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:lower():find("end") or v.Name:lower():find("finish") or v.Name:lower():find("goal")) then
                    hrp.CFrame = v.CFrame
                end
            end
        end)
        
    elseif scriptName == "See Murderer" then
        _G.SeeMurderer = value
        
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

-- ██████  COMBAT SETTINGS  ██████

local CombatSection = CreateSection(CombatTab, "Combat Settings")

local aimPartOptions = {"Head", "Torso", "HumanoidRootPart", "LowerTorso", "UpperTorso", "RightArm", "LeftArm", "RightLeg", "LeftLeg"}
CreateDropdown(CombatTab, "Aim Part:", aimPartOptions, function(option)
    _G.AimPart = option
end, 40)

CombatTab.CanvasSize = UDim2.new(0, 0, 0, 150)

-- ██████  ADMIN - PLAYER CONTROL  ██████

local AdminSection = CreateSection(AdminTab, "Player Control")

local function GetAllPlayers()
    local players = {}
    for _, v in ipairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(players, v.Name)
        end
    end
    return players
end

local playerList = GetAllPlayers()
if #playerList == 0 then table.insert(playerList, "No Players") end
local targetPlayer = playerList[1]

CreateDropdown(AdminTab, "Target:", playerList, function(option)
    targetPlayer = option
end, 40)

CreateButton(AdminTab, "Bring Player to Me", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(targetPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end
        end)
    end
end, 80)

CreateButton(AdminTab, "Teleport to Player", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game:GetService("Players"):FindFirstChild(targetPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                end
            end
        end)
    end
end, 120)

AdminTab.CanvasSize = UDim2.new(0, 0, 0, 200)

-- ██████  VISUAL SETTINGS  ██████

local VisualSection = CreateSection(VisualTab, "Visual Settings")

CreateToggle(VisualTab, "ESP", function(value)
    _G.ESP = value
end, 40)

CreateToggle(VisualTab, "Chams", function(value)
    _G.Chams = value
    if value then
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
end, 80)

VisualTab.CanvasSize = UDim2.new(0, 0, 0, 160)

-- ██████  CREDITS  ██████

local CreditsSection = CreateSection(CreditsTab, "The Invisible Man")

local creditLabels = {
    "PHANTOM X",
    "",
    "Developed by: The Invisible Man",
    "",
    "They said it couldn't be done.",
    "They were wrong.",
    "",
    "All Rights Reserved"
}

local yPos = 40
for _, text in ipairs(creditLabels) do
    local label = Instance.new("TextLabel")
    label.Parent = CreditsTab
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = text == "" and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 200)
    label.TextSize = text == "PHANTOM X" and 24 or 14
    label.Font = text == "PHANTOM X" and Enum.Font.GothamBold or Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    yPos = yPos + 30
end

CreditsTab.CanvasSize = UDim2.new(0, 0, 0, yPos + 20)

-- ██████  INITIALIZE  ██████

SwitchTab("Games")
LoadGameScripts(gameList[1])

print("PHANTOM X LOADED SUCCESSFULLY")
print("BY THE INVISIBLE MAN")
print("ANTI-CHEAT: NEUTRALIZED")
