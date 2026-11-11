local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Lighting = game:GetService("Lighting")
local Config = _G.LauConfig
local ESPObj = {}

local p = _G.GetPage("Visual")
_G.MakeSection(p, "ESP Overlay")
_G.MakeToggle(p, "ESP Enabled", "ESP", function(state)
    for _, tbl in pairs(ESPObj) do if tbl.Box then tbl.Box:Remove() end; if tbl.Name then tbl.Name:Remove() end; if tbl.Dist then tbl.Dist:Remove() end end
    ESPObj = {}
    if state then
        RunService.RenderStepped:Connect(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local head, hrp = plr.Character.Head, plr.Character:FindFirstChild("HumanoidRootPart")
                    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not ESPObj[plr] then
                        ESPObj[plr] = { Box = Drawing.new("Square"), Name = Drawing.new("Text"), Dist = Drawing.new("Text") }
                        ESPObj[plr].Box.Thickness = 1; ESPObj[plr].Box.Color = Color3.fromRGB(255, 80, 120)
                        ESPObj[plr].Name.Size = 14; ESPObj[plr].Name.Center = true; ESPObj[plr].Name.Outline = true; ESPObj[plr].Name.Color = Color3.fromRGB(255, 255, 255)
                        ESPObj[plr].Dist.Size = 12; ESPObj[plr].Dist.Center = true; ESPObj[plr].Dist.Outline = true; ESPObj[plr].Dist.Color = Color3.fromRGB(255, 80, 120)
                    end
                    local obj = ESPObj[plr]; local sp, on = Camera:WorldToViewportPoint(head.Position)
                    if on and myHrp then
                        local dist = math.floor((hrp.Position - myHrp.Position).Magnitude)
                        obj.Name.Visible = Config.ESPName; obj.Name.Text = plr.Name; obj.Name.Position = Vector2.new(sp.X, sp.Y - 25)
                        obj.Dist.Visible = Config.ESPDist; obj.Dist.Text = "["..dist.."m]"; obj.Dist.Position = Vector2.new(sp.X, sp.Y + 20)
                        obj.Box.Visible = Config.ESPBox; local height = (Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 3, 0)).Y - sp.Y); local width = height / 2
                        obj.Box.Size = Vector2.new(width, height); obj.Box.Position = Vector2.new(sp.X - width/2, sp.Y - height/2)
                    else obj.Name.Visible = false; obj.Dist.Visible = false; obj.Box.Visible = false end
                end
            end
        end)
    end
end)
_G.MakeToggle(p, "ESP Name", "ESPName")
_G.MakeToggle(p, "ESP Distance", "ESPDist")
_G.MakeToggle(p, "ESP Box", "ESPBox")

_G.MakeSection(p, "Environment")
_G.MakeToggle(p, "Full Bright", "FullBright", function(s) Lighting.Ambient = s and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70); Lighting.Brightness = s and 2 or 1 end)
_G.MakeToggle(p, "No Fog", "NoFog", function(s) Lighting.FogEnd = s and 100000 or 1000 end)
_G.MakeToggle(p, "FOV Changer", "FOVChanger", function(s) Camera.FieldOfView = s and 120 or 70 end)
_G.MakeToggle(p, "Camera Lock", "CameraLock", function(s) if s then Camera.CameraType = Enum.CameraType.Scriptable else Camera.CameraType = Enum.CameraType.Custom end end)
_G.MakeToggle(p, "Chams (Terang)", "Chams", function(state)
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            if state then local hl = Instance.new("Highlight", plr.Character); hl.Name = "ChamsHL"; hl.FillColor = Color3.fromRGB(255, 0, 0); hl.FillTransparency = 0.5
            else local hl = plr.Character:FindFirstChild("ChamsHL"); if hl then hl:Destroy() end end
        end
    end
end)
_G.MakeToggle(p, "Player Look", "PlayerLook", function(s)
    if s then
        RunService.RenderStepped:Connect(function()
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then plr.Character.Head.CFrame = CFrame.new(plr.Character.Head.Position, Camera.CFrame.Position) end
            end
        end)
    end
end)
