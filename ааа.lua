-- =============================================
-- Xeno Mini Hub (рабочая версия)
-- 10 базовых функций
-- =============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Xeno Mini Hub"
title.TextColor3 = Color3.fromRGB(0, 180, 255)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = frame

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 6
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- Функция создания кнопок
local function btn(text, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 14
    b.Font = Enum.Font.GothamSemibold
    b.Parent = scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    b.MouseButton1Click:Connect(callback)
end

-- Переменные
local fly = false
local speed = false
local jump = false

-- Функции
btn("✈️ Полёт", function()
    fly = not fly
    print(fly and "Полёт ВКЛ" or "Полёт ВЫКЛ")
end)

btn("💨 Скорость", function()
    speed = not speed
    if speed then
        player.Character.Humanoid.WalkSpeed = 80
    else
        player.Character.Humanoid.WalkSpeed = 16
    end
    print(speed and "Скорость ВКЛ" or "Скорость ВЫКЛ")
end)

btn("🦘 Прыжок x3", function()
    jump = not jump
    if jump then
        player.Character.Humanoid.JumpPower = 150
    else
        player.Character.Humanoid.JumpPower = 50
    end
    print(jump and "Прыжок ВКЛ" or "Прыжок ВЫКЛ")
end)

btn("👻 Невидимость", function()
    for _, p in ipairs(player.Character:GetDescendants()) do
        if p:IsA("BasePart") then
            p.Transparency = 1
        end
    end
end)

btn("📡 Телепорт к игроку", function()
    local target = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then target = p break end
    end
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    end
end)

btn("🎯 Телепорт в центр", function()
    player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
end)

btn("💀 Убить всех", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0
        end
    end
end)

btn("💃 Танцевать", function()
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://507770771"
    local track = player.Character.Humanoid:LoadAnimation(anim)
    track:Play()
end)

btn("🧹 Очистить чат", function()
    for i = 1, 30 do player:Chat("") end
end)

btn("❌ Закрыть", function()
    gui:Destroy()
end)

-- Основной луп
task.spawn(function()
    while true do
        task.wait()
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        if fly then
            local move = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + hrp.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - hrp.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - hrp.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + hrp.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move - Vector3.new(0, 1, 0) end
            hrp.Velocity = move * 50
            char.Humanoid.PlatformStand = true
        end
    end
end)

scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
print("✅ Xeno Mini Hub загружен!")
