local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game.Players.LocalPlayer
local Config = _G.LauConfig

-- Palet Warna Premium
local Themes = {
    Background = Color3.fromRGB(18, 18, 24),
    Sidebar = Color3.fromRGB(22, 22, 30),
    Element = Color3.fromRGB(30, 30, 40),
    Accent = Color3.fromRGB(255, 60, 120), -- Pink Neon
    Text = Color3.fromRGB(240, 240, 255),
    SubText = Color3.fromRGB(150, 150, 170)
}

if CoreGui:FindFirstChild("LauDevUI") then CoreGui.LauDevUI:Destroy() end
local Screen = Instance.new("ScreenGui", CoreGui); Screen.Name="LauDevUI"; Screen.ResetOnSpawn=false; Screen.IgnoreGuiInset = true

-- MAIN FRAME (Glassmorphism style)
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 550, 0, 0); Main.Position = UDim2.new(0.5, -275, 0.5, -180)
Main.BackgroundColor3 = Themes.Background; Main.BackgroundTransparency = 0.15 
Main.BorderSizePixel = 0; Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main); MainStroke.Color = Themes.Accent; MainStroke.Transparency = 0.5; MainStroke.Thickness = 1.5

-- TOP BAR
local Top = Instance.new("Frame", Main); Top.Size = UDim2.new(1, 0, 0, 50); Top.BackgroundColor3 = Themes.Sidebar; Top.BackgroundTransparency = 0.1; Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 12)

local Txt = Instance.new("TextLabel", Top); Txt.Size = UDim2.new(1, -100, 1, 0); Txt.Position = UDim2.new(0, 20, 0, 0); Txt.BackgroundTransparency = 1
Txt.Text = "LAU DEV | INTERNATIONAL"; Txt.TextColor3 = Themes.Text; Txt.Font = Enum.Font.GothamBlack; Txt.TextSize = 14; Txt.TextXAlignment = Enum.TextXAlignment.Left
local TxtAccent = Instance.new("TextLabel", Top); TxtAccent.Size = UDim2.new(1, -100, 1, 0); TxtAccent.Position = UDim2.new(0, 190, 0, 0); TxtAccent.BackgroundTransparency = 1
TxtAccent.Text = "v2.0"; TxtAccent.TextColor3 = Themes.Accent; TxtAccent.Font = Enum.Font.GothamBold; TxtAccent.TextSize = 12; TxtAccent.TextXAlignment = Enum.TextXAlignment.Left

-- TOMBOL CLOSE & MINIMIZE
local MinBtn = Instance.new("TextButton", Top); MinBtn.Size = UDim2.new(0, 30, 0, 30); MinBtn.Position = UDim2.new(1, -80, 0.5, -15); MinBtn.BackgroundColor3 = Themes.Element; MinBtn.Text = "—"; MinBtn.TextColor3 = Themes.Text; MinBtn.Font = Enum.Font.GothamBold; MinBtn.TextSize = 14
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)
local Close = Instance.new("TextButton", Top); Close.Size = UDim2.new(0, 30, 0, 30); Close.Position = UDim2.new(1, -45, 0.5, -15); Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50); Close.Text = "X"; Close.TextColor3 = Themes.Text; Close.Font = Enum.Font.GothamBold
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)

-- LOGO (Teks L)
local LogoFrame = Instance.new("TextButton", Screen)
LogoFrame.Name = "LogoFrame"; LogoFrame.Size = UDim2.new(0, 0, 0, 0); LogoFrame.Position = UDim2.new(0, 20, 0, 100)
LogoFrame.BackgroundColor3 = Themes.Background; LogoFrame.BackgroundTransparency = 0.1; LogoFrame.Visible = false
LogoFrame.Text = "L"; LogoFrame.TextColor3 = Themes.Accent; LogoFrame.Font = Enum.Font.GothamBlack; LogoFrame.TextSize = 24
Instance.new("UICorner", LogoFrame).CornerRadius = UDim.new(1, 0)
local LogoStroke = Instance.new("UIStroke", LogoFrame); LogoStroke.Color = Themes.Accent; LogoStroke.Thickness = 2

-- SIDEBAR
local Side = Instance.new("Frame", Main); Side.Size = UDim2.new(0, 150, 1, -50); Side.Position = UDim2.new(0, 0, 0, 50); Side.BackgroundColor3 = Themes.Sidebar; Side.BackgroundTransparency = 0.1; Side.BorderSizePixel = 0
local Layout = Instance.new("UIListLayout", Side); Layout.Padding = UDim.new(0, 5); Layout.SortOrder = Enum.SortOrder.LayoutOrder; Instance.new("UIPadding", Side).PaddingTop = UDim.new(0, 15)

local Content = Instance.new("Frame", Main); Content.Size = UDim2.new(1, -150, 1, -50); Content.Position = UDim2.new(0, 150, 0, 50); Content.BackgroundTransparency = 1
local Pages, Tabs = {}, {}

local function MakePage(name)
    local p = Instance.new("ScrollingFrame", Content); p.Size = UDim2.new(1, 0, 1, 0); p.BackgroundTransparency = 1; p.BorderSizePixel = 0; p.ScrollBarThickness = 3; p.ScrollBarImageColor3 = Themes.Accent; p.Visible = false
    local pad = Instance.new("UIPadding", p); pad.PaddingTop = UDim.new(0, 15); pad.PaddingLeft = UDim.new(0, 15); pad.PaddingRight = UDim.new(0, 15)
    local lay = Instance.new("UIListLayout", p); lay.Padding = UDim.new(0, 8); lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() p.CanvasSize = UDim2.new(0, 0, 0, lay.AbsoluteContentSize.Y + 20) end)
    Pages[name] = p
