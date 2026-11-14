local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local Config = _G.LauConfig

local LOGO_LINK = "https://cdn.phototourl.com/member/2026-11-13-5bb42a6a-55a1-467f-9802-301fec16ff8c.png"

-- Palet Warna Premium
local Themes = {
    Background = Color3.fromRGB(18, 18, 24),
    Sidebar = Color3.fromRGB(22, 22, 30),
    Element = Color3.fromRGB(30, 30, 40),
    Accent = Color3.fromRGB(255, 60, 120),
    Text = Color3.fromRGB(240, 240, 255),
    SubText = Color3.fromRGB(150, 150, 170)
}

if CoreGui:FindFirstChild("LauDevUI") then CoreGui.LauDevUI:Destroy() end
local Screen = Instance.new("ScreenGui", CoreGui); Screen.Name="LauDevUI"; Screen.ResetOnSpawn=false; Screen.IgnoreGuiInset = true

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 550, 0, 0); Main.Position = UDim2.new(0.5, -275, 0.5, -180)
Main.BackgroundColor3 = Themes.Background; Main.BackgroundTransparency = 0.15; Main.BorderSizePixel = 0; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Themes.Accent; MainStroke.Transparency = 0.5; MainStroke.Thickness = 1.5

-- Animasi Background (Poin 4)
local BgDeco = Instance.new("Frame", Main)
BgDeco.Size = UDim2.new(1, 0, 1, 0); BgDeco.BackgroundTransparency = 1; BgDeco.Parent = Main
local Circle1 = Instance.new("Frame", BgDeco); Circle1.Size = UDim2.new(0, 150, 0, 150); Circle1.BackgroundColor3 = Color3.fromRGB(255, 60, 120); Circle1.BackgroundTransparency = 0.95; Circle1.Position = UDim2.new(0, -50, 0, -50)
Instance.new("UICorner", Circle1).CornerRadius = UDim.new(1, 0)
local Circle2 = Instance.new("Frame", BgDeco); Circle2.Size = UDim2.new(0, 200, 0, 200); Circle2.BackgroundColor3 = Color3.fromRGB(100, 60, 255); Circle2.BackgroundTransparency = 0.95; Circle2.Position = UDim2.new(1, -100, 1, -100)
Instance.new("UICorner", Circle2).CornerRadius = UDim.new(1, 0)

task.spawn(function()
    while Main.Parent do
        TweenService:Create(Circle1, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(1, -100, 0, -50)}):Play()
        TweenService:Create(Circle2, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -50, 1, -100)}):Play()
        task.wait(5)
        TweenService:Create(Circle1, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -50, 0, -50)}):Play()
        TweenService:Create(Circle2, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = UDim2.new(1, -100, 1, -100)}):Play()
        task.wait(5)
    end
end)

local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 45); Top.BackgroundColor3 = Themes.Sidebar; Top.BackgroundTransparency = 0.1; Top.BorderSizePixel = 0; Top.ZIndex = 2
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)

local Txt = Instance.new("TextLabel", Top); Txt.Size = UDim2.new(1, -100, 1, 0); Txt.Position = UDim2.new(0, 15, 0, 0); Txt.BackgroundTransparency = 1
Txt.Text = "LAU DEV | ULTIMATE"; Txt.TextColor3 = Themes.Text; Txt.Font = Enum.Font.GothamBlack; Txt.TextSize = 12; Txt.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", Top); MinBtn.Size = UDim2.new(0, 28, 0, 28); MinBtn.Position = UDim2.new(1, -75, 0.5, -14); MinBtn.BackgroundColor3 = Themes.Element; MinBtn.Text = "—"; MinBtn.TextColor3 = Themes.Text; MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 12
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
local Close = Instance.new("TextButton", Top); Close.Size = UDim2.new(0, 28, 0, 28); Close.Position = UDim2.new(1, -40, 0.5, -14); Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50); Close.Text = "X"; Close.TextColor3 = Themes.Text; Close.Font = Enum.Font.GothamBold; Close.TextSize = 12
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

