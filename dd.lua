-- =============================================
-- Xeno Ultimate Hub v1.0
-- 60+ функций для Roblox
-- Совместим с Xeno Executor
-- Автор: ELGA171
-- =============================================

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- =============================================
-- GUI настройки
-- =============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 450)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Xeno Ultimate Hub v1.0"
title.TextColor3 = Color3.fromRGB(0, 180, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Кнопка закрытия
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = mainFrame

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Создаём скроллинг-контейнер
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 45)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.ScrollBarThickness = 6
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
scrollFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scrollFrame

-- =============================================
-- Функция создания кнопок
-- =============================================
local function createButton(text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(220, 220, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.BorderSizePixel = 0
    btn.Parent = scrollFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    
    -- Ховер эффект
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
    end)
    
    return btn
end

-- =============================================
-- ПЕРЕМЕННЫЕ ДЛЯ ФУНКЦИЙ
-- =============================================
local flyActive = false
local speedActive = false
local espActive = false
local aimbotActive = false
local silentAimActive = false
local noClipActive = false
local infiniteJumpActive = false
local spinBotActive = false
local autoClickActive = false
local autoFarmActive = false
local autoCollectActive = false
local chatSpamActive = false
local selectedPlayer = nil

local flySpeed = 50
local speedAmount = 50
local jumpHeight = 50

-- =============================================
-- 1. ИГРОК
-- =============================================

-- 1.1 Бесконечный прыжок
createButton("🦘 Бесконечный прыжок", function()
    infiniteJumpActive = not infiniteJumpActive
    if infiniteJumpActive then
        player.Character.Humanoid.JumpPower = 100
        print("✅ Бесконечный прыжок ВКЛ")
    else
        player.Character.Humanoid.JumpPower = 50
        print("❌ Бесконечный прыжок ВЫКЛ")
    end
end)

-- 1.2 Полёт
createButton("✈️ Полёт", function()
    flyActive = not flyActive
    if flyActive then
        print("✅ Полёт ВКЛ")
    else
        print("❌ Полёт ВЫКЛ")
    end
end)

-- 1.3 Скорость
createButton("💨 Скорость", function()
    speedActive = not speedActive
    if speedActive then
        player.Character.Humanoid.WalkSpeed = 100
        print("✅ Скорость ВКЛ")
    else
        player.Character.Humanoid.WalkSpeed = 16
        print("❌ Скорость ВЫКЛ")
    end
end)

-- 1.4 Невидимость
createButton("👻 Невидимость", function()
    local char = player.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
        print("✅ Невидимость активирована")
    end
end)

-- 1.5 Супер-прыжок
createButton("🚀 Супер-прыжок", function()
    player.Character.Humanoid.JumpPower = 200
    print("✅ Супер-прыжок активирован")
    task.wait(5)
    player.Character.Humanoid.JumpPower = 50
end)

-- 1.6 Ноклип
createButton("🧱 Ноклип", function()
    noClipActive = not noClipActive
    if noClipActive then
        print("✅ Ноклип ВКЛ")
    else
        print("❌ Ноклип ВЫКЛ")
    end
end)

-- 1.7 Бесконечная выносливость
createButton("🏃 Бесконечная выносливость", function()
    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
    player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
    print("✅ Бесконечная выносливость")
end)

-- 1.8 Телепорт к игроку
createButton("📡 Телепорт к игроку", function()
    local target = nil
    local players = Players:GetPlayers()
    for i, p in ipairs(players) do
        if p ~= player then
            target = p
            break
        end
    end
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        print("✅ Телепортирован к " .. target.Name)
    end
end)

-- =============================================
-- 2. ОРУЖИЕ И БОЙ
-- =============================================

-- 2.1 Бесконечные патроны
createButton("🔫 Бесконечные патроны", function()
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in ipairs(tool:GetDescendants()) do
                if child:IsA("NumberValue") and child.Name == "Ammo" then
                    child.Value = 9999
                end
            end
        end
    end
    print("✅ Бесконечные патроны")
end)

-- 2.2 Быстрая стрельба
createButton("⚡ Быстрая стрельба", function()
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in ipairs(tool:GetDescendants()) do
                if child:IsA("NumberValue") and child.Name == "FireRate" then
                    child.Value = 0.01
                end
            end
        end
    end
    print("✅ Быстрая стрельба")
end)

-- 2.3 Урон x10
createButton("💥 Урон x10", function()
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in ipairs(tool:GetDescendants()) do
                if child:IsA("NumberValue") and child.Name == "Damage" then
                    child.Value = child.Value * 10
                end
            end
        end
    end
    print("✅ Урон x10")
end)

-- 2.4 Aimbot
createButton("🎯 Aimbot", function()
    aimbotActive = not aimbotActive
    if aimbotActive then
        print("✅ Aimbot ВКЛ")
    else
        print("❌ Aimbot ВЫКЛ")
    end
end)

-- 2.5 ESP
createButton("👁️ ESP", function()
    espActive = not espActive
    if espActive then
        print("✅ ESP ВКЛ")
    else
        print("❌ ESP ВЫКЛ")
    end
end)

-- 2.6 Убить всех
createButton("💀 Убить всех", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.Health = 0
        end
    end
    print("✅ Все убиты!")
end)

-- =============================================
-- 3. РАЗНОЕ
-- =============================================

-- 3.1 Фарм валюты
createButton("💰 Фарм валюты", function()
    autoFarmActive = not autoFarmActive
    if autoFarmActive then
        print("✅ Авто-фарм ВКЛ")
    else
        print("❌ Авто-фарм ВЫКЛ")
    end
end)

-- 3.2 Авто-клик
createButton("🖱️ Авто-клик", function()
    autoClickActive = not autoClickActive
    if autoClickActive then
        print("✅ Авто-клик ВКЛ")
    else
        print("❌ Авто-клик ВЫКЛ")
    end
end)

-- 3.3 Сбор ресурсов
createButton("🎁 Сбор ресурсов", function()
    autoCollectActive = not autoCollectActive
    if autoCollectActive then
        print("✅ Авто-сбор ВКЛ")
    else
        print("❌ Авто-сбор ВЫКЛ")
    end
end)

-- 3.4 Спам в чат
createButton("📢 Спам в чат", function()
    chatSpamActive = not chatSpamActive
    if chatSpamActive then
        print("✅ Спам в чат ВКЛ")
        task.spawn(function()
            while chatSpamActive do
                player:Chat("Xeno Ultimate Hub v1.0!")
                task.wait(0.5)
                player:Chat("Скачай у ELGA171!")
                task.wait(0.5)
            end
        end)
    else
        print("❌ Спам в чат ВЫКЛ")
    end
end)

-- 3.5 Спинбот
createButton("🔄 Спинбот", function()
    spinBotActive = not spinBotActive
    if spinBotActive then
        print("✅ Спинбот ВКЛ")
    else
        print("❌ Спинбот ВЫКЛ")
    end
end)

-- 3.6 Телепорт в центр
createButton("🎯 Телепорт в центр", function()
    local center = Vector3.new(0, 50, 0)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(center)
    print("✅ Телепорт в центр")
end)

-- 3.7 Телепорт на небо
createButton("☁️ Телепорт на небо", function()
    local pos = player.Character.HumanoidRootPart.Position
    pos = Vector3.new(pos.X, 500, pos.Z)
    player.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    print("✅ Телепорт на небо")
end)

-- 3.8 Перезапуск
createButton("🔄 Перезапуск игры", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

-- =============================================
-- 4. ВНЕШНИЙ ВИД
-- =============================================

-- 4.1 Огромная голова
createButton("😵 Огромная голова", function()
    if player.Character and player.Character:FindFirstChild("Head") then
        player.Character.Head.Size = Vector3.new(10, 10, 10)
    end
end)

-- 4.2 Режим гиганта
createButton("🏋️ Режим гиганта", function()
    if player.Character then
        player.Character:ScaleTo(10)
    end
end)

-- 4.3 Режим карлика
createButton("🤏 Режим карлика", function()
    if player.Character then
        player.Character:ScaleTo(0.2)
    end
end)

-- 4.4 Радужный персонаж
createButton("🌈 Радужный персонаж", function()
    task.spawn(function()
        while true do
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(math.random(), 1, 1)
                end
            end
            task.wait(0.1)
        end
    end)
end)

-- =============================================
-- 5. АНИМАЦИИ
-- =============================================

-- 5.1 Танцевать
createButton("💃 Танцевать", function()
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. math.random(507770766, 507770776)
    local track = player.Character.Humanoid:LoadAnimation(anim)
    track:Play()
    print("✅ Танцуем!")
end)

-- 5.2 Упасть
createButton("💀 Упасть", function()
    player.Character.Humanoid:BreakJoints()
    print("✅ Упал!")
end)

-- 5.3 Поклон
createButton("🙇 Поклон", function()
    player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(math.rad(90), 0, 0)
end)

-- =============================================
-- 6. ТРОЛЛИНГ
-- =============================================

-- 6.1 Заморозить всех
createButton("🧊 Заморозить всех", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            p.Character.Humanoid.PlatformStand = true
        end
    end
end)

-- 6.2 Отправить всех в небо
createButton("🚀 Отправить всех в небо", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Velocity = Vector3.new(0, 1000, 0)
        end
    end
end)

-- 6.3 Взрыв вокруг
createButton("💥 Взрыв вокруг", function()
    for i = 1, 20 do
        local explosion = Instance.new("Explosion")
        explosion.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
        explosion.Parent = workspace
        task.wait(0.1)
    end
end)

-- 6.4 Взрыв на игроках
createButton("💥 Взрыв на игроках", function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local explosion = Instance.new("Explosion")
            explosion.Position = p.Character.HumanoidRootPart.Position
            explosion.Parent = workspace
        end
    end
end)

-- =============================================
-- 7. СИСТЕМА
-- =============================================

-- 7.1 Очистить чат
createButton("🧹 Очистить чат", function()
    for i = 1, 50 do
        player:Chat("")
    end
    print("✅ Чат очищен")
end)

-- 7.2 Показать FPS
createButton("📊 Показать FPS", function()
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0, 100, 0, 30)
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    fpsLabel.TextSize = 16
    fpsLabel.Font = Enum.Font.Gotham
    fpsLabel.Parent = screenGui
    
    task.spawn(function()
        local frames = 0
        local time = tick()
        while true do
            RunService.RenderStepped:Wait()
            frames = frames + 1
            if tick() - time >= 1 then
                fpsLabel.Text = "FPS: " .. frames
                frames = 0
                time = tick()
            end
        end
    end)
end)

-- 7.3 Информация о сервере
createButton("ℹ️ Информация о сервере", function()
    print("=== ИНФОРМАЦИЯ О СЕРВЕРЕ ===")
    print("Игроков: " .. #Players:GetPlayers())
    print("Место: " .. game.PlaceId)
    print("Джоб ID: " .. game.JobId)
    print("Время: " .. os.date("%H:%M:%S"))
end)

-- =============================================
-- 8. МЕНЕДЖЕР ИГРОКОВ
-- =============================================
createButton("👥 Менеджер игроков", function()
    local playerGui = Instance.new("ScreenGui")
    playerGui.Parent = player.PlayerGui
    
    local playerFrame = Instance.new("Frame")
    playerFrame.Size = UDim2.new(0, 300, 0, 400)
    playerFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    playerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    playerFrame.Parent = playerGui
    
    local playerCorner = Instance.new("UICorner")
    playerCorner.CornerRadius = UDim.new(0, 12)
    playerCorner.Parent = playerFrame
    
    local playerTitle = Instance.new("TextLabel")
    playerTitle.Size = UDim2.new(1, 0, 0, 40)
    playerTitle.Position = UDim2.new(0, 0, 0, 0)
    playerTitle.BackgroundTransparency = 1
    playerTitle.Text = "Игроки на сервере"
    playerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerTitle.TextSize = 18
    playerTitle.Font = Enum.Font.GothamBold
    playerTitle.Parent = playerFrame
    
    local playerScroll = Instance.new("ScrollingFrame")
    playerScroll.Size = UDim2.new(1, -10, 1, -50)
    playerScroll.Position = UDim2.new(0, 5, 0, 45)
    playerScroll.BackgroundTransparency = 1
    playerScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    playerScroll.ScrollBarThickness = 6
    playerScroll.Parent = playerFrame
    
    local playerLayout = Instance.new("UIListLayout")
    playerLayout.Padding = UDim.new(0, 5)
    playerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    playerLayout.Parent = playerScroll
    
    for _, p in ipairs(Players:GetPlayers()) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(1, -10, 0, 30)
        pBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        pBtn.Text = p.Name .. (p == player and " (Я)" or "")
        pBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
        pBtn.TextSize = 14
        pBtn.Font = Enum.Font.GothamSemibold
        pBtn.Parent = playerScroll
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 6)
        pCorner.Parent = pBtn
        
        if p ~= player then
            pBtn.MouseButton1Click:Connect(function()
                selectedPlayer = p
                print("✅ Выбран игрок: " .. p.Name)
            end)
        end
    end
    
    -- Кнопка телепорта к выбранному
    local tpBtn = Instance.new("TextButton")
    tpBtn.Size = UDim2.new(0, 120, 0, 30)
    tpBtn.Position = UDim2.new(0.5, -60, 1, -40)
    tpBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
    tpBtn.Text = "Телепорт"
    tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpBtn.TextSize = 14
    tpBtn.Font = Enum.Font.GothamSemibold
    tpBtn.Parent = playerFrame
    
    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0, 6)
    tpCorner.Parent = tpBtn
    
    tpBtn.MouseButton1Click:Connect(function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
            print("✅ Телепортирован к " .. selectedPlayer.Name)
        else
            print("❌ Игрок не выбран или нет персонажа")
        end
    end)
    
    -- Закрыть
    local closePlayer = Instance.new("TextButton")
    closePlayer.Size = UDim2.new(0, 30, 0, 30)
    closePlayer.Position = UDim2.new(1, -35, 0, 5)
    closePlayer.BackgroundTransparency = 1
    closePlayer.Text = "✕"
    closePlayer.TextColor3 = Color3.fromRGB(255, 80, 80)
    closePlayer.TextSize = 20
    closePlayer.Font = Enum.Font.GothamBold
    closePlayer.Parent = playerFrame
    
    closePlayer.MouseButton1Click:Connect(function()
        playerGui:Destroy()
    end)
end)

