local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local validKey = "Playerok MILEDI STORE"

-- === Твой встроенный код, который запустится после правильного ключа ===
local function runMyScript()
    print("✅ Ключ верный. Скрипт запущен!")

    -- Здесь твой скрипт, можешь вставить всё, что нужно:
    local message = Instance.new("Message", workspace)
    message.Text = "Скрипт активирован!"
    wait(3)
    message:Destroy()
end

-- Удалить старый GUI, если был
local oldGui = game:GetService("CoreGui"):FindFirstChild("PlayerokKeyGui")
if oldGui then oldGui:Destroy() end

-- === GUI ===
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PlayerokKeyGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 220)
frame.Position = UDim2.new(0.5, 0, 0.4, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(120, 140, 255)
frame.BackgroundTransparency = 1
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)
Instance.new("UIGradient", frame).Color = ColorSequence.new{
	ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 140, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 220, 255))
}

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 20)
title.BackgroundTransparency = 1
title.Text = "🔐 Введите ключ от Playerok"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 36)
box.Position = UDim2.new(0.1, 0, 0, 80)
box.PlaceholderText = "Вставьте ключ..."
box.Font = Enum.Font.Gotham
box.TextSize = 20
box.TextColor3 = Color3.fromRGB(50, 50, 50)
box.BackgroundColor3 = Color3.fromRGB(230, 230, 255)
Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0, 130)
button.BackgroundColor3 = Color3.fromRGB(160, 200, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.TextColor3 = Color3.fromRGB(30, 30, 30)
button.Text = "Проверить"
Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 0, 180)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.new(1, 1, 1)
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 18

-- Анимация появления
TweenService:Create(frame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

-- Проверка ключа
button.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == validKey then
		feedback.Text = "✅ Ключ верный, загружаем..."
		feedback.TextColor3 = Color3.fromRGB(30, 200, 30)
		wait(1)
		gui:Destroy()
		runMyScript()
	else
		feedback.Text = "❌ Неверный ключ"
		feedback.TextColor3 = Color3.fromRGB(200, 40, 40)
	end
end)

-- Закрытие ESC
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.Escape then
		gui:Destroy()
	end
end)
