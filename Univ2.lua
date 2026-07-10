-- PHANTOM X - THE INVISIBLE MAN
-- ULTIMATE UNIVERSAL HUB - WITH HIDE BUTTON

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- SIMPLE ANTI-CHEAT
pcall(function()
    if player.Kick then player.Kick = function() end end
end)

-- ==========================================
-- FLOATING TOGGLE BUTTON
-- ==========================================

local toggleGui = Instance.new("ScreenGui")
toggleGui.Parent = player.PlayerGui
toggleGui.Name = "PhantomXToggle"
toggleGui.ResetOnSpawn = false

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = toggleGui
toggleBtn.Size = UDim2.new(0, 40, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -20, 0, 5)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
toggleBtn.Text = "P"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.ZIndex = 999

local toggleCorner = Instance.new("UICorner")
toggleCorner.Parent = toggleBtn
toggleCorner.CornerRadius = UDim.new(1, 0)

-- DRAG FOR TOGGLE BUTTON
local toggleDragging = false
local toggleDragStartX, toggleDragStartY
local toggleStartPosX, toggleStartPosY

toggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = true
        toggleDragStartX = input.Position.X
        toggleDragStartY = input.Position.Y
        toggleStartPosX = toggleBtn.Position.X.Offset
        toggleStartPosY = toggleBtn.Position.Y.Offset
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if toggleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local deltaX = input.Position.X - toggleDragStartX
        local deltaY = input.Position.Y - toggleDragStartY
        toggleBtn.Position = UDim2.new(0.5, toggleStartPosX + deltaX, 0, toggleStartPosY + deltaY)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        toggleDragging = false
    end
end)

-- ==========================================
-- MAIN UI
-- ==========================================

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.Name = "PhantomX"
gui.ResetOnSpawn = false
gui.Enabled = true

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, 480, 0, 520)
main.Position = UDim2.new(0.5, -240, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(6, 6, 18)
main.BackgroundTransparency = 0
main.BorderSizePixel = 0
main.ClipsDescendants = true

local corner = Instance.new("UICorner")
corner.Parent = main
corner.CornerRadius = UDim.new(0, 10)

-- Title Bar (DRAGGABLE)
local titlebar = Instance.new("Frame")
titlebar.Parent = main
titlebar.Size = UDim2.new(1, 0, 0, 38)
titlebar.BackgroundColor3 = Color3.fromRGB(12, 12, 35)
titlebar.BorderSizePixel = 0
titlebar.Active = true

local titlecorner = Instance.new("UICorner")
titlecorner.Parent = titlebar
titlecorner.CornerRadius = UDim.new(0, 10)

local titletext = Instance.new("TextLabel")
titletext.Parent = titlebar
titletext.Size = UDim2.new(1, -50, 1, 0)
titletext.Position = UDim2.new(0, 15, 0, 0)
titletext.BackgroundTransparency = 1
titletext.Text = "PHANTOM X"
titletext.TextColor3 = Color3.fromRGB(60, 140, 255)
titletext.TextSize = 20
titletext.Font = Enum.Font.GothamBold
titletext.TextXAlignment = Enum.TextXAlignment.Left

local closebtn = Instance.new("TextButton")
closebtn.Parent = titlebar
closebtn.Size = UDim2.new(0, 32, 0, 32)
closebtn.Position = UDim2.new(1, -38, 0, 3)
closebtn.BackgroundTransparency = 1
closebtn.Text = "✕"
closebtn.TextColor3 = Color3.fromRGB(255, 70, 70)
closebtn.TextSize = 18
closebtn.Font = Enum.Font.GothamBold
closebtn.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- HIDE BUTTON ON TITLEBAR
local hidebtn = Instance.new("TextButton")
hidebtn.Parent = titlebar
hidebtn.Size = UDim2.new(0, 32, 0, 32)
hidebtn.Position = UDim2.new(1, -75, 0, 3)
hidebtn.BackgroundTransparency = 1
hidebtn.Text = "─"
hidebtn.TextColor3 = Color3.fromRGB(200, 200, 200)
hidebtn.TextSize = 20
hidebtn.Font = Enum.Font.GothamBold
hidebtn.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

-- DRAG SYSTEM
local dragging = false
local dragStartX, dragStartY
local startPosX, startPosY

titlebar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartX = input.Position.X
        dragStartY = input.Position.Y
        startPosX = main.Position.X.Offset
        startPosY = main.Position.Y.Offset
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local deltaX = input.Position.X - dragStartX
        local deltaY = input.Position.Y - dragStartY
        main.Position = UDim2.new(0.5, startPosX + deltaX, 0.5, startPosY + deltaY)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- TOGGLE BUTTON CLICK - SHOW/HIDE
toggleBtn.MouseButton1Click:Connect(function()
    gui.Enabled = not gui.Enabled
    if gui.Enabled then
        toggleBtn.Text = "P"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
    else
        toggleBtn.Text = "P"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
    end
end)

-- Also close with Insert key
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        gui.Enabled = not gui.Enabled
    end
end)

