-- PHANTOM X - AUTO HOOK EDITION
-- Credits: The Invisible Man

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- ANTI-CHEAT
pcall(function()
    if player.Kick then player.Kick = function() end end
end)

-- DETECT GAME AUTOMATICALLY
local function DetectGame()
    local placeId = game.PlaceId
    local gameName = ""
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name
    end)
    
    -- Fallback detection by PlaceId
    local gameMap = {
        [123456789] = "South Bronx Trenches",  -- Replace with actual IDs
        [987654321] = "Rivals",
        -- Add more as needed
    }
    
    if gameMap[placeId] then
        return gameMap[placeId]
    end
    
    -- Check by name
    local name = gameName:lower()
    if name:find("south") or name:find("bronx") then return "South Bronx Trenches" end
    if name:find("rival") then return "Rivals" end
    if name:find("boxing") then return "Untitled Boxing Game" end
    if name:find("murder") then return "MM2" end
    if name:find("arsenal") then return "Arsenal" end
    if name:find("gun") then return "Gun Games" end
    if name:find("obby") then return "OBBY Games" end
    if name:find("bed") and name:find("war") then return "BedWars" end
    if name:find("blox") and name:find("fruit") then return "Blox Fruits" end
    if name:find("redline") then return "Redliner" end
    
    return "Unknown"
end

local detectedGame = DetectGame()
print("Detected Game: " .. detectedGame)

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "PHANTOM X",
    LoadingTitle = "PHANTOM X",
    LoadingSubtitle = "Auto-Detected: " .. detectedGame,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PhantomX",
        FileName = "Config"
    },
    Discord = { Enabled = false },
    KeySystem = false,
    RayfieldVersion = "1.0"
})

-- ─── TABS ───
local GameTab = Window:CreateTab("Games")
local CombatTab = Window:CreateTab("Combat")
local UtilityTab = Window:CreateTab("Utility")
local VisualTab = Window:CreateTab("Visuals")
local AdminTab = Window:CreateTab("Admin")
local CreditsTab = Window:CreateTab("Credits")

-- ─── CREATE ALL SCRIPT SECTIONS (VISIBLE BY DEFAULT) ───

-- Helper to create toggle in a section
function AddToggleToSection(section, name, scriptName)
    section:CreateToggle({
        Name = name,
        CurrentValue = false,
        Callback = function(v)
            RunScript(scriptName or name, v)
        end
    })
end

-- ALL GAMES SECTION - UNIVERSAL
local universalSection = GameTab:CreateSection("Universal Scripts")
AddToggleToSection(universalSection, "Speed Hack", "SuperSpeed")
AddToggleToSection(universalSection, "Fly")
AddToggleToSection(universalSection, "God Mode")
AddToggleToSection(universalSection, "No Clip")
AddToggleToSection(universalSection, "ESP")
AddToggleToSection(universalSection, "Aimbot")
AddToggleToSection(universalSection, "Silent Aim")
AddToggleToSection(universalSection, "Instant Kill")
AddToggleToSection(universalSection, "Auto Farm")

-- AUTO DETECTED GAME SECTION
local autoSection = GameTab:CreateSection("Auto-Detected: " .. detectedGame)

-- Load scripts based on detected game
local function LoadAutoScripts()
    if detectedGame == "South Bronx Trenches" then
        AddToggleToSection(autoSection, "Auto Farm Money")
        AddToggleToSection(autoSection, "Money Dupe")
        AddToggleToSection(autoSection, "Give All Weapons")
        AddToggleToSection(autoSection, "Item Dupe")
        AddToggleToSection(autoSection, "Dupe Held Weapon")
    elseif detectedGame == "Rivals" then
        AddToggleToSection(autoSection, "Auto Aim", "Aimbot")
        AddToggleToSection(autoSection, "Anti-Stun")
        AddToggleToSection(autoSection, "Auto Farm Points", "AutoFarm")
    elseif detectedGame == "Untitled Boxing Game" then
        AddToggleToSection(autoSection, "Auto Punch")
        AddToggleToSection(autoSection, "One Punch Kill", "InstantKill")
        AddToggleToSection(autoSection, "Perfect Dodge")
        AddToggleToSection(autoSection, "No Cooldown")
    elseif detectedGame == "MM2" then
        AddToggleToSection(autoSection, "Auto Kill")
        AddToggleToSection(autoSection, "See Murderer")
        AddToggleToSection(autoSection, "Ghost Mode")
        AddToggleToSection(autoSection, "Auto Collect")
    elseif detectedGame == "Arsenal" then
        AddToggleToSection(autoSection, "Infinite Ammo")
        AddToggleToSection(autoSection, "No Recoil")
        AddToggleToSection(autoSection, "Rapid Fire")
    elseif detectedGame == "Gun Games" then
        AddToggleToSection(autoSection, "Infinite Ammo")
        AddToggleToSection(autoSection, "No Recoil")
        AddToggleToSection(autoSection, "Rapid Fire")
    elseif detectedGame == "OBBY Games" then
        AddToggleToSection(autoSection, "Auto Jump")
        AddToggleToSection(autoSection, "Instant Finish")
    elseif detectedGame == "BedWars" then
        AddToggleToSection(autoSection, "Auto Bridge")
        AddToggleToSection(autoSection, "Auto Farm")
    elseif detectedGame == "Blox Fruits" then
        AddToggleToSection(autoSection, "Auto Farm")
        AddToggleToSection(autoSection, "Auto Collect")
    elseif detectedGame == "Redliner" then
        AddToggleToSection(autoSection, "Auto Parry")
        AddToggleToSection(autoSection, "No Parry Cooldown")
        AddToggleToSection(autoSection, "No Dash Cooldown")
        AddToggleToSection(autoSection, "No Gun Cooldown")
        AddToggleToSection(autoSection, "Rapid Fire")
        AddToggleToSection(autoSection, "Infinite Bullets", "InfiniteAmmo")
        AddToggleToSection(autoSection, "Hitbox Expander")
        AddToggleToSection(autoSection, "Show Hitboxes")
    else
        autoSection:CreateLabel("No specific scripts for this game")
        autoSection:CreateLabel("Use Universal Scripts tab")
    end