-- LOGO IMAGE (Pake Link & Bisa Digeser)
local LogoFrame = Instance.new("ImageButton", Screen)
LogoFrame.Name = "LogoFrame"; LogoFrame.Size = UDim2.new(0, 0, 0, 0); LogoFrame.Position = UDim2.new(0, 20, 0, 100)
LogoFrame.BackgroundColor3 = Themes.Background; LogoFrame.BackgroundTransparency = 0.1; LogoFrame.Visible = false
LogoFrame.Image = LOGO_LINK
Instance.new("UICorner", LogoFrame).CornerRadius = UDim.new(1, 0)
local LogoStroke = Instance.new("UIStroke", LogoFrame); LogoStroke.Color = Themes.Accent; LogoStroke.Thickness = 2

local Side = Instance.new("Frame", Main); Side.Size = UDim2.new(0, 150, 1, -45); Side.Position = UDim2.new(0, 0, 0, 45); Side.BackgroundColor3 = Themes.Sidebar; Side.BackgroundTransparency = 0.1; Side.BorderSizePixel = 0; Side.ZIndex = 2
local Layout = Instance.new("UIListLayout", Side); Layout.Padding = UDim.new(0, 4); Layout.SortOrder = Enum.SortOrder.LayoutOrder; Instance.new("UIPadding", Side).PaddingTop = UDim.new(0, 12)

local Content = Instance.new("Frame", Main); Content.Size = UDim2.new(1, -150, 1, -45); Content.Position = UDim2.new(0, 150, 0, 45); Content.BackgroundTransparency = 1; Content.ZIndex = 2
local Pages, Tabs = {}, {}

local function MakePage(name)
    local p = Instance.new("ScrollingFrame", Content); p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.BorderSizePixel = 0; p.ScrollBarThickness = 3; p.ScrollBarImageColor3 = Themes.Accent; p.Visible = false
    local pad = Instance.new("UIPadding", p); pad.PaddingTop = UDim.new(0, 10); pad.PaddingLeft = UDim.new(0, 10); pad.PaddingRight = UDim.new(0, 10)
    local lay = Instance.new("UIListLayout", p); lay.Padding = UDim.new(0, 6); lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 20) end)
    Pages[name] = p
end

local function MakeTab(name)
    local b = Instance.new("TextButton", Side); b.Size = UDim2.new(1, -16, 0, 30); b.BackgroundColor3 = Themes.Element; b.BackgroundTransparency = 1; b.Text = "  " .. name; b.TextColor3 = Themes.SubText; b.Font = Enum.Font.GothamMedium; b.TextSize = 11; b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6); Tabs[name] = b; MakePage(name)
    
    b.MouseEnter:Connect(function() if b.BackgroundTransparency == 1 then TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.8, TextColor3 = Themes.Text}):Play() end end)
    b.MouseLeave:Connect(function() if b.BackgroundTransparency == 0.8 then TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 1, TextColor3 = Themes.SubText}):Play() end end)
    
    b.MouseButton1Click:Connect(function()
        for _, btn in pairs(Tabs) do 
            TweenService:Create(btn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 1, TextColor3 = Themes.SubText}):Play()
            btn.BackgroundColor3 = Themes.Element
        end
        b.BackgroundTransparency = 0; b.BackgroundColor3 = Themes.Accent; b.TextColor3 = Themes.Text
        
        for _, p in pairs(Pages) do p.Visible = false end
        local targetPage = Pages[name]
        targetPage.Visible = true
        targetPage.Position = UDim2.new(0, 10, 0, 0)
        TweenService:Create(targetPage, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    end)
end

