-- PHANTOM X - HARDCODED WORKING VERSION
-- Credits: The Invisible Man

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- ANTI-CHEAT
pcall(function()
    if player.Kick then player.Kick = function() end end
end)

-- LOAD RAYFIELD
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "PHANTOM X",
    LoadingTitle = "PHANTOM X",
    LoadingSubtitle = "by The Invisible Man",
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

-- ─── GAME SELECTION ───
local GameSection = GameTab:CreateSection("Select Game")

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
    "Redliner"
}

local selectedGame = "South Bronx Trenches"

GameSection:CreateDropdown({
    Name = "Game",
    Options = allGames,
    CurrentOption = "South Bronx Trenches",
    Callback = function(opt)
        selectedGame = opt
        -- Hide all script sections, show the right one
        for _, section in ipairs(allSections) do
            section.Visible = (section.Name == opt)
        end
    end
})

-- ─── CREATE ALL SCRIPT SECTIONS (HARDCODED) ───
local allSections = {}

-- SOUTH BRONX TRENCHES
local sbSection = GameTab:CreateSection("South Bronx Trenches Scripts")
table.insert(allSections, sbSection)

sbSection:CreateToggle({
    Name = "Auto Farm Money",
    CurrentValue = false,
    Callback = function(v) RunScript("AutoFarmMoney", v) end
})
sbSection:CreateToggle({
    Name = "Money Dupe",
    CurrentValue = false,
    Callback = function(v) RunScript("MoneyDupe", v) end
})
sbSection:CreateToggle({
    Name = "Give All Weapons",
    CurrentValue = false,
    Callback = function(v) RunScript("GiveAllWeapons", v) end
})
sbSection:CreateToggle({
    Name = "Instant Kill",
    CurrentValue = false,
    Callback = function(v) RunScript("InstantKill", v) end
})
sbSection:CreateToggle({
    Name = "Super Speed",
    CurrentValue = false,
    Callback = function(v) RunScript("SuperSpeed", v) end
})
sbSection:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function(v) RunScript("GodMode", v) end
})
sbSection:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(v) RunScript("Fly", v) end
})
sbSection:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = false,
    Callback = function(v) RunScript("SilentAim", v) end
})
sbSection:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(v) RunScript("ESP", v) end
})
sbSection:CreateToggle({
    Name = "Item Dupe",
    CurrentValue = false,
    Callback = function(v) RunScript("ItemDupe", v) end
})
sbSection:CreateToggle({
    Name = "Dupe Held Weapon",
    CurrentValue = false,
    Callback = function(v) RunScript("DupeHeldWeapon", v) end
})
sbSection:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Callback = function(v) RunScript("NoClip", v) end
})
sbSection:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function(v) RunScript("Aimbot", v) end
})

-- RIVALS
local rivalsSection = GameTab:CreateSection("Rivals Scripts")
table.insert(allSections, rivalsSection)
rivalsSection.Visible = false

rivalsSection:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
rivalsSection:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Callback = function(v) RunScript("SilentAim", v) end })
rivalsSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
rivalsSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
rivalsSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
rivalsSection:CreateToggle({ Name = "Instant Kill", CurrentValue = false, Callback = function(v) RunScript("InstantKill", v) end })

-- UNTITLED BOXING GAME
local ubgSection = GameTab:CreateSection("Untitled Boxing Game Scripts")
table.insert(allSections, ubgSection)
ubgSection.Visible = false

ubgSection:CreateToggle({ Name = "Auto Punch", CurrentValue = false, Callback = function(v) RunScript("AutoPunch", v) end })
ubgSection:CreateToggle({ Name = "One Punch Kill", CurrentValue = false, Callback = function(v) RunScript("InstantKill", v) end })
ubgSection:CreateToggle({ Name = "Super Speed", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
ubgSection:CreateToggle({ Name = "God Mode", CurrentValue = false, Callback = function(v) RunScript("GodMode", v) end })
ubgSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })

-- MM2
local mm2Section = GameTab:CreateSection("MM2 Scripts")
table.insert(allSections, mm2Section)
mm2Section.Visible = false

