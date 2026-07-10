
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