end

LoadAutoScripts()

-- MANUAL GAME SELECTION (Fallback)
local manualSection = GameTab:CreateSection("Manual Game Selection")

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
    "Redliner",
    "Universal"
}

manualSection:CreateDropdown({
    Name = "Switch Game",
    Options = allGames,
    CurrentOption = detectedGame,
    Callback = function(opt)
        -- Clear and reload
        for _, v in ipairs(autoSection:GetChildren()) do
            if v:IsA("Section") then v:Destroy() end
        end
        -- Reload with selected game
        -- (simplified - just use universal for now)
    end
})

-- ─── WEAPON GIVER ───
local WeaponSection = UtilityTab:CreateSection("Weapon Giver")

local function GetWeapons()
    local weapons = {}
    local locations = {game.ReplicatedStorage, game.Workspace, game:GetService("ServerStorage"), player.Backpack}
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

local weaponList = GetWeapons()
if #weaponList == 0 then weaponList = {"No Weapons"} end
local selectedWeapon = weaponList[1]

WeaponSection:CreateDropdown({
    Name = "Select Weapon",
    Options = weaponList,
    CurrentOption = selectedWeapon,
    Callback = function(opt) selectedWeapon = opt end
})

WeaponSection:CreateButton({
    Name = "Give Weapon",
    Callback = function()
        if selectedWeapon and selectedWeapon ~= "No Weapons" then
            pcall(function()
                for _, loc in ipairs({game.ReplicatedStorage, game.Workspace, game:GetService("ServerStorage")}) do
                    if loc then
                        local tool = loc:FindFirstChild(selectedWeapon)
                        if tool and tool:IsA("Tool") then
                            local cloned = tool:Clone()
                            cloned.Parent = player.Backpack
                            break
                        end
                        for _, child in ipairs(loc:GetChildren()) do
                            if child:IsA("Folder") then
                                local t = child:FindFirstChild(selectedWeapon)
                                if t and t:IsA("Tool") then
                                    t:Clone().Parent = player.Backpack
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

WeaponSection:CreateButton({
    Name = "Refresh Weapons",
    Callback = function()
        local newList = GetWeapons()
        print("Found " .. #newList .. " weapons")
    end
})

-- ─── COMBAT TAB ───
local CombatSection = CombatTab:CreateSection("Aim Settings")

CombatSection:CreateDropdown({
    Name = "Aim Part",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    CurrentOption = "Head",
    Callback = function(opt) _G.AimPart = opt end
})

CombatSection:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(val) _G.FlySpeed = val end
})

CombatSection:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 500},
    Increment = 5,
    CurrentValue = 16,
    Callback = function(val)
        _G.WalkSpeed = val
        local hum = player.Character and player.Character:FindFirstChild("Humanoid")
        if hum then hum.WalkSpeed = val end
    end
})

CombatSection:CreateSlider({
    Name = "Hitbox Size",
    Range = {1, 10},
    Increment = 0.5,
    CurrentValue = 3,
    Callback = function(val) _G.HitboxSize = val end
})

-- ─── VISUAL TAB ───
local VisualSection = VisualTab:CreateSection("Visual Settings")

local espEnabled = false
local espObjects = {}

