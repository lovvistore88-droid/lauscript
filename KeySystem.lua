local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("LauDevKey") then CoreGui.LauDevKey:Destroy() end
local Screen = Instance.new("ScreenGui", CoreGui); Screen.Name="LauDevKey"; Screen.ResetOnSpawn=false

-- ==========================================
-- ATUR SECRET KEY (JANGAN KASIH TAU SIAPA-SIAPA)
-- ==========================================
local SECRET_SALT = "LauDevSniperArena2026" 

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 320, 0, 230); Main.Position = UDim2.new(0.5, -160, 0.5, -115)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 20); Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 80, 120)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.BackgroundTransparency = 1
Title.Text = "Lau Dev - Authentication"; Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 14

local GetKeyBtn = Instance.new("TextButton", Main)
GetKeyBtn.Size = UDim2.new(1, -40, 0, 25); GetKeyBtn.Position = UDim2.new(0, 20, 0, 40)
GetKeyBtn.BackgroundTransparency = 1; GetKeyBtn.Text = "Klik disini untuk Copy Key kamu"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 150, 150); GetKeyBtn.Font = Enum.Font.GothamMedium; GetKeyBtn.TextSize = 11

GetKeyBtn.MouseButton1Click:Connect(function()
    local raw = tostring(LocalPlayer.UserId) .. SECRET_SALT
    local hash = 0
    for i = 1, #raw do
        hash = (hash * 31 + string.byte(raw, i)) % 9999999
    end
    local myKey = "LAU-" .. string.format("%07d", hash)
    
    if setclipboard then
        setclipboard(myKey)
        GetKeyBtn.Text = "Key Copied: " .. myKey
        GetKeyBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(2)
        GetKeyBtn.Text = "Klik disini untuk Copy Key kamu"
        GetKeyBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
    end
end)

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(1, -40, 0, 35); Box.Position = UDim2.new(0, 20, 0, 80)
Box.BackgroundColor3 = Color3.fromRGB(30, 25, 30); Box.PlaceholderText = "Masukkan Key..."
Box.Text = ""; Box.TextColor3 = Color3.fromRGB(255,255,255); Box.PlaceholderColor3 = Color3.fromRGB(150,150,150)
Box.Font = Enum.Font.Gotham; Box.TextSize = 12
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(1, -40, 0, 35); Btn.Position = UDim2.new(0, 20, 0, 130)
Btn.BackgroundColor3 = Color3.fromRGB(255, 80, 120); Btn.Text = "Login"; Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 13
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, -40, 0, 30); Status.Position = UDim2.new(0, 20, 0, 175)
Status.BackgroundTransparency = 1; Status.Text = ""; Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.Gotham; Status.TextSize = 11

Btn.MouseButton1Click:Connect(function()
    Status.Text = "Checking Key..."
    Status.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    local raw = tostring(LocalPlayer.UserId) .. SECRET_SALT
    local hash = 0
    for i = 1, #raw do
        hash = (hash * 31 + string.byte(raw, i)) % 9999999
    end
    local expectedKey = "LAU-" .. string.format("%07d", hash)
    local inputKey = string.gsub(Box.Text, "%s+", "")
    
    if inputKey == expectedKey then
        Status.Text = "Login Berhasil!"
        Status.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(1)
        Screen:Destroy()
        if _G.StartScript then _G.StartScript() end
    else
        Status.Text = "Key Salah / Invalid!"
        Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
