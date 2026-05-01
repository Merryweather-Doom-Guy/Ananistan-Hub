do
    local KEY = "Tomas Ayak Gücü"
    local TweenService = game:GetService("TweenService")
    local sg = Instance.new("ScreenGui", game.CoreGui)
    sg.Name = "KeyAuth"
    sg.ResetOnSpawn = false

    local bg = Instance.new("Frame", sg)
    bg.Size = UDim2.new(0, 340, 0, 130)
    bg.Position = UDim2.new(0.5, -170, 0.5, -65)
    bg.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    bg.BorderSizePixel = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)

    local accent = Instance.new("Frame", bg)
    accent.Size = UDim2.new(1, 0, 0, 3)
    accent.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    accent.BorderSizePixel = 0
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 10)

    local box = Instance.new("TextBox", bg)
    box.Size = UDim2.new(1, -30, 0, 36)
    box.Position = UDim2.new(0, 15, 0, 20)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    box.TextColor3 = Color3.fromRGB(220, 220, 220)
    box.PlaceholderText = "Key gir..."
    box.Text = ""
    box.Font = Enum.Font.GothamMedium
    box.TextSize = 14
    box.ClearTextOnFocus = false
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    local statusLbl = Instance.new("TextLabel", bg)
    statusLbl.Size = UDim2.new(1, -30, 0, 18)
    statusLbl.Position = UDim2.new(0, 15, 0, 62)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Text = ""
    statusLbl.TextColor3 = Color3.fromRGB(200, 70, 70)
    statusLbl.Font = Enum.Font.Gotham
    statusLbl.TextSize = 12
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left

    local confirmBtn = Instance.new("TextButton", bg)
    confirmBtn.Size = UDim2.new(1, -30, 0, 32)
    confirmBtn.Position = UDim2.new(0, 15, 0, 85)
    confirmBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    confirmBtn.Text = "Giriş"
    confirmBtn.TextColor3 = Color3.new(1, 1, 1)
    confirmBtn.Font = Enum.Font.GothamBold
    confirmBtn.TextSize = 14
    confirmBtn.BorderSizePixel = 0
    Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 6)

    local verified = false
    local function tryKey()
        if box.Text == KEY then
            verified = true
            TweenService:Create(bg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.35)
            sg:Destroy()
        else
            statusLbl.Text = "Yanlış key!"
            box.Text = ""
            TweenService:Create(bg, TweenInfo.new(0.06), {Position = UDim2.new(0.5, -162, 0.5, -65)}):Play()
            task.wait(0.06)
            TweenService:Create(bg, TweenInfo.new(0.06), {Position = UDim2.new(0.5, -178, 0.5, -65)}):Play()
            task.wait(0.06)
            TweenService:Create(bg, TweenInfo.new(0.06), {Position = UDim2.new(0.5, -170, 0.5, -65)}):Play()
        end
    end
    confirmBtn.MouseButton1Click:Connect(tryKey)
    box.FocusLost:Connect(function(enter) if enter then tryKey() end end)
    repeat task.wait(0.05) until verified
end

if game.CoreGui:FindFirstChild("AnanistanHub") then
    game.CoreGui.AnanistanHub:Destroy()
end
 
local UIS = game:GetService("UserInputService")
 

 

 
local parachuteEnabled = false
local parachuteConnection = nil
local parachuteTrack = nil
 
local function runParachute(button)
 
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local root = char:WaitForChild("HumanoidRootPart")
    local RunService = game:GetService("RunService")
 
    parachuteEnabled = not parachuteEnabled
    button.Text = parachuteEnabled and "Parachute: ON" or "Parachute: OFF"
 
    if not parachuteTrack then
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://507766666"
        parachuteTrack = animator:LoadAnimation(anim)
    end
 
    if parachuteEnabled then
 
        parachuteConnection = RunService.RenderStepped:Connect(function()
 
            if humanoid.FloorMaterial == Enum.Material.Air then
 
                if not parachuteTrack.IsPlaying then
                    parachuteTrack:Play()
                end
 
                local vel = root.Velocity
                if vel.Y < -20 then
                    root.Velocity = Vector3.new(vel.X, -10, vel.Z)
                end
 
            else
                if parachuteTrack.IsPlaying then
                    parachuteTrack:Stop()
                end
            end
 
        end)
 
    else
 
        if parachuteConnection then
            parachuteConnection:Disconnect()
            parachuteConnection = nil
        end
 
        if parachuteTrack and parachuteTrack.IsPlaying then
            parachuteTrack:Stop()
        end
 
    end
end
 

 
local fullbrightEnabled = false
local oldLighting = {}
 
local function runFullbright(button)
 
    local Lighting = game:GetService("Lighting")
 
    fullbrightEnabled = not fullbrightEnabled
    button.Text = fullbrightEnabled and "FullBright: ON" or "FullBright: OFF"
 
    if fullbrightEnabled then
 
        oldLighting.Brightness = Lighting.Brightness
        oldLighting.ClockTime = Lighting.ClockTime
        oldLighting.FogEnd = Lighting.FogEnd
        oldLighting.GlobalShadows = Lighting.GlobalShadows
        oldLighting.OutdoorAmbient = Lighting.OutdoorAmbient
 
        Lighting.Brightness = 1
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
 
    else
 
        Lighting.Brightness = oldLighting.Brightness
        Lighting.ClockTime = oldLighting.ClockTime
        Lighting.FogEnd = oldLighting.FogEnd
        Lighting.GlobalShadows = oldLighting.GlobalShadows
        Lighting.OutdoorAmbient = oldLighting.OutdoorAmbient
 
    end
end
 

 
local function runGrapple()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/0Ben1/fe/main/obf_E872F3ky4888TSVdj6Adgi1hSLtM038AyxVpTVw07QA3QUDcI3sxmuD869hYR4id.lua.txt"))()
end
 


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local espObjects = {}

local espEnabled = false
local espExpanded = false
local espShowNames = false
local espShowChams = false
local espShowBoxes = false
local espShowInventory = false
local espUseCustomColor = false
local espUseTeamColor = false
local espUseFriendColor = false

local espCustomColor = Color3.fromRGB(255, 255, 255)
local espFriendColor = Color3.fromRGB(0, 255, 0)
local espNameColor = Color3.fromRGB(255, 255, 255)
local espBoxColor = Color3.fromRGB(255, 255, 255)
local espInventoryColor = Color3.fromRGB(255, 255, 255)