mm2Section:CreateToggle({ Name = "Auto Kill", CurrentValue = false, Callback = function(v) RunScript("AutoKill", v) end })
mm2Section:CreateToggle({ Name = "See Murderer", CurrentValue = false, Callback = function(v) RunScript("SeeMurderer", v) end })
mm2Section:CreateToggle({ Name = "Speed", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
mm2Section:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
mm2Section:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
mm2Section:CreateToggle({ Name = "Ghost Mode", CurrentValue = false, Callback = function(v) RunScript("GhostMode", v) end })

-- ARSENAL
local arsenalSection = GameTab:CreateSection("Arsenal Scripts")
table.insert(allSections, arsenalSection)
arsenalSection.Visible = false

arsenalSection:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
arsenalSection:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Callback = function(v) RunScript("SilentAim", v) end })
arsenalSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
arsenalSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
arsenalSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
arsenalSection:CreateToggle({ Name = "Instant Kill", CurrentValue = false, Callback = function(v) RunScript("InstantKill", v) end })
arsenalSection:CreateToggle({ Name = "Infinite Ammo", CurrentValue = false, Callback = function(v) RunScript("InfiniteAmmo", v) end })
arsenalSection:CreateToggle({ Name = "No Recoil", CurrentValue = false, Callback = function(v) RunScript("NoRecoil", v) end })

-- GUN GAMES
local gunSection = GameTab:CreateSection("Gun Games Scripts")
table.insert(allSections, gunSection)
gunSection.Visible = false

gunSection:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
gunSection:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Callback = function(v) RunScript("SilentAim", v) end })
gunSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
gunSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
gunSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
gunSection:CreateToggle({ Name = "Instant Kill", CurrentValue = false, Callback = function(v) RunScript("InstantKill", v) end })
gunSection:CreateToggle({ Name = "Infinite Ammo", CurrentValue = false, Callback = function(v) RunScript("InfiniteAmmo", v) end })
gunSection:CreateToggle({ Name = "No Recoil", CurrentValue = false, Callback = function(v) RunScript("NoRecoil", v) end })
gunSection:CreateToggle({ Name = "Rapid Fire", CurrentValue = false, Callback = function(v) RunScript("RapidFire", v) end })

-- OBBY GAMES
local obbySection = GameTab:CreateSection("OBBY Games Scripts")
table.insert(allSections, obbySection)
obbySection.Visible = false

obbySection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
obbySection:CreateToggle({ Name = "No Clip", CurrentValue = false, Callback = function(v) RunScript("NoClip", v) end })
obbySection:CreateToggle({ Name = "Speed", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
obbySection:CreateToggle({ Name = "Auto Jump", CurrentValue = false, Callback = function(v) RunScript("AutoJump", v) end })
obbySection:CreateToggle({ Name = "Instant Finish", CurrentValue = false, Callback = function(v) RunScript("InstantFinish", v) end })

-- BEDWARS
local bwSection = GameTab:CreateSection("BedWars Scripts")
table.insert(allSections, bwSection)
bwSection.Visible = false

bwSection:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
bwSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
bwSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
bwSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
bwSection:CreateToggle({ Name = "God Mode", CurrentValue = false, Callback = function(v) RunScript("GodMode", v) end })
bwSection:CreateToggle({ Name = "No Clip", CurrentValue = false, Callback = function(v) RunScript("NoClip", v) end })

-- BLOX FRUITS
local bfSection = GameTab:CreateSection("Blox Fruits Scripts")
table.insert(allSections, bfSection)
bfSection.Visible = false

bfSection:CreateToggle({ Name = "Auto Farm", CurrentValue = false, Callback = function(v) RunScript("AutoFarm", v) end })
bfSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
bfSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
bfSection:CreateToggle({ Name = "God Mode", CurrentValue = false, Callback = function(v) RunScript("GodMode", v) end })
bfSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
bfSection:CreateToggle({ Name = "No Clip", CurrentValue = false, Callback = function(v) RunScript("NoClip", v) end })

-- REDLINER
local redlinerSection = GameTab:CreateSection("Redliner Scripts")
table.insert(allSections, redlinerSection)
redlinerSection.Visible = false

redlinerSection:CreateToggle({ Name = "Aimbot", CurrentValue = false, Callback = function(v) RunScript("Aimbot", v) end })
redlinerSection:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Callback = function(v) RunScript("SilentAim", v) end })
redlinerSection:CreateToggle({ Name = "ESP", CurrentValue = false, Callback = function(v) RunScript("ESP", v) end })
redlinerSection:CreateToggle({ Name = "Auto Parry", CurrentValue = false, Callback = function(v) RunScript("AutoParry", v) end })
redlinerSection:CreateToggle({ Name = "No Parry Cooldown", CurrentValue = false, Callback = function(v) RunScript("NoParryCooldown", v) end })
redlinerSection:CreateToggle({ Name = "No Dash Cooldown", CurrentValue = false, Callback = function(v) RunScript("NoDashCooldown", v) end })
redlinerSection:CreateToggle({ Name = "No Gun Cooldown", CurrentValue = false, Callback = function(v) RunScript("NoGunCooldown", v) end })
redlinerSection:CreateToggle({ Name = "Rapid Fire", CurrentValue = false, Callback = function(v) RunScript("RapidFire", v) end })
redlinerSection:CreateToggle({ Name = "Infinite Bullets", CurrentValue = false, Callback = function(v) RunScript("InfiniteAmmo", v) end })
redlinerSection:CreateToggle({ Name = "Hitbox Expander", CurrentValue = false, Callback = function(v) RunScript("HitboxExpander", v) end })
redlinerSection:CreateToggle({ Name = "Speed Hack", CurrentValue = false, Callback = function(v) RunScript("SuperSpeed", v) end })
redlinerSection:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = function(v) RunScript("Fly", v) end })
redlinerSection:CreateToggle({ Name = "God Mode", CurrentValue = false, Callback = function(v) RunScript("GodMode", v) end })

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
                            tool:Clone().Parent = player.Backpack
                            break
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