function _G.MakeSection(p, text)
    local l = Instance.new("TextLabel", p); l.Size = UDim2.new(1, 0, 0, 20); l.BackgroundTransparency = 1; l.Text = string.upper(text); l.TextColor3 = Themes.Accent; l.Font = Enum.Font.GothamBold; l.TextSize = 10; l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextTransparency = 1; TweenService:Create(l, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
end

function _G.MakeToggle(p, text, key, cb)
    local h = Instance.new("Frame", p); h.Size = UDim2.new(1, 0, 0, 38); h.BackgroundColor3 = Themes.Element; h.BackgroundTransparency = 0.2; Instance.new("UICorner", h).CornerRadius = UDim.new(0, 6)
    local t = Instance.new("TextLabel", h); t.Size = UDim2.new(1, -50, 1, 0); t.Position = UDim2.new(0, 10, 0, 0); t.BackgroundTransparency = 1; t.Text = text; t.TextColor3 = Themes.Text; t.Font = Enum.Font.GothamMedium; t.TextSize = 11; t.TextXAlignment = Enum.TextXAlignment.Left
    local bg = Instance.new("Frame", h); bg.Size = UDim2.new(0, 34, 0, 18); bg.Position = UDim2.new(1, -44, 0.5, -9); bg.BackgroundColor3 = Config[key] and Themes.Accent or Themes.Sidebar; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local cir = Instance.new("Frame", bg); cir.Size = UDim2.new(0, 14, 0, 14); cir.Position = Config[key] and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7); cir.BackgroundColor3 = Themes.Text; Instance.new("UICorner", cir).CornerRadius = UDim.new(1, 0)
    local btn = Instance.new("TextButton", h); btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""
    
    btn.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        TweenService:Create(bg, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Config[key] and Themes.Accent or Themes.Sidebar}):Play()
        TweenService:Create(cir, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = Config[key] and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
        if cb then pcall(cb, Config[key]) end
    end)
end

-- TAB SETUP
MakeTab("Combat"); MakeTab("Visual"); MakeTab("Player"); MakeTab("World"); MakeTab("Bypass")
Tabs["Combat"].BackgroundTransparency = 0; Tabs["Combat"].BackgroundColor3 = Themes.Accent; Tabs["Combat"].TextColor3 = Themes.Text; Pages["Combat"].Visible = true
_G.GetPage = function(name) return Pages[name] end

-- FITUR TAMBAHAN (Poin 9: 20+ Fitur)
local extraFitur = {
    Combat = {"Auto Parry (Blox Fruits)", "Kill Aura", "Auto Combo", "Silent Aim (Universal)", "Aimbot", "Auto Shoot", "No Recoil"},
    Visual = {"Full Bright", "No Fog", "Custom FOV", "X-Ray", "Player Look", "ESP Box", "ESP Line"},
    Player = {"Fly", "Noclip", "Infinite Jump", "High Jump", "Anti-Fling", "Walk on Water", "Speed Hack"},
    World = {"Hitbox Expander", "Anti Void", "Lag Switch", "Fling Player", "Auto Server Hop", "Spam Chat", "Teleport"},
    Bypass = {"Anti-Ban", "Anti-Kick", "FPS Boost", "Anti-AFK", "Hide GUI", "No Clip Camera"}
}

for tab, fiturList in pairs(extraFitur) do
    for _, fiturName in ipairs(fiturList) do
        local key = string.gsub(fiturName, "%s+", "")
        if Config[key] == nil then Config[key] = false end
        _G.MakeToggle(Pages[tab], fiturName, key, function(state)
            -- Logika fitur bisa lo tambahin di sini nanti
        end)
    end
end

-- LOGO DRAG
local drag, ds, sp
LogoFrame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then drag = true; ds = input.Position; sp = LogoFrame.Position end end)
UserInputService.InputChanged:Connect(function(input) if drag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local d = input.Position - ds; LogoFrame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then drag = false end end)

local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    if IsMinimized then return end; IsMinimized = true
    LogoFrame.Position = UDim2.new(0, Main.AbsolutePosition.X, 0, Main.AbsolutePosition.Y)
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.4); Main.Visible = false; LogoFrame.Visible = true
    TweenService:Create(LogoFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 45, 0, 45)}):Play()
end)

LogoFrame.MouseButton1Click:Connect(function()
    if not IsMinimized then return end; IsMinimized = false; LogoFrame.Visible = false; Main.Visible = true
    Main.Size = UDim2.new(0, 0, 0, 0); Main.BackgroundTransparency = 0.15
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 550, 0, 360)}):Play()
end)

Close.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.3); Screen:Destroy() 
end)

local Dragging, DragStart, StartPos
Top.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = true; DragStart = input.Position; StartPos = Main.Position end end)
UserInputService.InputChanged:Connect(function(input) if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then local delta = input.Position - DragStart; Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then Dragging = false end end)

TweenService:Create(Main, TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 550, 0, 360)}):Play()