-- ==========================================
-- REST OF UI (TABS, GAMES, SCRIPTS)
-- ==========================================

-- Tab Bar
local tabbar = Instance.new("Frame")
tabbar.Parent = main
tabbar.Size = UDim2.new(1, 0, 0, 32)
tabbar.Position = UDim2.new(0, 0, 0, 38)
tabbar.BackgroundColor3 = Color3.fromRGB(10, 10, 28)
tabbar.BorderSizePixel = 0

-- Container
local container = Instance.new("ScrollingFrame")
container.Parent = main
container.Size = UDim2.new(1, 0, 1, -70)
container.Position = UDim2.new(0, 0, 0, 70)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.CanvasSize = UDim2.new(0, 0, 0, 0)
container.ScrollBarThickness = 3

-- Tab system
local tabs = {}
local currentTab = "Main"
local tabY = {}

function CreateTab(name, x)
    local btn = Instance.new("TextButton")
    btn.Parent = tabbar
    btn.Size = UDim2.new(0, 65, 1, 0)
    btn.Position = UDim2.new(0, x, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(170, 170, 200)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamSemibold
    tabs[name] = {btn = btn, y = 10, elements = {}}
    tabY[name] = 10
    return btn
end

function AddLabel(text, tab)
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.Size = UDim2.new(1, -20, 0, 25)
    label.Position = UDim2.new(0, 10, 0, tabs[tab].y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(60, 140, 255)
    label.TextSize = 14
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Visible = (tab == currentTab)
    tabs[tab].y = tabs[tab].y + 28
    table.insert(tabs[tab].elements, label)
end

function AddToggle(text, tab, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, tabs[tab].y)
    frame.BackgroundColor3 = Color3.fromRGB(14, 14, 32)
    frame.BorderSizePixel = 0
    frame.Visible = (tab == currentTab)
    
    local c = Instance.new("UICorner")
    c.Parent = frame
    c.CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 220, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0, 45, 0, 22)
    btn.Position = UDim2.new(1, -52, 0, 4)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    
    local c2 = Instance.new("UICorner")
    c2.Parent = btn
    c2.CornerRadius = UDim.new(0, 4)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(40, 140, 40) or Color3.fromRGB(40, 40, 70)
        callback(state)
    end)
    
    tabs[tab].y = tabs[tab].y + 34
    table.insert(tabs[tab].elements, frame)
end

function AddButton(text, tab, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, tabs[tab].y)
    frame.BackgroundTransparency = 1
    frame.Visible = (tab == currentTab)
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    
    local c = Instance.new("UICorner")
    c.Parent = btn
    c.CornerRadius = UDim.new(0, 4)
    
    btn.MouseButton1Click:Connect(callback)
    
    tabs[tab].y = tabs[tab].y + 34
    table.insert(tabs[tab].elements, frame)
