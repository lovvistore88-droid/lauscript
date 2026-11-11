local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("LauDevKey") then CoreGui.LauDevKey:Destroy() end
local Screen = Instance.new("ScreenGui", CoreGui); Screen.Name="LauDevKey"; Screen.ResetOnSpawn=false

local WEB_BASE_URL = "https://laudevhub.vercel.app" 
local SCRIPT_ID = "laudev01" 
local API_VERIFY_URL = WEB_BASE_URL .. "/api/v1/verify"
local API_KEY = "laudev01_live_ac1dffd8df8e0b9f496a748d0d036929e753" 

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 350, 0, 260); Main.Position = UDim2.new(0.5, -175, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 20); Main.BorderSizePixel = 0
Main.BackgroundTransparency = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(255, 80, 120)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.BackgroundTransparency = 1
Title.Text = "Lau Dev - Authentication"; Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 14

local GetKeyBtn = Instance.new("TextButton", Main)
GetKeyBtn.Size = UDim2.new(1, -40, 0, 35); GetKeyBtn.Position = UDim2.new(0, 20, 0, 50)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(45, 40, 45); GetKeyBtn.Text = "1. Ambil Key di Web"
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); GetKeyBtn.Font = Enum.Font.GothamBold; GetKeyBtn.TextSize = 12
Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.MouseButton1Click:Connect(function()
    local gatewayUrl = WEB_BASE_URL .. "/gateway/" .. tostring(LocalPlayer.UserId) .. "/" .. SCRIPT_ID
    pcall(function()
        if setclipboard then setclipboard(gatewayUrl) end
        game:GetService("GuiService"):OpenBrowserWindow(gatewayUrl)
    end)
    GetKeyBtn.Text = "Link Dibuka!"
    GetKeyBtn.TextColor3 = Color3.fromRGB(100, 255, 100)
    task.wait(2)
    GetKeyBtn.Text = "1. Ambil Key di Web"
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

local Box = Instance.new("TextBox", Main)
Box.Size = UDim2.new(1, -40, 0, 35); Box.Position = UDim2.new(0, 20, 0, 100)
Box.BackgroundColor3 = Color3.fromRGB(30, 25, 30); Box.PlaceholderText = "2. Paste Key (LAU-XXXX-XXXX)"
Box.Text = ""; Box.TextColor3 = Color3.fromRGB(255,255,255); Box.PlaceholderColor3 = Color3.fromRGB(150,150,150)
Box.Font = Enum.Font.Gotham; Box.TextSize = 12
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)

local Btn = Instance.new("TextButton", Main)
Btn.Size = UDim2.new(1, -40, 0, 35); Btn.Position = UDim2.new(0, 20, 0, 150)
Btn.BackgroundColor3 = Color3.fromRGB(255, 80, 120); Btn.Text = "3. Login"; Btn.TextColor3 = Color3.fromRGB(255,255,255)
Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 13
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, -40, 0, 30); Status.Position = UDim2.new(0, 20, 0, 200)
Status.BackgroundTransparency = 1; Status.Text = ""; Status.TextColor3 = Color3.fromRGB(255, 100, 100)
Status.Font = Enum.Font.Gotham; Status.TextSize = 11; Status.TextWrapped = true

Main.BackgroundTransparency = 0.1
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 350, 0, 260)}):Play()

local function ShowLoadingAndStart(expireTime)
    TweenService:Create(Main, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    for _, v in pairs(Main:GetDescendants()) do
        if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
            TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        end
    end
    task.wait(0.3)
    Main.Size = UDim2.new(0, 250, 0, 80)
    
    local LoadTitle = Instance.new("TextLabel", Main)
    LoadTitle.Size = UDim2.new(1, 0, 0, 20); LoadTitle.Position = UDim2.new(0, 0, 0, 15); LoadTitle.BackgroundTransparency = 1
    LoadTitle.Text = "MENYIAPKAN SCRIPT..."; LoadTitle.TextColor3 = Color3.fromRGB(255,255,255); LoadTitle.Font = Enum.Font.GothamBold; LoadTitle.TextSize = 12
    LoadTitle.TextTransparency = 1
    TweenService:Create(LoadTitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
    
    local BarBg = Instance.new("Frame", Main)
    BarBg.Size = UDim2.new(0, 200, 0, 4); BarBg.Position = UDim2.new(0.5, -100, 0, 45); BarBg.BackgroundColor3 = Color3.fromRGB(40,40,45)
    Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)
    
    local BarFill = Instance.new("Frame", BarBg)
    BarFill.Size = UDim2.new(0, 0, 1, 0); BarFill.BackgroundColor3 = Color3.fromRGB(255, 80, 120)
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)
    
    TweenService:Create(BarFill, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    task.wait(1.7)
    
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    
    if writefile then
        local cacheData = { userId = tostring(LocalPlayer.UserId), expires = expireTime }
        writefile("LauDev_Cache.txt", HttpService:JSONEncode(cacheData))
    end

    Screen:Destroy()
    if _G.LoadMenuFiles then _G.LoadMenuFiles() end
end

Btn.MouseButton1Click:Connect(function()
    Status.Text = "Menghubungi Server..."
    Status.TextColor3 = Color3.fromRGB(255, 255, 100)
    
    local payload = { userId = tostring(LocalPlayer.UserId), key = string.gsub(Box.Text, "%s+", "") }
    
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = API_VERIFY_URL, Method = "POST",
            Headers = { ["Content-Type"] = "application/json", ["x-api-key"] = API_KEY },
            Body = HttpService:JSONEncode(payload)
        })
    end)
    
    if success and response then
        local data = HttpService:JSONDecode(response.Body)
        if data.status == "success" then
            Status.Text = "Login Berhasil!"; Status.TextColor3 = Color3.fromRGB(100, 255, 100)
            local expireTime = os.time() + (data.remaining_hours * 3600)
            task.wait(0.5); ShowLoadingAndStart(expireTime)
        else
            Status.Text = tostring(data.error or "Key Salah/Expired"); Status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        Status.Text = "Gagal konek ke Web!"; Status.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