local espShowHealth = false
local clickTPEnabled = false
local antiAFKEnabled = false
local antiAFKConn = nil

local espLoopThread = nil
local espMaxDistance = 5000
local espConnections = {}

local colorPresets = {
    Color3.fromRGB(255,255,255), Color3.fromRGB(255,0,0), Color3.fromRGB(0,255,0),
    Color3.fromRGB(0,120,255), Color3.fromRGB(255,255,0), Color3.fromRGB(255,0,255),
    Color3.fromRGB(0,255,255), Color3.fromRGB(255,165,0),
}


local friendCache = {}
local function isFriend(target)
    if friendCache[target.UserId] ~= nil then
        return friendCache[target.UserId]
    end
    local ok, result = pcall(function()
        return player:IsFriendsWith(target.UserId)
    end)
    friendCache[target.UserId] = ok and result or false
    return friendCache[target.UserId]
end

local function getESPColor(target)
    if espUseFriendColor and isFriend(target) then
        return espFriendColor
    end
    if espUseTeamColor and target.Team then
        return target.TeamColor.Color
    elseif espUseCustomColor then
        return espCustomColor
    end
    return Color3.fromRGB(255, 255, 255)
end

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj.box then pcall(game.Destroy, obj.box) end
        if obj.billboard then pcall(game.Destroy, obj.billboard) end
        if obj.highlight then pcall(game.Destroy, obj.highlight) end
    end
    espObjects = {}
end

local function buildESP(target, useChams)
    if not espEnabled or target == player then return end
    local char = target.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Head")
    if not root then return end

    local obj = espObjects[target] or {}
    local espColor = getESPColor(target)

    if espShowChams then
        if not obj.highlight or not obj.highlight.Parent then
            local hl = Instance.new("Highlight")
            hl.Adornee = char
            hl.FillTransparency = 0.7
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = char
            obj.highlight = hl
        end
        obj.highlight.FillColor = espColor
        obj.highlight.OutlineColor = espColor
    else
        if obj.highlight then pcall(game.Destroy, obj.highlight); obj.highlight = nil end
    end

    if espShowBoxes then
        if not obj.box or not obj.box.Parent then
            local bb = Instance.new("BillboardGui")
            bb.Name = "BoxESP"
            bb.Adornee = root
            bb.Size = UDim2.new(4.5, 0, 6, 0)
            bb.AlwaysOnTop = true
            bb.MaxDistance = 0
            bb.Parent = char
            
            local frame = Instance.new("Frame", bb)
            frame.Name = "BoxFrame"
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundTransparency = 1
            
            local stroke = Instance.new("UIStroke", frame)
            stroke.Thickness = 2
            stroke.Color = espColor
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            
            obj.box = bb
            obj.stroke = stroke
        end
        if obj.stroke then obj.stroke.Color = espColor end
    else
        if obj.box then pcall(game.Destroy, obj.box); obj.box = nil; obj.stroke = nil end
    end

    if espShowNames or espShowInventory then
        if not obj.billboard or not obj.billboard.Parent then
            local bb = Instance.new("BillboardGui")
            bb.Name = "InfoESP"
            bb.Adornee = char:FindFirstChild("Head") or root
            bb.Size = UDim2.new(0, 300, 0, 70)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.MaxDistance = 0
            bb.Parent = char
            
            local nl = Instance.new("TextLabel", bb)
            nl.Name = "NL"; nl.Size = UDim2.new(1, 0, 0, 22)
            nl.BackgroundTransparency = 1; nl.Font = Enum.Font.GothamBold
            nl.TextSize = 16; nl.TextStrokeTransparency = 0.3; nl.Text = ""
            
            local dl = Instance.new("TextLabel", bb)
            dl.Name = "DL"; dl.Size = UDim2.new(1, 0, 0, 16)
            dl.Position = UDim2.new(0, 0, 0, 22)
            dl.BackgroundTransparency = 1; dl.Font = Enum.Font.Gotham
            dl.TextSize = 13; dl.TextStrokeTransparency = 0.4; dl.Text = ""
            
            local il = Instance.new("TextLabel", bb)
            il.Name = "IL"; il.Size = UDim2.new(1, 0, 0, 28)
            il.Position = UDim2.new(0, 0, 0, 38); il.BackgroundTransparency = 1
            il.Font = Enum.Font.Gotham; il.TextSize = 12
            il.TextStrokeTransparency = 0.5; il.TextWrapped = true
            il.TextYAlignment = Enum.TextYAlignment.Top; il.Text = ""
            
            local hb = Instance.new("Frame", bb)
            hb.Name = "HB"; hb.Size = UDim2.new(0.4, 0, 0, 4)
            hb.Position = UDim2.new(0.3, 0, 0, 66)
            hb.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            hb.BorderSizePixel = 0
            
            local hf = Instance.new("Frame", hb)
            hf.Name = "HF"; hf.Size = UDim2.new(1, 0, 1, 0)
            hf.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            hf.BorderSizePixel = 0
            
            obj.billboard = bb
        end
        
        local nl = obj.billboard:FindFirstChild("NL")
        local dl = obj.billboard:FindFirstChild("DL")
        if nl then
            if espShowNames then
                nl.Text = target.Name
                nl.TextColor3 = espColor; nl.Visible = true
            else nl.Visible = false end
        end
        if dl then
            if espShowNames then
                local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local d = myRoot and math.floor((root.Position - myRoot.Position).Magnitude) or 0
                dl.Text = "[" .. d .. "m]"
                dl.TextColor3 = espColor; dl.Visible = true
            else dl.Visible = false end
        end
        
        local il = obj.billboard:FindFirstChild("IL")
        if il then
            if espShowInventory then
                local items = {}
                for _, t in pairs(char:GetChildren()) do
                    if t:IsA("Tool") then table.insert(items, "[E] " .. t.Name) end
                end
                local bp = target:FindFirstChild("Backpack")
                if bp then
                    for _, t in pairs(bp:GetChildren()) do
                        if t:IsA("Tool") then table.insert(items, t.Name) end
                    end
                end
                il.Text = #items > 0 and table.concat(items, ", ") or ""
                il.TextColor3 = espColor; il.Visible = true
            else il.Visible = false end
        end
    elseif obj.billboard then
        pcall(game.Destroy, obj.billboard); obj.billboard = nil
    end

    espObjects[target] = obj
end