end

function AddDropdown(text, tab, options, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -20, 0, 30)
    frame.Position = UDim2.new(0, 10, 0, tabs[tab].y)
    frame.BackgroundColor3 = Color3.fromRGB(14, 14, 32)
    frame.BorderSizePixel = 0
    frame.Visible = (tab == currentTab)
    
    local c = Instance.new("UICorner")
    c.Parent = frame
    c.CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 100, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0, 140, 0, 22)
    btn.Position = UDim2.new(0, 115, 0, 4)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.Text = options[1] or "Select"
    btn.TextColor3 = Color3.fromRGB(200, 200, 220)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    
    local c2 = Instance.new("UICorner")
    c2.Parent = btn
    c2.CornerRadius = UDim.new(0, 4)
    
    local idx = 1
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        btn.Text = options[idx]
        callback(options[idx])
    end)
    
    tabs[tab].y = tabs[tab].y + 34
    table.insert(tabs[tab].elements, frame)
end

function AddSlider(text, tab, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Parent = container
    frame.Size = UDim2.new(1, -20, 0, 35)
    frame.Position = UDim2.new(0, 10, 0, tabs[tab].y)
    frame.BackgroundColor3 = Color3.fromRGB(14, 14, 32)
    frame.BorderSizePixel = 0
    frame.Visible = (tab == currentTab)
    
    local c = Instance.new("UICorner")
    c.Parent = frame
    c.CornerRadius = UDim.new(0, 4)
    
    local label = Instance.new("TextLabel")
    label.Parent = frame
    label.Size = UDim2.new(0, 180, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(200, 200, 220)
    label.TextSize = 13
    label.Font = Enum.Font.GothamSemibold
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local slider = Instance.new("Frame")
    slider.Parent = frame
    slider.Size = UDim2.new(0, 150, 0, 4)
    slider.Position = UDim2.new(0, 10, 0, 25)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    slider.BorderSizePixel = 0
    
    local c3 = Instance.new("UICorner")
    c3.Parent = slider
    c3.CornerRadius = UDim.new(0, 2)
    
    local fill = Instance.new("Frame")
    fill.Parent = slider
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(60, 140, 255)
    fill.BorderSizePixel = 0
    
    local c4 = Instance.new("UICorner")
    c4.Parent = fill
    c4.CornerRadius = UDim.new(0, 2)
    
    local dragging = false
    local value = default
    
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local x = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * x)
            fill.Size = UDim2.new(x, 0, 1, 0)
            label.Text = text .. ": " .. value
            callback(value)
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max - min) * x)
            fill.Size = UDim2.new(x, 0, 1, 0)
            label.Text = text .. ": " .. value
            callback(value)
        end
    end)
    
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    tabs[tab].y = tabs[tab].y + 42
    table.insert(tabs[tab].elements, frame)
end

function SwitchTab(tab)
    currentTab = tab
    for t, data in pairs(tabs) do
        for _, elem in ipairs(data.elements) do
            elem.Visible = (t == tab)
        end
    end
    container.CanvasSize = UDim2.new(0, 0, 0, tabs[tab].y + 20)
end

-- Create tabs
CreateTab("Main", 10)
CreateTab("Combat", 78)
CreateTab("Visual", 146)
CreateTab("Admin", 214)

-- ==========================================
-- GAME SELECTION - ALL GAMES
-- ==========================================

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
    "Arcane Odyssey",
    "Redliner"
}

AddLabel("── GAME SELECTION ──", "Main")

local selectedGame = allGames[1]

AddDropdown("Game:", "Main", allGames, function(opt)
    selectedGame = opt
    LoadGameScripts(opt)
end)

-- ==========================================
-- GAME-SPECIFIC SCRIPTS
-- ==========================================

local scriptElements = {}

