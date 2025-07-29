local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Удаляем старый GUI если он есть
if CoreGui:FindFirstChild("MilediKeyUI") then
    CoreGui.MilediKeyUI:Destroy()
end

-- Создаём GUI
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "MilediKeyUI"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "🔐 Введите ключ"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)

local keyBox = Instance.new("TextBox", frame)
keyBox.PlaceholderText = "Вставьте ключ..."
keyBox.Size = UDim2.new(0.9, 0, 0, 40)
keyBox.Position = UDim2.new(0.05, 0, 0, 50)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextColor3 = Color3.new(0, 0, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 30)
feedback.Position = UDim2.new(0, 0, 0, 95)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
feedback.Font = Enum.Font.GothamBold
feedback.TextSize = 18

local buttonGetKey = Instance.new("TextButton", frame)
buttonGetKey.Text = "Получить ключ"
buttonGetKey.Size = UDim2.new(0.9, 0, 0, 40)
buttonGetKey.Position = UDim2.new(0.05, 0, 0, 130)
buttonGetKey.Font = Enum.Font.GothamBold
buttonGetKey.TextSize = 18
buttonGetKey.TextColor3 = Color3.new(0, 0, 0)
buttonGetKey.BackgroundColor3 = Color3.fromRGB(200, 220, 255)
Instance.new("UICorner", buttonGetKey).CornerRadius = UDim.new(0, 8)

-- Поведение кнопки
buttonGetKey.MouseButton1Click:Connect(function()
    setclipboard("https://playerok.com/profile/MILEDI-STORE/products")
    feedback.Text = "🔗 Скопировано!"
    feedback.TextColor3 = Color3.fromRGB(255, 215, 0)
    wait(2)
    feedback.Text = ""
end)