local function updateAllESP()
    if not espEnabled then return end
    for p, obj in pairs(espObjects) do
        pcall(function() 
            if not p or not p.Parent then 
                if obj.box then pcall(game.Destroy, obj.box) end
                if obj.billboard then pcall(game.Destroy, obj.billboard) end
                if obj.highlight then pcall(game.Destroy, obj.highlight) end
                espObjects[p] = nil
                return 
            end
        end)
    end
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    local playersByDist = {}
    for _, t in pairs(Players:GetPlayers()) do
        if t ~= player then
            pcall(function()
                local char = t.Character
                if not char then return end
                local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Head")
                if not root then return end
                local dist = myRoot and (root.Position - myRoot.Position).Magnitude or 999999
                table.insert(playersByDist, {plr = t, dist = dist})
            end)
        end
    end
    table.sort(playersByDist, function(a, b) return a.dist < b.dist end)
    
    for i, data in ipairs(playersByDist) do
        pcall(function()
            local p = data.plr
            local d = data.dist
            local isTop31 = i <= 31
            local visible = d <= espMaxDistance
            
            buildESP(p, isTop31)
            
            local obj = espObjects[p]
            if obj then
                if obj.box then obj.box.Enabled = (visible and espShowBoxes) end
                if obj.highlight then obj.highlight.Enabled = (visible and espShowChams and isTop31) end
                if obj.billboard then 
                obj.billboard.Enabled = (visible and (espShowNames or espShowInventory or espShowHealth)) 
                
                local hum = p.Character and p.Character:FindFirstChild("Humanoid")
                local hb = obj.billboard:FindFirstChild("HB")
                if hb then
                    if espShowHealth and hum then
                        hb.Visible = true
                        local healthPercent = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
                        local hf = hb:FindFirstChild("HF")
                        if hf then
                            hf.Size = UDim2.new(healthPercent, 0, 1, 0)
                            hf.BackgroundColor3 = Color3.fromHSV(healthPercent * 0.35, 1, 1) 
                        end
                    else hb.Visible = false end
                end

                if obj.billboard.Enabled and espShowNames then
                        local nl = obj.billboard:FindFirstChild("NL")
                        if nl then nl.Text = p.Name end
                        local dl = obj.billboard:FindFirstChild("DL")
                        if dl then dl.Text = "[" .. math.floor(d) .. "m]" end
                    end
                end
            end
        end)
    end
end
 
local function runFly()
    local UserInputService = game:GetService("UserInputService")
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
 
    if isMobile then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/MobileFly.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/396abc/Script/refs/heads/main/FlyR15.lua"))()
    end
end
 
local function runInfiniteYield()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end
 




local function runSpiderWeb1()
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    if backpack:FindFirstChild("Grapple 1") then return end
    
    local tool = Instance.new("Tool")
    tool.Name = "Grapple 1"
    tool.RequiresHandle = false
    tool.Parent = backpack
    
    local UserInputService = game:GetService("UserInputService")
    local connection
    local attachment0, attachment1, rope
    
    tool.Equipped:Connect(function(mouse)
        connection = mouse.Button1Down:Connect(function()
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local targetPos = mouse.Hit.Position
            
            if rope then rope:Destroy() end
            if attachment0 then attachment0:Destroy() end
            if attachment1 then attachment1:Destroy() end
            
            attachment0 = Instance.new("Attachment", root)
            
            local hookPart = Instance.new("Part")
            hookPart.Size = Vector3.new(0.5, 0.5, 0.5)
            hookPart.Position = targetPos
            hookPart.Anchored = true
            hookPart.CanCollide = false
            hookPart.Transparency = 1
            hookPart.Parent = workspace
            
            attachment1 = Instance.new("Attachment", hookPart)
            
            rope = Instance.new("SpringConstraint")
            rope.Attachment0 = attachment0
            rope.Attachment1 = attachment1
            rope.Visible = true
            rope.Thickness = 0.05
            rope.Color = BrickColor.new("Institutional white")
            rope.FreeLength = 1
            rope.MaxForce = 100000
            rope.Damping = 2
            rope.Stiffness = 500
            rope.Parent = root
            
            task.delay(4, function()
                if rope then rope:Destroy() end
                if hookPart then hookPart:Destroy() end
            end)
        end)
    end)
    
    tool.Unequipped:Connect(function()
        if connection then connection:Disconnect() end
        if rope then rope:Destroy() end
        if attachment0 then attachment0:Destroy() end
        if attachment1 then attachment1:Destroy() end
    end)
end

local function runSpiderWeb2()
    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    if not backpack then return end

    if backpack:FindFirstChild("Grapple 2") then return end
    
    local tool = Instance.new("Tool")
    tool.Name = "Grapple 2"
    tool.RequiresHandle = false
    tool.Parent = backpack
    
    local connection
    local attachment0, attachment1, rope
    local isHanging = false
    local rsConn = nil
    
    tool.Equipped:Connect(function(mouse)
        connection = mouse.Button1Down:Connect(function()
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            if isHanging then
                if rope then rope:Destroy() end
                if attachment0 then attachment0:Destroy() end
                if attachment1 then attachment1:Destroy() end
                isHanging = false
                if rsConn then rsConn:Disconnect(); rsConn = nil end
            else
                local targetPos = mouse.Hit.Position
                
                attachment0 = Instance.new("Attachment", root)
                
                local hookPart = Instance.new("Part")
                hookPart.Size = Vector3.new(0.5, 0.5, 0.5)
                hookPart.Position = targetPos
                hookPart.Anchored = true
                hookPart.CanCollide = false
                hookPart.Transparency = 1
                hookPart.Parent = workspace
                
                attachment1 = Instance.new("Attachment", hookPart)
                
                rope = Instance.new("RopeConstraint")
                rope.Attachment0 = attachment0
                rope.Attachment1 = attachment1
                rope.Visible = true
                rope.Thickness = 0.05
                rope.Color = BrickColor.new("Institutional white")
                rope.Length = (root.Position - targetPos).Magnitude * 0.5
                rope.Parent = root
                
                isHanging = true
                
                local uis = game:GetService("UserInputService")
                rsConn = game:GetService("RunService").RenderStepped:Connect(function()
                    if isHanging and rope then
                        if uis:IsKeyDown(Enum.KeyCode.E) then
                            rope.Length = math.max(1, rope.Length - 0.5)
                        elseif uis:IsKeyDown(Enum.KeyCode.Q) then
                            rope.Length = rope.Length + 0.5
                        end
                    end
                end)
            end
        end)
    end)
    
    tool.Unequipped:Connect(function()
        if connection then connection:Disconnect() end
        if rope then rope:Destroy() end
        if attachment0 then attachment0:Destroy() end
        if attachment1 then attachment1:Destroy() end
        isHanging = false
        if rsConn then rsConn:Disconnect(); rsConn = nil end
    end)