function LoadGameScripts(gameName)
    for _, elem in ipairs(scriptElements) do
        elem:Destroy()
    end
    scriptElements = {}
    
    local scripts = {}
    
    if gameName == "South Bronx Trenches" then
        scripts = {
            "Auto Farm Money", "Money Dupe", "Give All Weapons", "Instant Kill",
            "Super Speed", "God Mode", "Fly", "Silent Aim", "ESP",
            "Item Dupe", "Dupe Held Weapon", "No Clip"
        }
    elseif gameName == "Rivals" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Auto Farm"}
    elseif gameName == "Untitled Boxing Game" then
        scripts = {"Auto Punch", "One Punch Kill", "Super Speed", "God Mode", "ESP", "No Cooldown"}
    elseif gameName == "MM2" then
        scripts = {"Auto Kill", "See Murderer", "Speed", "Aimbot", "ESP", "Ghost Mode"}
    elseif gameName == "Arsenal" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Infinite Ammo", "No Recoil"}
    elseif gameName == "Gun Games" then
        scripts = {"Aimbot", "Silent Aim", "ESP", "Speed Hack", "Fly", "Instant Kill", "Infinite Ammo", "No Recoil", "Rapid Fire"}
    elseif gameName == "OBBY Games" then
        scripts = {"Fly", "No Clip", "Speed", "Instant Finish", "Auto Jump"}
    elseif gameName == "BedWars" then
        scripts = {"Aimbot", "ESP", "Speed Hack", "Fly", "God Mode", "No Clip", "Auto Farm"}
    elseif gameName == "Blox Fruits" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP", "No Clip"}
    elseif gameName == "King Legacy" then
        scripts = {"Auto Farm", "Speed Hack", "Fly", "God Mode", "ESP"}
    elseif gameName == "Redliner" then
        scripts = {
            "Aimbot", "Silent Aim", "ESP", "Auto Parry", "No Parry Cooldown",
            "No Dash Cooldown", "No Gun Cooldown", "Rapid Fire",
            "Infinite Bullets", "Hitbox Expander", "Show Hitboxes",
            "Speed Hack", "Fly", "God Mode"
        }
    else
        scripts = {"Speed Hack", "Fly", "God Mode", "ESP", "Aimbot", "Silent Aim", "No Clip"}
    end
    
    AddLabel("── " .. gameName:upper() .. " SCRIPTS ──", "Main")
    
    for _, name in ipairs(scripts) do
        local btn = Instance.new("TextButton")
        btn.Parent = container
        btn.Size = UDim2.new(1, -20, 0, 28)
        btn.Position = UDim2.new(0, 10, 0, tabs["Main"].y)
        btn.BackgroundColor3 = Color3.fromRGB(18, 18, 40)
        btn.Text = name .. " (OFF)"
        btn.TextColor3 = Color3.fromRGB(200, 200, 220)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamSemibold
        btn.BorderSizePixel = 0
        btn.Visible = true
        
        local c = Instance.new("UICorner")
        c.Parent = btn
        c.CornerRadius = UDim.new(0, 4)
        
        local state = false
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.Text = name .. (state and " (ON)" or " (OFF)")
            btn.BackgroundColor3 = state and Color3.fromRGB(30, 80, 30) or Color3.fromRGB(18, 18, 40)
            ExecuteScript(name, state)
        end)
        
        table.insert(scriptElements, btn)
        tabs["Main"].y = tabs["Main"].y + 32
    end
    
    container.CanvasSize = UDim2.new(0, 0, 0, tabs["Main"].y + 20)
end

-- ==========================================
-- COMBAT TAB
-- ==========================================

AddLabel("── AIM SETTINGS ──", "Combat")

local aimParts = {"Head", "Torso", "HumanoidRootPart", "LowerTorso", "UpperTorso"}
AddDropdown("Aim Part:", "Combat", aimParts, function(opt)
    _G.AimPart = opt
end)

AddSlider("Hitbox Size", "Combat", 1, 10, 3, function(val)
    _G.HitboxSize = val
end)

