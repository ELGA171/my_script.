[14.08.2026 16:58] .: --[[
    MM2 STYLE DEBUG / ADMIN PANEL
    Для собственной Roblox Studio игры
    60+ функций
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local Config = {
    WalkSpeed = 16,
    JumpPower = 50,
    Gravity = 196.2,
    DebugMode = true,
    Notifications = true
}

--==================================================
-- UTILITY
--==================================================

local function Character()
    return Player.Character
end

local function Humanoid()
    local c = Character()
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function Root()
    local c = Character()
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function Notify(text)
    if not Config.Notifications then return end
    print("[MM2 DEBUG] " .. tostring(text))
end

local function SetWalkSpeed(value)
    Config.WalkSpeed = value
    local h = Humanoid()
    if h then h.WalkSpeed = value end
end

local function SetJumpPower(value)
    Config.JumpPower = value
    local h = Humanoid()
    if h then
        h.UseJumpPower = true
        h.JumpPower = value
    end
end

--==================================================
-- PLAYER FUNCTIONS
--==================================================

local Functions = {}

Functions.ResetCharacter = function()
    local h = Humanoid()
    if h then h.Health = 0 end
end

Functions.SetSpeed = function()
    SetWalkSpeed(50)
end

Functions.ResetSpeed = function()
    SetWalkSpeed(16)
end

Functions.SuperSpeed = function()
    SetWalkSpeed(100)
end

Functions.SetJump = function()
    SetJumpPower(100)
end

Functions.HighJump = function()
    SetJumpPower(150)
end

Functions.ResetJump = function()
    SetJumpPower(50)
end

Functions.Heal = function()
    local h = Humanoid()
    if h then h.Health = h.MaxHealth end
end

Functions.Damage = function()
    local h = Humanoid()
    if h then h:TakeDamage(25) end
end

Functions.FullHealth = function()
    local h = Humanoid()
    if h then
        h.MaxHealth = 100
        h.Health = 100
    end
end

Functions.LowGravity = function()
    workspace.Gravity = 50
end

Functions.NormalGravity = function()
    workspace.Gravity = 196.2
end

Functions.HighGravity = function()
    workspace.Gravity = 400
end

Functions.Sit = function()
    local h = Humanoid()
    if h then h.Sit = true end
end

Functions.Jump = function()
    local h = Humanoid()
    if h then h.Jump = true end
end

Functions.PlatformStand = function()
    local h = Humanoid()
    if h then h.PlatformStand = true end
end

Functions.UnPlatformStand = function()
    local h = Humanoid()
    if h then h.PlatformStand = false end
end

--==================================================
-- CHARACTER DEBUG
--==================================================

Functions.PrintCharacter = function()
    local c = Character()
    if not c then return end

    for _, obj in ipairs(c:GetChildren()) do
        print(obj.Name, obj.ClassName)
    end
end

Functions.PrintPosition = function()
    local r = Root()
    if r then
        print("Position:", r.Position)
    end
end

Functions.PrintVelocity = function()
    local r = Root()
    if r then
        print("Velocity:", r.AssemblyLinearVelocity)
    end
end

Functions.LockPosition = function()
    local r = Root()
    if r then
        r.Anchored = true
    end
end

Functions.UnlockPosition = function()
    local r = Root()
    if r then
        r.Anchored = false
    end
end

Functions.InvisibleDebug = function()
    local c = Character()
    if not c then return end

    for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0.5
        end
    end
end

Functions.VisibleDebug = function()
    local c = Character()
    if not c then return end
[14.08.2026 16:58] .: for _, obj in ipairs(c:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0
        end
    end
end

--==================================================
-- MM2 ROLE TESTING
--==================================================

local CurrentRole = "Survivor"

Functions.SetSurvivor = function()
    CurrentRole = "Survivor"
    Notify("Role = Survivor")
end

Functions.SetMurderer = function()
    CurrentRole = "Murderer"
    Notify("Role = Murderer")
end

Functions.SetSheriff = function()
    CurrentRole = "Sheriff"
    Notify("Role = Sheriff")
end

Functions.SetHero = function()
    CurrentRole = "Hero"
    Notify("Role = Hero")
end

Functions.GetRole = function()
    print("Current role:", CurrentRole)
end

Functions.PrintRoles = function()
    print("Player:", Player.Name)
    print("Role:", CurrentRole)
end

Functions.ResetRole = function()
    CurrentRole = "Survivor"
end

--==================================================
-- ROUND DEBUG
--==================================================

local RoundState = "Waiting"

Functions.StartRound = function()
    RoundState = "Playing"
    Notify("Round started")
end

Functions.EndRound = function()
    RoundState = "Ended"
    Notify("Round ended")
end

Functions.ResetRound = function()
    RoundState = "Waiting"
    Notify("Round reset")
end

Functions.GetRoundState = function()
    print("Round:", RoundState)
end

Functions.RoundPlaying = function()
    return RoundState == "Playing"
end

Functions.RoundWaiting = function()
    return RoundState == "Waiting"
end

Functions.RoundEnded = function()
    return RoundState == "Ended"
end

--==================================================
-- MAP DEBUG
--==================================================

Functions.ListMaps = function()
    local maps = workspace:FindFirstChild("Maps")

    if not maps then
        warn("Workspace.Maps not found")
        return
    end

    for _, map in ipairs(maps:GetChildren()) do
        print("Map:", map.Name)
    end
end

Functions.ListWorkspace = function()
    for _, obj in ipairs(workspace:GetChildren()) do
        print(obj.Name, obj.ClassName)
    end
end

Functions.ListPlayers = function()
    for _, p in ipairs(Players:GetPlayers()) do
        print(p.Name, p.UserId)
    end
end

Functions.GetPlayerCount = function()
    print("Players:", #Players:GetPlayers())
end

--==================================================
-- TELEPORT DEBUG
--==================================================

Functions.TeleportSpawn = function()
    local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation")

    if spawn and Root() then
        Root().CFrame = spawn.CFrame + Vector3.new(0, 3, 0)
    end
end

Functions.TeleportOrigin = function()
    local r = Root()
    if r then
        r.CFrame = CFrame.new(0, 10, 0)
    end
end

Functions.TeleportAbove = function()
    local r = Root()
    if r then
        r.CFrame += Vector3.new(0, 50, 0)
    end
end

Functions.TeleportDown = function()
    local r = Root()
    if r then
        r.CFrame += Vector3.new(0, -20, 0)
    end
end

--==================================================
-- LIGHTING DEBUG
--==================================================

Functions.Day = function()
    Lighting.ClockTime = 14
end

Functions.Night = function()
    Lighting.ClockTime = 0
end

Functions.Sunset = function()
    Lighting.ClockTime = 18
end

Functions.Morning = function()
    Lighting.ClockTime = 7
end

Functions.BrightLighting = function()
    Lighting.Brightness = 5
end

Functions.NormalLighting = function()
    Lighting.Brightness = 2
end

--==================================================
-- TOOLS / INVENTORY DEBUG
--==================================================

Functions.ListTools = function()
    for _, obj in ipairs(Player.Backpack:GetChildren()) do
        if obj:IsA("Tool") then
            print("Tool:", obj.Name)
        end
    end
end

Functions.EquipFirstTool = function()
    local h = Humanoid()
    local tool = Player.Backpack:FindFirstChildWhichIsA("Tool")
[14.08.2026 16:58] .: if h and tool then
        h:EquipTool(tool)
    end
end

Functions.UnequipTools = function()
    local h = Humanoid()
    if h then
        h:UnequipTools()
    end
end

Functions.ClearTools = function()
    for _, obj in ipairs(Player.Backpack:GetChildren()) do
        if obj:IsA("Tool") then
            obj:Destroy()
        end
    end
end

--==================================================
-- DEBUG INFO
--==================================================

Functions.PlayerInfo = function()
    print("Name:", Player.Name)
    print("DisplayName:", Player.DisplayName)
    print("UserId:", Player.UserId)
    print("AccountAge:", Player.AccountAge)
end

Functions.CharacterInfo = function()
    local c = Character()
    if not c then return end

    print("Character:", c.Name)

    local h = Humanoid()
    if h then
        print("Health:", h.Health)
        print("MaxHealth:", h.MaxHealth)
        print("WalkSpeed:", h.WalkSpeed)
        print("JumpPower:", h.JumpPower)
    end
end

Functions.GameInfo = function()
    print("PlaceId:", game.PlaceId)
    print("GameId:", game.GameId)
    print("JobId:", game.JobId)
end

Functions.MemoryInfo = function()
    print("Memory:", gcinfo())
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MM2DebugPanel"
Gui.ResetOnSpawn = false
Gui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 400, 0, 500)
Main.Position = UDim2.new(0.5, -200, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.Parent = Gui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "MM2 DEBUG PANEL — 60+ FUNCTIONS"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.Parent = Main

local Scroll = Instance.new("ScrollingFrame")
Scroll.Position = UDim2.new(0, 10, 0, 55)
Scroll.Size = UDim2.new(1, -20, 1, -65)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.ScrollBarThickness = 8
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.Parent = Scroll

local count = 0

for name, callback in pairs(Functions) do
    count += 1

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Text = name
    Button.TextScaled = true
    Button.Parent = Scroll

    Button.MouseButton1Click:Connect(function()
        local success, err = pcall(callback)

        if not success then
            warn("[MM2 DEBUG ERROR]", name, err)
        else
            Notify("Executed: " .. name)
        end
    end)
end

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(
        0,
        0,
        0,
        Layout.AbsoluteContentSize.Y + 10
    )
end)

--==================================================
-- KEYBINDS
--==================================================

local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.F1 then
        Main.Visible = not Main.Visible
    end

    if input.KeyCode == Enum.KeyCode.F2 then
        Functions.SetSpeed()
    end

    if input.KeyCode == Enum.KeyCode.F3 then
        Functions.Heal()
    end

    if input.KeyCode == Enum.KeyCode.F4 then
        Functions.SetSurvivor()
    end
end)

Notify("MM2 Debug Panel loaded")
print("Functions loaded:", count)
print("Press F1 to open/close panel")