WeaponSection:CreateButton({
    Name = "Clear Inventory",
    Callback = function()
        for _, v in ipairs(player.Backpack:GetChildren()) do
            if v:IsA("Tool") then v:Destroy() end
        end
    end
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
CreditsSection:CreateLabel("PHANTOM X")
CreditsSection:CreateLabel("by The Invisible Man")
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
    
    -- Auto Farm Money
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
        
    -- Money Dupe
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
        
    -- Give All Weapons
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
        
    -- Instant Kill
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
        
    -- Super Speed
    elseif name == "SuperSpeed" then
        if hum then
            hum.WalkSpeed = 200
            hum.JumpPower = 100
        end
        
    -- Fly
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
        
    -- God Mode
    elseif name == "GodMode" then
        task.spawn(function()
            while running[name] do
                task.wait()
                if hum then
                    hum.Health = hum.MaxHealth
                end
            end
        end)
        
    -- No Clip
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
        
    -- Silent Aim
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
        
    -- Aimbot
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
        
    -- Auto Parry
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
        
    -- No Parry Cooldown
    elseif name == "NoParryCooldown" then
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
        
    -- No Dash Cooldown
    elseif name == "NoDashCooldown" then
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
        
    -- No Gun Cooldown
    elseif name == "NoGunCooldown" then
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
        
    -- Rapid Fire
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
        
    -- Infinite Ammo
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
        
    -- Hitbox Expander
    elseif name == "HitboxExpander" then
        task.spawn(function()
            while running[name] do
                task.wait(0.1)
                pcall(function()
                    for _, p in ipairs(game.Players:GetPlayers()) do
                        if p ~= player and p.Character then
                            for _, part in ipairs(p.Character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.Size = part.Size + Vector3.new(3, 3, 3)
                                end
                            end
                        end
                    end
                end)
            end
        end)
        
    -- Auto Jump
    elseif name == "AutoJump" then
        task.spawn(function()
            while running[name] do
                task.wait(0.05)
                if hum then hum.Jump = true end
            end
        end)
        
    -- Auto Punch
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
        
    -- Auto Kill (MM2)
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
        
    -- See Murderer (MM2)
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
        
    -- Ghost Mode
    elseif name == "GhostMode" then
        if char then
            for _, part in ipairs(char:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0.5
                end
            end
        end
        
    -- Instant Finish (OBBY)
    elseif name == "InstantFinish" then
        pcall(function()
            for _, v in ipairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:lower():find("finish") then
                    if hrp then hrp.CFrame = v.CFrame end
                end
            end
        end)
        running[name] = false
        
    -- Auto Farm (Generic)
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
        
    -- Item Dupe
    elseif name == "ItemDupe" then
        pcall(function()
            local tool = char and char:FindFirstChildOfClass("Tool")
            if tool then
                tool:Clone().Parent = player.Backpack
            end
        end)
        running[name] = false
        
    -- Dupe Held Weapon
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
        
    -- No Recoil
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
    end
end

-- ─── KEYBINDS ───
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        Window:Toggle()
    end
end)

print("PHANTOM X LOADED - ALL SCRIPTS READY")