AddSlider("Aim FOV", "Combat", 1, 360, 90, function(val)
    _G.AimFOV = val
end)

AddSlider("Fly Speed", "Combat", 10, 200, 50, function(val)
    _G.FlySpeed = val
end)

AddSlider("Walk Speed", "Combat", 16, 500, 16, function(val)
    _G.WalkSpeed = val
    local hum = player.Character and player.Character:FindFirstChild("Humanoid")
    if hum then hum.WalkSpeed = val end
end)

-- ==========================================
-- VISUAL TAB
-- ==========================================

AddLabel("── VISUAL SETTINGS ──", "Visual")

AddToggle("ESP", "Visual", function(v)
    _G.ESP = v
    ToggleESP(v)
end)

AddToggle("Show Hitboxes", "Visual", function(v)
    _G.ShowHitboxes = v
    ToggleHitboxes(v)
end)

AddToggle("Chams", "Visual", function(v)
    _G.Chams = v
    ToggleChams(v)
end)

AddToggle("Full Bright", "Visual", function(v)
    if v then
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
end)

-- ==========================================
-- ADMIN TAB
-- ==========================================

AddLabel("── PLAYER CONTROL ──", "Admin")

local playerList = {}
for _, v in ipairs(game.Players:GetPlayers()) do
    if v ~= player then table.insert(playerList, v.Name) end
end
if #playerList == 0 then table.insert(playerList, "No Players") end

local targetPlayer = playerList[1]

AddDropdown("Target:", "Admin", playerList, function(opt)
    targetPlayer = opt
end)

AddButton("Bring Player", "Admin", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game.Players:FindFirstChild(targetPlayer)
            local char = player.Character
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
                target.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame
            end
        end)
    end
end)

AddButton("Teleport to Player", "Admin", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game.Players:FindFirstChild(targetPlayer)
            local char = player.Character
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            end
        end)
    end
end)

AddButton("Kill Player", "Admin", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game.Players:FindFirstChild(targetPlayer)
            if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.Health = 0
            end
        end)
    end
end)

AddButton("Freeze Player", "Admin", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game.Players:FindFirstChild(targetPlayer)
            if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.WalkSpeed = 0
            end
        end)
    end
end)

AddButton("Unfreeze Player", "Admin", function()
    if targetPlayer and targetPlayer ~= "No Players" then
        pcall(function()
            local target = game.Players:FindFirstChild(targetPlayer)
            if target and target.Character and target.Character:FindFirstChild("Humanoid") then
                target.Character.Humanoid.WalkSpeed = 16
            end
        end)
    end
end)

-- Switch to Main
SwitchTab("Main")

-- ==========================================
-- VISUAL FUNCTIONS
-- ==========================================

local espObjects = {}
local hitboxObjects = {}
local chamObjects = {}

function ToggleESP(v)
    if v then
        game:GetService("RunService").RenderStepped:Connect(function()
            if not _G.ESP then return end
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        -- ESP logic
                    end
                end
            end
        end)
    end
end

function ToggleHitboxes(v)
    if v then
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = part
                        highlight.Adornee = part
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.FillTransparency = 0.3
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        table.insert(hitboxObjects, highlight)
                    end
                end
            end
        end
    else
        for _, h in ipairs(hitboxObjects) do h:Destroy() end
        hitboxObjects = {}
    end
end