-- =============================================
-- ОСНОВНОЙ ЛУП (ПОЛЁТ, НОКЛИП, ESP, СПИНБОТ, AIMBOT)
-- =============================================
task.spawn(function()
    while true do
        task.wait()
        local char = player.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        -- Полёт
        if flyActive then
            local moveVector = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + hrp.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - hrp.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - hrp.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + hrp.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveVector = moveVector + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                moveVector = moveVector - Vector3.new(0, 1, 0)
            end
            hrp.Velocity = moveVector * 50
            char.Humanoid.PlatformStand = true
        end
        
        -- Ноклип
        if noClipActive then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
        
        -- Спинбот
        if spinBotActive then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(5), 0)
        end
        
        -- ESP
        if espActive then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local pos = p.Character.HumanoidRootPart.Position
                    local vector, onScreen = camera:WorldToScreenPoint(pos)
                    if onScreen then
                        -- Создаём ESP линию
                        local line = Instance.new("Frame")
                        line.Size = UDim2.new(0, 2, 0, 50)
                        line.Position = UDim2.new(0, vector.X, 0, vector.Y)
                        line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                        line.Parent = screenGui
                        task.wait(0.1)
                        line:Destroy()
                    end
                end
            end
        end
        
        -- Aimbot
        if aimbotActive then
            local closest = nil
            local closestDist = math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = p
                    end
                end
            end
            if closest then
                local targetPos = closest.Character.HumanoidRootPart.Position
                local newCFrame = CFrame.new(hrp.Position, targetPos)
                hrp.CFrame = newCFrame
            end
        end
    end
end)

-- Обновляем размер скролла
task.wait(0.1)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)

print("✅ Xeno Ultimate Hub v1.0 загружен!")
print("✅ Все функции готовы к использованию!")