VisualSection:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(v)
        espEnabled = v
        if v then
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= player and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local bill = Instance.new("BillboardGui")
                        bill.Adornee = hrp
                        bill.Size = UDim2.new(0, 200, 0, 30)
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        bill.Parent = hrp
                        bill.AlwaysOnTop = true
                        
                        local label = Instance.new("TextLabel")
                        label.Parent = bill
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.Text = p.Name
                        label.TextColor3 = Color3.fromRGB(255, 255, 255)
                        label.TextSize = 14
                        label.Font = Enum.Font.GothamBold
                        label.TextStrokeTransparency = 0.5
                        
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = p.Character
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.FillTransparency = 0.5
                        
                        table.insert(espObjects, bill)
                        table.insert(espObjects, highlight)
                    end
                end
            end
        else
            for _, obj in ipairs(espObjects) do obj:Destroy() end
            espObjects = {}
        end
    end
})

VisualSection:CreateToggle({
    Name = "Full Bright",
    CurrentValue = false,
    Callback = function(v)
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
    end
})

-- ─── ADMIN TAB ───
local AdminSection = AdminTab:CreateSection("Player Control")

local function GetPlayers()
    local list = {}
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= player then table.insert(list, v.Name) end
    end
    return list
end

local pList = GetPlayers()
if #pList == 0 then pList = {"None"} end
local targetP = pList[1]

AdminSection:CreateDropdown({
    Name = "Target",
    Options = pList,
    CurrentOption = targetP,
    Callback = function(opt) targetP = opt end
})