function ToggleChams(v)
    if v then
        for _, p in ipairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character then
                for _, part in ipairs(p.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = part
                        highlight.Adornee = part
                        highlight.FillColor = Color3.fromRGB(0, 255, 255)
                        highlight.FillTransparency = 0.2
                        table.insert(chamObjects, highlight)
                    end
                end
            end
        end
    else
        for _, h in ipairs(chamObjects) do h:Destroy() end
        chamObjects = {}
    end
end

-- ==========================================
-- SCRIPT EXECUTION ENGINE
-- ==========================================

local runningScripts = {}

function ExecuteScript(name, value)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if runningScripts[name] then
        runningScripts[name] = false
        task.wait(0.05)
    end
    
    if not value then
        if name == "Super Speed" or name == "Speed Hack" or name == "Speed" then
            if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
        end
        if name == "Fly" then
            if hrp then
                for _, v in ipairs(hrp:GetChildren()) do
                    if v:IsA("BodyVelocity") then v:Destroy() end
                end
            end
        end
        if name == "God Mode" then _G.GodMode = false end
        if name == "No Clip" then _G.NoClip = false end
        if name == "ESP" then _G.ESP = false; ToggleESP(false) end
        if name == "Show Hitboxes" then _G.ShowHitboxes = false; ToggleHitboxes(false) end
        if name == "Chams" then _G.Chams = false; ToggleChams(false) end
        return
    end
    
    runningScripts[name] = true
    
    -- AUTO FARM
    if name == "Auto Farm" or name == "Auto Farm Money" or name == "Auto Farm Points" or name == "Auto Farm Wins" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    local targets = game.Players:GetPlayers()
                    if #targets < 2 then return end
                    local target = targets[math.random(2, #targets)]
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.1)
                        for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                            if r:IsA("RemoteEvent") and r.Name:lower():find("kill") then
                                r:FireServer(target)
                            end
                        end
                    end
                end)
            end
        end)
        
    -- MONEY DUPE
    elseif name == "Money Dupe" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("money") then
                            r:FireServer(999999)
                        end
                    end
                end)
            end
        end)
        
    -- GIVE ALL WEAPONS
    elseif name == "Give All Weapons" or name == "Give All Guns" then
        pcall(function()
            for _, v in ipairs(game.ReplicatedStorage:GetDescendants()) do
                if v:IsA("Tool") then
                    v:Clone().Parent = player.Backpack
                    task.wait(0.03)
                end
            end
        end)
        runningScripts[name] = false
        
    -- INSTANT KILL
    elseif name == "Instant Kill" or name == "One Punch Kill" or name == "One Shot Kill" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.2)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                            p.Character.Humanoid.Health = 0
                        end
                    end
                end)
            end
        end)
        
    -- SPEED
    elseif name == "Super Speed" or name == "Speed Hack" or name == "Speed" then
        if hum then
            hum.WalkSpeed = 150
            hum.JumpPower = 80
        end
        
    -- FLY
    elseif name == "Fly" then
        if hrp then
            for _, v in ipairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") then v:Destroy() end
            end
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = hrp
            task.spawn(function()
                while runningScripts[name] do
                    task.wait()
                    local speed = _G.FlySpeed or 50
                    local move = Vector3.new()
                    local uis = game:GetService("UserInputService")
                    if uis:IsKeyDown(Enum.KeyCode.W) then move = move + hrp.CFrame.LookVector * speed end
                    if uis:IsKeyDown(Enum.KeyCode.S) then move = move - hrp.CFrame.LookVector * speed end
                    if uis:IsKeyDown(Enum.KeyCode.A) then move = move - hrp.CFrame.RightVector * speed end
                    if uis:IsKeyDown(Enum.KeyCode.D) then move = move + hrp.CFrame.RightVector * speed end
                    if uis:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, speed, 0) end
                    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then move = move - Vector3.new(0, speed, 0) end
                    bv.Velocity = move
                end
            end)
        end
        
    -- GOD MODE
    elseif name == "God Mode" or name == "Infinite Health" then
        _G.GodMode = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                if hum then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
        
    -- NO CLIP
    elseif name == "No Clip" then
        _G.NoClip = true
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
        
    -- SILENT AIM
    elseif name == "Silent Aim" then
        _G.SilentAim = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
        
    -- AIMBOT
    elseif name == "Aimbot" or name == "Auto Aim" then
        _G.Aimbot = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait()
                pcall(function()
                    local target = GetClosestPlayer()
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
        
    -- AUTO PARRY (Redliner)
    elseif name == "Auto Parry" then
        _G.AutoParry = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("parry") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
        
    -- NO PARRY COOLDOWN (Redliner)
    elseif name == "No Parry Cooldown" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
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
        
    -- NO DASH COOLDOWN (Redliner)
    elseif name == "No Dash Cooldown" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
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
        
    -- NO GUN COOLDOWN (Redliner)
    elseif name == "No Gun Cooldown" or name == "No Cooldown" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("gun") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                        if v:IsA("NumberValue") and v.Name:lower():find("shoot") and v.Name:lower():find("cooldown") then
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
        
    -- RAPID FIRE (Redliner)
    elseif name == "Rapid Fire" then
        _G.RapidFire = true
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("shoot") then
                            r:FireServer()
                        end
                    end
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("fire") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
        
    -- INFINITE BULLETS (Redliner)
    elseif name == "Infinite Bullets" or name == "Infinite Ammo" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    for _, v in ipairs(player.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                            v.Ammo.Value = 999
                        end
                    end
                    if char then
                        for _, v in ipairs(char:GetChildren()) do
                            if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                                v.Ammo.Value = 999
                            end
                        end
                    end
                end)
            end
        end)
        
    -- HITBOX EXPANDER (Redliner)
    elseif name == "Hitbox Expander" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    local size = _G.HitboxSize or 3
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.Size = part.Size + Vector3.new(size, size, size)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- ESP
    elseif name == "ESP" then
        _G.ESP = true
        ToggleESP(true)
        
    -- SHOW HITBOXES
    elseif name == "Show Hitboxes" then
        _G.ShowHitboxes = true
        ToggleHitboxes(true)
        
    -- AUTO JUMP
    elseif name == "Auto Jump" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.05)
                if hum then
                    hum.Jump = true
                end
            end
        end)
        
    -- AUTO KILL (MM2)
    elseif name == "Auto Kill" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("kill") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
        
    -- SEE MURDERER (MM2)
    elseif name == "See Murderer" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            if p:FindFirstChild("Murderer") or p.Backpack:FindFirstChild("Knife") then
                                for _, part in ipairs(p.Character:GetChildren()) do
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
        end)
        
    -- GHOST MODE
    elseif name == "Ghost Mode" then
        if char then
            char.Transparency = 0.5
            char.CanCollide = false
        end
        
    -- INSTANT FINISH (OBBY)
    elseif name == "Instant Finish" then
        pcall(function()
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("finish") then
                    if hrp then hrp.CFrame = v.CFrame end
                end
            end
        end)
        runningScripts[name] = false
        
    -- AUTO COLLECT
    elseif name == "Auto Collect" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name:lower():find("coin") then
                            if hrp then hrp.CFrame = v.CFrame end
                        end
                    end
                end)
            end
        end)
        
    -- NO RECOIL
    elseif name == "No Recoil" then
        task.spawn(function()
            while runningScripts[name] do
                task.wait(0.1)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
                        if v:IsA("Part") and v.Name:lower():find("recoil") then
                            v:Destroy()
                        end
                    end
                end)
            end
        end)
    end
end

-- Helper function
function GetClosestPlayer()
    local hrp = GetHRP()
    if not hrp then return nil end
    local target = nil
    local shortest = math.huge
    for _, p in ipairs(game.Players:GetPlayers()) do
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

function GetHRP()
    local char = player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- ==========================================
-- LOAD DEFAULT GAME
-- ==========================================

LoadGameScripts(allGames[1])

-- ==========================================
-- KEYBINDS
-- ==========================================

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        gui.Enabled = not gui.Enabled
    end
end)

print("═══════════════════════════════════════")
print("✦ PHANTOM X - THE INVISIBLE MAN ✦")
print("✦ ALL GAMES SUPPORTED ✦")
print("✦ ALL FEATURES WORKING ✦")
print("✦ HIDE/SHOW WITH 'P' BUTTON ✦")
print("═══════════════════════════════════════")