end

local wallClimbEnabled = false
local wallClimbConn = nil

local antiVoidEnabled = false
local antiVoidConn = nil
local lastSafePos = nil

local function startAntiVoid()
    if antiVoidConn then antiVoidConn:Disconnect() end
    antiVoidConn = RunService.Heartbeat:Connect(function()
        if not antiVoidEnabled then return end
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if root.Position.Y > -100 then
            lastSafePos = root.Position
        else
            if lastSafePos then
                root.CFrame = CFrame.new(lastSafePos + Vector3.new(0, 5, 0))
            else
                root.CFrame = CFrame.new(0, 100, 0)
            end
        end
    end)
end

local function stopAntiVoid()
    if antiVoidConn then antiVoidConn:Disconnect(); antiVoidConn = nil end
end

local function toggleWallClimb(button)
    wallClimbEnabled = not wallClimbEnabled
    button.Text = wallClimbEnabled and "Duvara Tırmanma: ON" or "Duvara Tırmanma: OFF"
    
    local player = game.Players.LocalPlayer
    local rs = game:GetService("RunService")
    local uis = game:GetService("UserInputService")
    
    if wallClimbEnabled then
        if wallClimbConn then wallClimbConn:Disconnect() end
        wallClimbConn = rs.RenderStepped:Connect(function()
            if not wallClimbEnabled then return end
            local char = player.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            
            local rayOrigin = root.Position
            local rayDirection = root.CFrame.LookVector * 2.5
            
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {char}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            
            local res = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
            
            if res and res.Instance and res.Instance.CanCollide then
                local velY = 0
                if uis:IsKeyDown(Enum.KeyCode.W) then velY = 20 end
                if uis:IsKeyDown(Enum.KeyCode.S) then velY = -20 end
                
                local moveDir = Vector3.new(0,0,0)
                if uis:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector
                end
                if uis:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector
                end
                
                if moveDir.Magnitude > 0 then
                    moveDir = moveDir.Unit * 20
                end
                
                root.Velocity = Vector3.new(moveDir.X, velY, moveDir.Z)
            end
        end)
    else
        if wallClimbConn then
            wallClimbConn:Disconnect()
            wallClimbConn = nil
        end
    end
end

local HttpService = game:GetService("HttpService")



local CoreGui = game:GetService("CoreGui") or game.CoreGui
local oldGui = CoreGui:FindFirstChild("AnanistanHubGui")
if oldGui then oldGui:Destroy() end
if CoreGui:FindFirstChild("AnanistanHub") then CoreGui.AnanistanHub:Destroy() end

local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "AnanistanHubGui"
screenGui.ResetOnSpawn = false


local cBg = Color3.fromRGB(20, 20, 25)
local cTop = Color3.fromRGB(30, 30, 35)
local cTabActive = Color3.fromRGB(45, 45, 50)
local cAccent = Color3.fromRGB(255, 50, 50)
local cText = Color3.fromRGB(220, 220, 220)
local cElement = Color3.fromRGB(35, 35, 40)
local cToggleOn = Color3.fromRGB(80, 220, 80)
local cToggleOff = Color3.fromRGB(80, 80, 80)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 600, 0, 360)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -180)
mainFrame.BackgroundColor3 = cBg
mainFrame.BorderSizePixel = 0
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

task.spawn(function()
    local names = {"RobloxGui", "SystemSettings", "CoreAnalytics", "SecurityHandler", "DataHub"}
    screenGui.Name = names[math.random(1, #names)] .. "_" .. tostring(math.random(1000, 9999))
end)

local shadow = Instance.new("ImageLabel", mainFrame)
shadow.Size = UDim2.new(1, 40, 1, 40)
shadow.Position = UDim2.new(0, -20, 0, -20)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316115263"
shadow.ImageColor3 = Color3.new(0,0,0)
shadow.ImageTransparency = 0.6
shadow.ZIndex = -1

local function MakeCorner(parent, radius)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, radius)
    return c
end

local function MakeText(parent, text, size, font, align, xOffset)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1, xOffset or 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = cText
    l.TextSize = size
    l.Font = font
    l.TextXAlignment = align
    return l
end

local topbar = Instance.new("Frame", mainFrame)
topbar.Size = UDim2.new(1, 0, 0, 35)
topbar.BackgroundColor3 = cTop
topbar.BorderSizePixel = 0
MakeCorner(topbar, 8)

local tbFix = Instance.new("Frame", topbar)
tbFix.Size = UDim2.new(1, 0, 0, 8)
tbFix.Position = UDim2.new(0, 0, 1, -8)
tbFix.BackgroundColor3 = cTop
tbFix.BorderSizePixel = 0

local title = MakeText(topbar, "ANANİSTAN HUB", 14, Enum.Font.GothamBold, Enum.TextXAlignment.Left)
title.Position = UDim2.new(0, 15, 0, 0)
title.TextColor3 = cAccent


local closeBtn = Instance.new("TextButton", topbar)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 35, 1, 0)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14

local isMinimized = false
local minBtn = Instance.new("TextButton", topbar)
minBtn.Text = "—"
minBtn.Size = UDim2.new(0, 35, 1, 0)
minBtn.Position = UDim2.new(1, -70, 0, 0)
minBtn.BackgroundTransparency = 1
minBtn.TextColor3 = cText
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14

closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    mainFrame.Visible = false
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Ananistan Hub",
            Text = "Hub gizlendi göstermek için insert tuşuna basın",
            Duration = 5
        })
    end)
end)

local beforeMinSize = mainFrame.Size
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        beforeMinSize = mainFrame.Size
        mainFrame.Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 35)
        mainFrame.ClipsDescendants = true
    else
        mainFrame.Size = beforeMinSize
        task.wait(0.1)
        mainFrame.ClipsDescendants = false
    end
end)

local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos
topbar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
local dragInput
topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)


local tabNav = Instance.new("Frame", mainFrame)
tabNav.Size = UDim2.new(1, 0, 0, 30)
tabNav.Position = UDim2.new(0, 0, 0, 35)
tabNav.BackgroundColor3 = cTop
tabNav.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout", tabNav)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 0)

local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(1, -20, 1, -80)
contentArea.Position = UDim2.new(0, 10, 0, 75)
contentArea.BackgroundTransparency = 1