AdminSection:CreateButton({
    Name = "Bring to Me",
    Callback = function()
        if targetP and targetP ~= "None" then
            pcall(function()
                local t = game.Players:FindFirstChild(targetP)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp then
                    t.Character.HumanoidRootPart.CFrame = hrp.CFrame
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "TP to Player",
    Callback = function()
        if targetP and targetP ~= "None" then
            pcall(function()
                local t = game.Players:FindFirstChild(targetP)
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp then
                    hrp.CFrame = t.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
})

AdminSection:CreateButton({
    Name = "Kill Player",
    Callback = function()
        if targetP and targetP ~= "None" then
            pcall(function()
                local t = game.Players:FindFirstChild(targetP)
                if t and t.Character and t.Character:FindFirstChild("Humanoid") then
                    t.Character.Humanoid.Health = 0
                end
            end)
        end
    end
})

-- ─── CREDITS ───
local CreditsSection = CreditsTab:CreateSection("The Invisible Man")
CreditsSection:CreateLabel("PHANTOM X - AUTO HOOK")
CreditsSection:CreateLabel("by The Invisible Man")
CreditsSection:CreateLabel("Auto-Detected: " .. detectedGame)
CreditsSection:CreateLabel("All Rights Reserved")

-- ─── SCRIPT RUNNER ───
local running = {}

function RunScript(name, value)
    if running[name] then
        running[name] = false
        task.wait(0.05)
    end
    if not value then
        if name == "SuperSpeed" then
            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
            if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
        end
        if name == "Fly" then
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in ipairs(hrp:GetChildren()) do
                    if v:IsA("BodyVelocity") then v:Destroy() end
                end
            end
        end
        return
    end
    
    running[name] = true
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    if name == "AutoFarmMoney" then
        task.spawn(function()
            while running[name] do
                task.wait(0.3)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("money") then
                            r:FireServer(999999)
                        end
                    end
                end)
            end
        end)
    elseif name == "MoneyDupe" then
        task.spawn(function()
            while running[name] do
                task.wait(0.1)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("money") then
                            r:FireServer(999999)
                        end
                    end
                end)
            end
        end)
    elseif name == "GiveAllWeapons" then
        pcall(function()
            for _, v in ipairs(game.ReplicatedStorage:GetDescendants()) do
                if v:IsA("Tool") then
                    v:Clone().Parent = player.Backpack
                    task.wait(0.02)
                end
            end
        end)
        running[name] = false
    elseif name == "InstantKill" then
        task.spawn(function()
            while running[name] do
                task.wait(0.1)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
                            p.Character.Humanoid.Health = 0
                        end
                    end
                end)
            end
        end)
    elseif name == "SuperSpeed" then
        if hum then hum.WalkSpeed = 200; hum.JumpPower = 100 end
    elseif name == "Fly" then
        if hrp then
            for _, v in ipairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") then v:Destroy() end
            end
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = hrp
            task.spawn(function()
                while running[name] do
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
    elseif name == "GodMode" then
        task.spawn(function()
            while running[name] do
                task.wait()
                if hum then hum.Health = hum.MaxHealth end
            end
        end)
    elseif name == "NoClip" then
        task.spawn(function()
            while running[name] do
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
    elseif name == "SilentAim" then
        task.spawn(function()
            while running[name] do
                task.wait()
                pcall(function()
                    local target = nil
                    local shortest = math.huge
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp then
                            local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if dist < shortest then
                                shortest = dist
                                target = p
                            end
                        end
                    end
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
    elseif name == "Aimbot" then
        task.spawn(function()
            while running[name] do
                task.wait()
                pcall(function()
                    local target = nil
                    local shortest = math.huge
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp then
                            local dist = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                            if dist < shortest then
                                shortest = dist
                                target = p
                            end
                        end
                    end
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild(_G.AimPart or "Head")
                        if aimPart then
                            mouse.Hit = CFrame.new(aimPart.Position)
                        end
                    end
                end)
            end
        end)
    elseif name == "AutoParry" then
        task.spawn(function()
            while running[name] do
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
    elseif name == "NoParryCooldown" or name == "NoDashCooldown" or name == "NoGunCooldown" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
    elseif name == "RapidFire" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("shoot") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
    elseif name == "InfiniteAmmo" then
        task.spawn(function()
            while running[name] do
                task.wait(0.1)
                pcall(function()
                    for _, v in ipairs(player.Backpack:GetChildren()) do
                        if v:IsA("Tool") and v:FindFirstChild("Ammo") then
                            v.Ammo.Value = 999
                        end
                    end
                end)
            end
        end)
    elseif name == "HitboxExpander" then
        task.spawn(function()
            while running[name] do
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
    elseif name == "AutoJump" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                if hum then hum.Jump = true end
            end
        end)
    elseif name == "AutoPunch" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("punch") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
    elseif name == "AutoKill" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                pcall(function()
                    for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                        if r:IsA("RemoteEvent") and r.Name:lower():find("kill") then
                            r:FireServer()
                        end
                    end
                end)
            end
        end)
    elseif name == "SeeMurderer" then
        task.spawn(function()
            while running[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character and (p:FindFirstChild("Murderer") or p.Backpack:FindFirstChild("Knife")) then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local h = Instance.new("Highlight")
                                    h.Parent = part
                                    h.Adornee = part
                                    h.FillColor = Color3.fromRGB(255, 0, 0)
                                    h.FillTransparency = 0.3
                                end
                            end
                        end
                    end
                end)
            end
        end)
    elseif name == "GhostMode" then
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                end
            end
        end
    elseif name == "InstantFinish" then
        pcall(function()
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("finish") then
                    if hrp then hrp.CFrame = v.CFrame end
                end
            end
        end)
        running[name] = false
    elseif name == "AutoFarm" then
        task.spawn(function()
            while running[name] do
                task.wait(0.3)
                pcall(function()
                    local targets = game.Players:GetPlayers()
                    if #targets < 2 then return end
                    local target = targets[math.random(2, #targets)]
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
                        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                        for _, r in ipairs(game.ReplicatedStorage:GetDescendants()) do
                            if r:IsA("RemoteEvent") and r.Name:lower():find("kill") then
                                r:FireServer(target)
                            end
                        end
                    end
                end)
            end
        end)
    elseif name == "ItemDupe" then
        pcall(function()
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then tool:Clone().Parent = player.Backpack end
        end)
        running[name] = false
    elseif name == "DupeHeldWeapon" then
        pcall(function()
            local weapon = char and char:FindFirstChildOfClass("Tool")
            if weapon then
                for i = 1, 10 do
                    weapon:Clone().Parent = player.Backpack
                    task.wait(0.02)
                end
            end
        end)
        running[name] = false
    elseif name == "NoRecoil" then
        task.spawn(function()
            while running[name] do
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
    elseif name == "AutoCollect" then
        task.spawn(function()
            while running[name] do
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
    elseif name == "AutoBridge" then
        task.spawn(function()
            while running[name] do
                task.wait(0.1)
                -- Auto bridge logic
            end
        end)
    elseif name == "PerfectDodge" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                -- Dodge logic
            end
        end)
    elseif name == "AntiStun" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                if hum then hum.PlatformStand = false end
            end
        end)
    elseif name == "NoCooldown" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                pcall(function()
                    for _, v in ipairs(game.Workspace:GetDescendants()) do
                        if v:IsA("NumberValue") and v.Name:lower():find("cooldown") then
                            v.Value = 0
                        end
                    end
                end)
            end
        end)
    elseif name == "ShowHitboxes" then
        task.spawn(function()
            while running[name] do
                task.wait(0.5)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    local h = Instance.new("Highlight")
                                    h.Parent = part
                                    h.Adornee = part
                                    h.FillColor = Color3.fromRGB(255, 0, 0)
                                    h.FillTransparency = 0.3
                                    h.OutlineColor = Color3.fromRGB(255, 255, 0)
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end

-- ─── KEYBINDS ───
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        Window:Toggle()
    end
end)

print("═══════════════════════════════════════")
print("✦ PHANTOM X - AUTO HOOK ✦")
print("✦ Detected: " .. detectedGame)
print("✦ All scripts loaded")
print("✦ by The Invisible Man")
print("═══════════════════════════════════════")