end

local function MakeTab(name)
    local b = Instance.new("TextButton", Side); b.Size = UDim2.new(1, -20, 0, 35); b.BackgroundColor3 = Themes.Element; b.BackgroundTransparency = 1; b.Text = "  " .. name; b.TextColor3 = Themes.SubText; b.Font = Enum.Font.GothamMedium; b.TextSize = 13; b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8); Tabs[name] = b; MakePage(name)
    
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
        targetPage.Position = UDim2.new(0, 15, 0, 0)
        TweenService:Create(targetPage, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    end)
end

function _G.MakeSection(p, text)
    local l = Instance.new("TextLabel", p); l.Size = UDim2.new(1, 0, 0, 25); l.BackgroundTransparency = 1; l.Text = string.upper(text); l.TextColor3 = Themes.Accent; l.Font = Enum.Font.GothamBold; l.TextSize = 12; l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextTransparency = 1; TweenService:Create(l, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
end

function _G.MakeToggle(p, text, key, cb)
    local h = Instance.new("Frame", p); h.Size = UDim2.new(1, 0, 0, 45); h.BackgroundColor3 = Themes.Element; h.BackgroundTransparency = 0.2; Instance.new("UICorner", h).CornerRadius = UDim.new(0, 8)
    local t = Instance.new("TextLabel", h); t.Size = UDim2.new(1, -60, 1, 0); t.Position = UDim2.new(0, 15, 0, 0); t.BackgroundTransparency = 1; t.Text = text; t.TextColor3 = Themes.Text; t.Font = Enum.Font.GothamMedium; t.TextSize = 13; t.TextXAlignment = Enum.TextXAlignment.Left
    local bg = Instance.new("Frame", h); bg.Size = UDim2.new(0, 40, 0, 20); bg.Position = UDim2.new(1, -55, 0.5, -10); bg.BackgroundColor3 = Config[key] and Themes.Accent or Themes.Sidebar; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local cir = Instance.new("Frame", bg); cir.Size = UDim2.new(0, 16, 0, 16); cir.Position = Config[key] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8); cir.BackgroundColor3 = Themes.Text; Instance.new("UICorner", cir).CornerRadius = UDim.new(1, 0)
    local btn = Instance.new("TextButton", h); btn.Size = UDim2.new(1, 0, 1, 0); btn.BackgroundTransparency = 1; btn.Text = ""
    
    btn.MouseButton1Click:Connect(function()
        Config[key] = not Config[key]
        TweenService:Create(bg, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Config[key] and Themes.Accent or Themes.Sidebar}):Play()
        TweenService:Create(cir, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Position = Config[key] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        if cb then pcall(cb, Config[key]) end
    end)
end

function _G.MakeSlider(p, text, min, max, def, cb)
    local h = Instance.new("Frame", p); h.Size = UDim2.new(1, 0, 0, 50); h.BackgroundColor3 = Themes.Element; h.BackgroundTransparency = 0.2; Instance.new("UICorner", h).CornerRadius = UDim.new(0, 8)
    local t = Instance.new("TextLabel", h); t.Size = UDim2.new(1, -20, 0, 20); t.Position = UDim2.new(0, 15, 0, 8); t.BackgroundTransparency = 1; t.Text = text .. ": " .. def; t.TextColor3 = Themes.Text; t.Font = Enum.Font.GothamMedium; t.TextSize = 13; t.TextXAlignment = Enum.TextXAlignment.Left
    
    local bar = Instance.new("Frame", h); bar.Size = UDim2.new(1, -30, 0, 5); bar.Position = UDim2.new(0, 15, 0, 35); bar.BackgroundColor3 = Themes.Sidebar; Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame", bar); fill.Size = UDim2.new((def-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Themes.Accent; Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local dragging = false
    
    local function up(inp)
        local rel = math.clamp((inp.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (max-min)*rel + 0.5); t.Text = text .. ": " .. val; fill.Size = UDim2.new(rel, 0, 1, 0); pcall(cb, val)
    end
    
    bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true; up(i) end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then up(i) end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

MakeTab("Combat"); MakeTab("Visual"); MakeTab("Player"); MakeTab("World"); MakeTab("Bypass")
Tabs["Combat"].BackgroundTransparency = 0; Tabs["Combat"].BackgroundColor3 = Themes.Accent; Tabs["Combat"].TextColor3 = Themes.Text; Pages["Combat"].Visible = true
_G.GetPage = function(name) return Pages[name] end

local IsMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    if IsMinimized then return end; IsMinimized = true
    LogoFrame.Position = UDim2.new(0, Main.AbsolutePosition.X, 0, Main.AbsolutePosition.Y)
    
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1
    }):Play()
    
    task.wait(0.4); Main.Visible = false; LogoFrame.Visible = true
    
    TweenService:Create(LogoFrame, TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 45, 0, 45)
    }):Play()
end)

LogoFrame.MouseButton1Click:Connect(function()
    if not IsMinimized then return end; IsMinimized = false; LogoFrame.Visible = false; Main.Visible = true
    
    Main.Size = UDim2.new(0, 0, 0, 0); Main.BackgroundTransparency = 0.15
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 550, 0, 360)
    }):Play()
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