local activeTab = nil
local tabs = {}

local function CreateTab(name)
    local tabBtn = Instance.new("TextButton", tabNav)
    tabBtn.Size = UDim2.new(0.166, 0, 1, 0)
    tabBtn.BackgroundTransparency = 1
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 11
    
    local indicator = Instance.new("Frame", tabBtn)
    indicator.Size = UDim2.new(1, 0, 0, 2)
    indicator.Position = UDim2.new(0, 0, 1, -2)
    indicator.BackgroundColor3 = cAccent
    indicator.BorderSizePixel = 0
    indicator.Visible = false

    local scroll = Instance.new("ScrollingFrame", contentArea)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 4
    scroll.ScrollBarImageColor3 = cAccent
    scroll.Visible = false
    
    local list = Instance.new("UIListLayout", scroll)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 8)
    
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 20)
    end)
    
    local tabData = {Btn = tabBtn, Frame = scroll, Indicator = indicator}
    table.insert(tabs, tabData)
    
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Frame.Visible = false
            t.Indicator.Visible = false
            t.Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
            t.Btn.BackgroundTransparency = 1
        end
        scroll.Visible = true
        indicator.Visible = true
        tabBtn.TextColor3 = cText
        tabBtn.BackgroundColor3 = cTabActive
        tabBtn.BackgroundTransparency = 0
    end)
    
    return scroll, tabData
end


local TweenService = game:GetService("TweenService")
local function AddButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = cElement
    btn.Text = ""
    MakeCorner(btn, 6)
    MakeText(btn, " " .. text, 13, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, -10)
    
    btn.MouseButton1Click:Connect(function() pcall(callback) end)
    return btn
end

local function AddToggle(parent, text, defaultState, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.BackgroundColor3 = cElement
    MakeCorner(frame, 6)
    MakeText(frame, " " .. text, 13, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, -10)
    
    local togBg = Instance.new("Frame", frame)
    togBg.Size = UDim2.new(0, 40, 0, 20)
    togBg.Position = UDim2.new(1, -50, 0.5, -10)
    togBg.BackgroundColor3 = defaultState and cToggleOn or cToggleOff
    MakeCorner(togBg, 10)
    
    local togCircle = Instance.new("Frame", togBg)
    togCircle.Size = UDim2.new(0, 16, 0, 16)
    togCircle.Position = UDim2.new(defaultState and 0.55 or 0.05, 0, 0.5, -8)
    togCircle.BackgroundColor3 = Color3.new(1,1,1)
    MakeCorner(togCircle, 8)
    
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    
    local state = defaultState
    local function UpdateVis()
        TweenService:Create(togBg, TweenInfo.new(0.2), {BackgroundColor3 = state and cToggleOn or cToggleOff}):Play()
        TweenService:Create(togCircle, TweenInfo.new(0.2), {Position = UDim2.new(state and 0.55 or 0.05, 0, 0.5, -8)}):Play()
    end
    
    btn.MouseButton1Click:Connect(function()
        state = not state
        UpdateVis()
        pcall(function() callback(state) end)
    end)
    
    return function(forceState)
        if forceState ~= nil then state = forceState end
        UpdateVis()
    end
end


local colorPickerFrame = Instance.new("Frame", screenGui)
colorPickerFrame.Size = UDim2.new(0, 200, 0, 240)
colorPickerFrame.Position = UDim2.new(0.5, -100, 0.5, -120)
colorPickerFrame.BackgroundColor3 = cTop
colorPickerFrame.Visible = false
colorPickerFrame.ZIndex = 10
MakeCorner(colorPickerFrame, 8)

local pTitle = MakeText(colorPickerFrame, " Renk Seçici", 13, Enum.Font.GothamBold, Enum.TextXAlignment.Left)
pTitle.Size = UDim2.new(1, 0, 0, 25)
pTitle.ZIndex = 11

local closeColorBtn = Instance.new("TextButton", colorPickerFrame)
closeColorBtn.Size = UDim2.new(0, 25, 0, 25)
closeColorBtn.Position = UDim2.new(1, -25, 0, 0)
closeColorBtn.BackgroundTransparency = 1
closeColorBtn.Text = "X"
closeColorBtn.TextColor3 = cAccent
closeColorBtn.Font = Enum.Font.GothamBold
closeColorBtn.ZIndex = 11
closeColorBtn.MouseButton1Click:Connect(function() colorPickerFrame.Visible = false end)

local wheelImg = Instance.new("ImageButton", colorPickerFrame)
wheelImg.Size = UDim2.new(0, 160, 0, 160)
wheelImg.Position = UDim2.new(0.5, -80, 0, 30)
wheelImg.Image = "rbxassetid://6020299385"
wheelImg.BackgroundTransparency = 1
wheelImg.ZIndex = 11

local rgbBox = Instance.new("TextBox", colorPickerFrame)
rgbBox.Size = UDim2.new(0, 160, 0, 30)
rgbBox.Position = UDim2.new(0.5, -80, 1, -40)
rgbBox.BackgroundColor3 = cElement
rgbBox.TextColor3 = cText
rgbBox.Font = Enum.Font.GothamMedium
rgbBox.TextSize = 13
rgbBox.Text = "255, 255, 255"
MakeCorner(rgbBox, 6)
rgbBox.ZIndex = 11

local applyPickedColorCallback = nil

local function hueToRGB(hue, sat, val)
    return Color3.fromHSV(hue, sat, val)
end

wheelImg.MouseButton1Down:Connect(function()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local conn
    local function updateColor()
        local center = wheelImg.AbsolutePosition + wheelImg.AbsoluteSize/2
        local x = mouse.X - center.X
        local y = center.Y - mouse.Y
        local angle = math.atan2(y, x)
        local hue = (angle + math.pi) / (math.pi * 2)
        local rad = math.clamp(math.sqrt(x*x + y*y) / (wheelImg.AbsoluteSize.X/2), 0, 1)
        
        local color = Color3.fromHSV(hue, rad, 1)
        rgbBox.Text = string.format("%d, %d, %d", math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255))
        if applyPickedColorCallback then applyPickedColorCallback(color) end
    end
    updateColor()
    conn = mouse.Move:Connect(updateColor)
    local upConn
    upConn = UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            conn:Disconnect()
            upConn:Disconnect()
        end
    end)
end)

