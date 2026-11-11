local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local VirtualUser = game:GetService("VirtualUser")
local Config = _G.LauConfig

local p = _G.GetPage("Combat")
_G.MakeSection(p, "Aimbot Settings")
_G.MakeToggle(p, "Aimbot", "Aimbot")
_G.MakeToggle(p, "Silent Aim", "SilentAim")
_G.MakeToggle(p, "Auto Shoot", "AutoShoot")
_G.MakeToggle(p, "Freeze Target", "FreezeTarget")
_G.MakeToggle(p, "No Recoil", "NoRecoil")
_G.MakeToggle(p, "Auto Reload", "AutoReload")
_G.MakeToggle(p, "Magnet Aim", "MagnetAim")
_G.MakeToggle(p, "Target Prediction", "Prediction")
_G.MakeSlider(p, "FOV", 50, 800, 150, function(v) Config.FOV = v end)
_G.MakeSlider(p, "Smoothness", 1, 10, 2, function(v) Config.Smooth = v / 10 end)

RunService.RenderStepped:Connect(function()
    if (Config.Aimbot or Config.SilentAim) then
        local cl, dist = nil, Config.FOV; local mp = UserInputService:GetMouseLocation()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                local targetPos = plr.Character.Head.Position
                if Config.Prediction and plr.Character:FindFirstChild("HumanoidRootPart") then
                    targetPos = targetPos + (plr.Character.HumanoidRootPart.Velocity * 0.15)
                end
                local sp, on = Camera:WorldToViewportPoint(targetPos)
                if on then local m = (Vector2.new(mp.X, mp.Y) - Vector2.new(sp.X, sp.Y)).Magnitude; if m < dist then dist = m; cl = plr.Character.Head end end
            end
        end
        if cl then 
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, cl.Position), Config.Smooth)
            if Config.MagnetAim and dist < 15 then VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(mp.X, mp.Y)) end
            if Config.AutoShoot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(mp.X, mp.Y)) end
            if Config.FreezeTarget then cl.Anchored = true end
        end
    end
end)
