local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Config = _G.LauConfig

local p = _G.GetPage("Player")
_G.MakeSection(p, "Basic Movement")
_G.MakeSlider(p, "WalkSpeed", 16, 200, 16, function(v) Config.WalkSpeed = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end end)
_G.MakeSlider(p, "JumpPower", 50, 300, 50, function(v) Config.JumpPower = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = v end end)
_G.MakeToggle(p, "Infinite Jump", "InfJump")
_G.MakeToggle(p, "Noclip", "Noclip")

_G.MakeSection(p, "Advanced Movement")
_G.MakeToggle(p, "Crouch Speed", "CrouchSpeed")
_G.MakeToggle(p, "High Jump", "HighJump")
_G.MakeToggle(p, "Walk On Water", "WalkOnWater")
_G.MakeToggle(p, "Anti-Fling", "AntiFling")
_G.MakeToggle(p, "Fly Mode", "Fly", function(state)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if state and hrp then
        local bv = Instance.new("BodyVelocity", hrp); bv.Name = "LauFly"; bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        local bg = Instance.new("BodyGyro", hrp); bg.Name = "