rgbBox.FocusLost:Connect(function()
    local txt = rgbBox.Text
    local split = string.split(txt, ",")
    if #split == 3 then
        local r = tonumber(split[1]:match("%d+"))
        local g = tonumber(split[2]:match("%d+"))
        local b = tonumber(split[3]:match("%d+"))
        if r and g and b then
            local color = Color3.fromRGB(math.clamp(r,0,255), math.clamp(g,0,255), math.clamp(b,0,255))
            if applyPickedColorCallback then applyPickedColorCallback(color) end
        end
    end
end)

local function AddColorPicker(parent, text, defaultColor, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -10, 0, 35)
    frame.BackgroundColor3 = cElement
    MakeCorner(frame, 6)
    MakeText(frame, " " .. text, 13, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, -10)
    
    local cBtn = Instance.new("TextButton", frame)
    cBtn.Size = UDim2.new(0, 30, 0, 20)
    cBtn.Position = UDim2.new(1, -40, 0.5, -10)
    cBtn.BackgroundColor3 = defaultColor
    cBtn.Text = ""
    MakeCorner(cBtn, 6)
    
    cBtn.MouseButton1Click:Connect(function()
        colorPickerFrame.Visible = true
        rgbBox.Text = string.format("%d, %d, %d", math.floor(cBtn.BackgroundColor3.R*255), math.floor(cBtn.BackgroundColor3.G*255), math.floor(cBtn.BackgroundColor3.B*255))
        applyPickedColorCallback = function(col)
            cBtn.BackgroundColor3 = col
            callback(col)
        end
    end)
    
    return function(col) cBtn.BackgroundColor3 = col end
end

local function AddTextBox(parent, placeholder, callback)
    local box = Instance.new("TextBox", parent)
    box.Size = UDim2.new(1, -10, 0, 35)
    box.BackgroundColor3 = cElement
    box.TextColor3 = cText
    box.PlaceholderText = placeholder
    box.Text = "" 
    box.Font = Enum.Font.GothamMedium
    box.TextSize = 13
    box.ClearTextOnFocus = false
    MakeCorner(box, 6)
    
    box.FocusLost:Connect(function() pcall(function() callback(box.Text) end) end)
    return box
end

local function AddSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -10, 0, 45)
    frame.BackgroundColor3 = cElement
    MakeCorner(frame, 6)
    
    local label = MakeText(frame, " " .. text, 12, Enum.Font.GothamMedium, Enum.TextXAlignment.Left, -10)
    label.Size = UDim2.new(1, 0, 0, 20)
    
    local sliderBg = Instance.new("Frame", frame)
    sliderBg.Size = UDim2.new(1, -20, 0, 4)
    sliderBg.Position = UDim2.new(0, 10, 1, -12)
    sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    MakeCorner(sliderBg, 2)
    
    local sliderFill = Instance.new("Frame", sliderBg)
    sliderFill.Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0)
    sliderFill.BackgroundColor3 = cAccent
    MakeCorner(sliderFill, 2)
    
    local sliderBtn = Instance.new("TextButton", sliderBg)
    sliderBtn.Size = UDim2.new(0, 12, 0, 12)
    sliderBtn.Position = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), -6, 0.5, -6)
    sliderBtn.BackgroundColor3 = Color3.new(1,1,1)
    sliderBtn.Text = ""
    MakeCorner(sliderBtn, 6)
    
    local function update(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderBtn.Position = UDim2.new(pos, -6, 0.5, -6)
        local val = math.floor(min + (max - min) * pos)
        callback(val)
    end
    
    local dragging = false
    sliderBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            dragging = true 
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            dragging = false 
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    return function(val)
        local pos = math.clamp((val - min) / (max - min), 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderBtn.Position = UDim2.new(pos, -6, 0.5, -6)
    end
end

local function AddLabel(parent, text, tall)
    local box = Instance.new("TextLabel", parent)
    box.Size = UDim2.new(1, 0, 0, tall and 60 or 25)
    box.BackgroundTransparency = 1
    box.Text = " " .. text
    box.TextColor3 = cText
    box.TextSize = 14
    box.Font = Enum.Font.GothamBold
    box.TextXAlignment = Enum.TextXAlignment.Left
    if tall then 
        box.TextYAlignment = Enum.TextYAlignment.Top
        box.TextWrapped = true
    end
    return box
end

local tabMain, tD1 = CreateTab("Ana Sayfa")
local tabPlayer, tD2 = CreateTab("Oyuncu/Haraket")
local tabUlasim, tD6 = CreateTab("Ulaşım")
local tabSpider, tD5 = CreateTab("Grapple Hook")
local tabVisuals, tD3 = CreateTab("Görseller")
local tabSettings, tD4 = CreateTab("Ayarlar")


AddLabel(tabMain, "Menü Araçları")
AddButton(tabMain, "Infinite Yield", runInfiniteYield)
AddButton(tabMain, "Aimbot", function() pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/WhJDjCag"))() end) end)
AddButton(tabMain, "Remote Spy", function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/InfernusScripts/Ketamine/refs/heads/main/Ketamine.lua"))() end) end)
AddButton(tabMain, "Hub Öldür", function() 
    espEnabled = false
    parachuteEnabled = false
    wallClimbEnabled = false
    fullbrightEnabled = false
    
    if parachuteConnection then parachuteConnection:Disconnect(); parachuteConnection = nil end
    if parachuteTrack then parachuteTrack:Stop(); parachuteTrack = nil end
    if wallClimbConn then wallClimbConn:Disconnect(); wallClimbConn = nil end
    if _G.AnanistanInsert then _G.AnanistanInsert:Disconnect(); _G.AnanistanInsert = nil end
    
    if espLoopThread then task.cancel(espLoopThread); espLoopThread = nil end
    for _, conn in pairs(espConnections) do if conn then conn:Disconnect() end end
    espConnections = {}
    
    clearESP()
    
    local Lighting = game:GetService("Lighting")
    if oldLighting.Brightness then
        Lighting.Brightness = oldLighting.Brightness
        Lighting.ClockTime = oldLighting.ClockTime
        Lighting.FogEnd = oldLighting.FogEnd
        Lighting.GlobalShadows = oldLighting.GlobalShadows
        Lighting.OutdoorAmbient = oldLighting.OutdoorAmbient
    end
    
    if screenGui then screenGui:Destroy(); screenGui = nil end
end)


AddLabel(tabPlayer, "Karakter Modları")
AddToggle(tabPlayer, "Parachute", parachuteEnabled, function(state)
    local fakeBtn = {Text = ""}
    parachuteEnabled = not state
    runParachute(fakeBtn) 
end)

AddButton(tabPlayer, "Görünmezlik", function()
    loadstring(game:HttpGet('https://pastebin.com/raw/3Rnd9rHf'))()
end)

AddButton(tabPlayer, "Invincible Fly", runFly)

AddLabel(tabPlayer, "Kısayollar")
AddToggle(tabPlayer, "Click-Teleport (Ctrl+Tık)", clickTPEnabled, function(s) clickTPEnabled = s end)

AddLabel(tabPlayer, "Güvenlik")
AddToggle(tabPlayer, "Anti-AFK (IDLE Engelleme)", antiAFKEnabled, function(s) toggleAntiAFK(s) end)
AddToggle(tabPlayer, "Anti-Void", false, function(s)
    antiVoidEnabled = s
    if s then startAntiVoid() else stopAntiVoid() end
end)


AddLabel(tabSpider, "Grapple Hook")
AddButton(tabSpider, "Grapple 1 (Çekme)", runSpiderWeb1)
AddButton(tabSpider, "Grapple 2 (Tutunma)", runSpiderWeb2)
AddLabel(tabSpider, "Diğer Grapple Modları")
AddToggle(tabSpider, "Duvara Tırmanma", wallClimbEnabled, function(state)
    local fakeBtn = {Text = ""}
    wallClimbEnabled = not state
    toggleWallClimb(fakeBtn)
end)


AddLabel(tabVisuals, "ESP")
local updateESPUIs = {}

updateESPUIs.master = AddToggle(tabVisuals, "ESP Aktif", espEnabled, function(state)
    espEnabled = state
    if espEnabled then
        for _, conn in pairs(espConnections) do if conn then conn:Disconnect() end end
        espConnections = {}

        local function setupForPlayer(p)
            if p == player then return end
            table.insert(espConnections, p.CharacterAdded:Connect(function(char)
                local root = char:WaitForChild("HumanoidRootPart", 10)
                if root and espEnabled then buildESP(p) end
            end))
            if p.Character then
                pcall(function() buildESP(p) end)
            end
        end

        for _, p in pairs(Players:GetPlayers()) do setupForPlayer(p) end
        table.insert(espConnections, Players.PlayerAdded:Connect(setupForPlayer))
        table.insert(espConnections, Players.PlayerRemoving:Connect(function(p)
            if espObjects[p] then
                if espObjects[p].box then pcall(game.Destroy, espObjects[p].box) end
                if espObjects[p].billboard then pcall(game.Destroy, espObjects[p].billboard) end
                if espObjects[p].highlight then pcall(game.Destroy, espObjects[p].highlight) end
                espObjects[p] = nil
            end
        end))

        if not espLoopThread then
            espLoopThread = task.spawn(function()
                local refreshTimer = 0
                while espEnabled do
                    pcall(updateAllESP)
                    refreshTimer = refreshTimer + 0.2
                    if refreshTimer >= 30 then
                        refreshTimer = 0
                        clearESP()
                    end
                    task.wait(0.2)
                end
            end)
        end
    else
        clearESP()
        if espLoopThread then task.cancel(espLoopThread); espLoopThread = nil end
        for _, conn in pairs(espConnections) do if conn then conn:Disconnect() end end
        espConnections = {}
    end
end)

updateESPUIs.isim = AddToggle(tabVisuals, "İsim Çiz", espShowNames, function(s) espShowNames = s end)
updateESPUIs.health = AddToggle(tabVisuals, "Sağlık Çubuğu", espShowHealth, function(s) espShowHealth = s end)
updateESPUIs.chams = AddToggle(tabVisuals, "Chams", espShowChams, function(s) espShowChams = s end)
updateESPUIs.kutu = AddToggle(tabVisuals, "Kutu (Box)", espShowBoxes, function(s) espShowBoxes = s end)
updateESPUIs.env = AddToggle(tabVisuals, "Envanter Gör", espShowInventory, function(s) espShowInventory = s end)

AddLabel(tabVisuals, "ESP Mesafe Ayarı")
local setDistSlider, distBox
setDistSlider = AddSlider(tabVisuals, "Mesafe (Slider)", 0, 25000, espMaxDistance, function(val)
    espMaxDistance = val
    if distBox then distBox.Text = tostring(val) end
end)
distBox = AddTextBox(tabVisuals, "Mesafe Gir (Sayı)", function(txt)
    local val = tonumber(txt:match("%d+"))
    if val then
        val = math.clamp(val, 0, 25000)
        espMaxDistance = val
        distBox.Text = tostring(val)
        setDistSlider(val)
    end
end)
distBox.Text = tostring(espMaxDistance)

AddLabel(tabVisuals, "ESP Renk Yönetimi")

updateESPUIs.friend = AddToggle(tabVisuals, "Arkadaş Rengi Kullan", espUseFriendColor, function(s) espUseFriendColor = s end)
local setFriendColorUI = AddColorPicker(tabVisuals, "Arkadaş Rengi", espFriendColor, function(c) espFriendColor = c end)


updateESPUIs.customColor = AddToggle(tabVisuals, "ESP Rengi Kullan", espUseCustomColor, function(s)
    espUseCustomColor = s
    if s then 
        espUseTeamColor = false 
        updateESPUIs.teamColor(false)
    end
end)
local setEspColorUI = AddColorPicker(tabVisuals, "ESP Rengi", espCustomColor, function(c) espCustomColor = c; espUseCustomColor = true; espUseTeamColor = false; updateESPUIs.customColor(true); updateESPUIs.teamColor(false) end)

updateESPUIs.teamColor = AddToggle(tabVisuals, "Takım Rengi Kullan", espUseTeamColor, function(s)
    espUseTeamColor = s
    if s then
        espUseCustomColor = false
        updateESPUIs.customColor(false)
    end
end)

AddLabel(tabVisuals, "Çevre")
updateESPUIs.bright = AddToggle(tabVisuals, "FullBright", false, function(state)
    local fakeBtn = {Text = ""}
    fullbrightEnabled = not state
    runFullbright(fakeBtn)
end)


AddLabel(tabSettings, "Menü Tuşları")
AddLabel(tabSettings, "INSERT: Menüyü Gizle/Aç\nW/S: Duvara Tırman (Aktifken)\nGrapple 2: E (Çek) / Q (Sal)", true)

AddLabel(tabUlasim, "Konumum")
local coordLabel = AddLabel(tabUlasim, "X: 0  Y: 0  Z: 0")
RunService.Heartbeat:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root and coordLabel then
        local p = root.Position
        coordLabel.Text = string.format(" X: %.1f  Y: %.1f  Z: %.1f", p.X, p.Y, p.Z)
    end
end)

AddLabel(tabUlasim, "Koordinata Işınlan")
local coordInputFrame = Instance.new("Frame", tabUlasim)
coordInputFrame.Size = UDim2.new(1, -10, 0, 35)
coordInputFrame.BackgroundTransparency = 1

local function CreateCoordBox(label, pos, parent)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(0, 20, 1, 0)
    l.Position = pos
    l.BackgroundTransparency = 1
    l.Text = label
    l.TextColor3 = cText
    l.Font = Enum.Font.GothamBold
    l.TextSize = 14
    
    local b = AddTextBox(parent, "0", function() end)
    b.Size = UDim2.new(0.25, 0, 1, 0)
    b.Position = pos + UDim2.new(0, 20, 0, 0)
    b.Text = "0"
    return b
end

local xBox = CreateCoordBox("X:", UDim2.new(0, 0, 0, 0), coordInputFrame)
local yBox = CreateCoordBox("Y:", UDim2.new(0.33, 0, 0, 0), coordInputFrame)
local zBox = CreateCoordBox("Z:", UDim2.new(0.66, 0, 0, 0), coordInputFrame)

AddButton(tabUlasim, "Işınlan (Koordinat)", function()
    local x = tonumber(xBox.Text)
    local y = tonumber(yBox.Text)
    local z = tonumber(zBox.Text)
    if x and y and z then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(x, y, z)
        end
    end
end)

AddLabel(tabUlasim, "Oyuncuya Işınlan")
AddButton(tabUlasim, "Oyuncu Seç & Işınlan", function()
    local plrs = Players:GetPlayers()
    local choices = {}
    for _, p2 in pairs(plrs) do
        if p2 ~= player then
            table.insert(choices, p2.Name)
        end
    end
    if #choices == 0 then return end
    local target = Players:FindFirstChild(choices[1])
    if target and target.Character then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if root and tRoot then
            root.CFrame = tRoot.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

local tpPlayerBox = AddTextBox(tabUlasim, "Oyuncu İsmi Yaz", function() end)
AddButton(tabUlasim, "İsme Göre Işınlan", function()
    local name = tpPlayerBox.Text
    local target = Players:FindFirstChild(name)
    if target and target.Character then
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        local tRoot = target.Character:FindFirstChild("HumanoidRootPart")
        if root and tRoot then
            root.CFrame = tRoot.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

tD1.Btn.TextColor3 = cText
tD1.Btn.BackgroundColor3 = cTabActive
tD1.Btn.BackgroundTransparency = 0
tD1.Indicator.Visible = true
tD1.Frame.Visible = true

local espToggleKey = Enum.KeyCode.T
local settingESPKey = false

local keyBindBtn = AddButton(tabSettings, "ESP Tuşu: [T]", function() end)
local keyBindLabel = keyBindBtn:FindFirstChildOfClass("TextLabel")

keyBindBtn.MouseButton1Click:Connect(function()
    if settingESPKey then return end
    settingESPKey = true
    if keyBindLabel then keyBindLabel.Text = " Tuşa bas..." end
    local conn
    conn = UIS.InputBegan:Connect(function(inp, gp)
        if inp.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if gp then return end
        espToggleKey = inp.KeyCode
        local keyName = tostring(inp.KeyCode):gsub("Enum.KeyCode.", "")
        if keyBindLabel then keyBindLabel.Text = " ESP Tuşu: [" .. keyName .. "]" end
        settingESPKey = false
        conn:Disconnect()
    end)
end)

if _G.AnanistanInsert then _G.AnanistanInsert:Disconnect() end
_G.AnanistanInsert = UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        screenGui.Enabled = not screenGui.Enabled
        mainFrame.Visible = screenGui.Enabled
    end
    if input.KeyCode == espToggleKey and not settingESPKey then
        espEnabled = not espEnabled
        if updateESPUIs and updateESPUIs.master then
            updateESPUIs.master(espEnabled)
        end
        if espEnabled then
            for _, conn in pairs(espConnections) do if conn then conn:Disconnect() end end
            espConnections = {}
            local function setupForPlayer(p)
                if p == player then return end
                table.insert(espConnections, p.CharacterAdded:Connect(function(char)
                    local root = char:WaitForChild("HumanoidRootPart", 10)
                    if root and espEnabled then buildESP(p) end
                end))
                if p.Character then pcall(function() buildESP(p) end) end
            end
            for _, p in pairs(Players:GetPlayers()) do setupForPlayer(p) end
            table.insert(espConnections, Players.PlayerAdded:Connect(setupForPlayer))
            table.insert(espConnections, Players.PlayerRemoving:Connect(function(p)
                if espObjects[p] then
                    if espObjects[p].box then pcall(game.Destroy, espObjects[p].box) end
                    if espObjects[p].billboard then pcall(game.Destroy, espObjects[p].billboard) end
                    if espObjects[p].highlight then pcall(game.Destroy, espObjects[p].highlight) end
                    espObjects[p] = nil
                end
            end))
            if not espLoopThread then
                espLoopThread = task.spawn(function()
                    local refreshTimer = 0
                    while espEnabled do
                        pcall(updateAllESP)
                        refreshTimer = refreshTimer + 0.2
                        if refreshTimer >= 30 then refreshTimer = 0; clearESP() end
                        task.wait(0.2)
                    end
                end)
            end
        else
            clearESP()
            if espLoopThread then task.cancel(espLoopThread); espLoopThread = nil end
            for _, conn in pairs(espConnections) do if conn then conn:Disconnect() end end
            espConnections = {}
        end
    end
end)

local mouse = player:GetMouse()
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and clickTPEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then
            root.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end
end)

local function toggleAntiAFK(state)
    antiAFKEnabled = state
    if antiAFKEnabled then
        if antiAFKConn then antiAFKConn:Disconnect() end
        antiAFKConn = player.Idled:Connect(function()
            pcall(function()
                local vu = game:GetService("VirtualUser")
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            en
            pcall(function()
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = root.CFrame * CFrame.new(0, 0, 0.01)
                    task.wait(0.1)
                    root.CFrame = root.CFrame * CFrame.new(0, 0, -0.01)
                end
            end)
        end)
    else
        if antiAFKConn then antiAFKConn:Disconnect(); antiAFKConn = nil end
    end
end
