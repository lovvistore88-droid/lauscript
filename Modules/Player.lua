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
        local bg = Instance.new("BodyGyro", hrp); bg.Name = "LauGyro"; bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        RunService.Heartbeat:Connect(function()
            if not Config.Fly then return end
            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Camera.CFrame.RightVector end
            bv.Velocity = dir * Config.FlySpeed; bg.CFrame = Camera.CFrame
        end)
    elseif hrp then local b, g = hrp:FindFirstChild("LauFly"), hrp:FindFirstChild("LauGyro"); if b then b:Destroy() end; if g then g:Destroy() end end
end)

RunService.RenderStepped:Connect(function()
    local c = LocalPlayer.Character
    if not c then return end
    local h = c:FindFirstChild("Humanoid")
    if Config.InfJump and h and h:GetState() == Enum.HumanoidStateType.Freefall and UserInputService:IsKeyDown(Enum.KeyCode.Space) then h:ChangeState(Enum.HumanoidStateType.Jumping) end
    if Config.Noclip then for _, part in pairs(c:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = false end end end
    if Config.CrouchSpeed and h and h.MoveDirection.Magnitude > 0 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then h.WalkSpeed = Config.WalkSpeed * 2 end
    if Config.HighJump and h then h.JumpPower = 150 end
    if Config.WalkOnWater then
        for _, part in pairs(c:GetDescendants()) do
            if part:IsA("BasePart") and part.Position.Y < 1 then part.CanCollide = true; part.Velocity = Vector3.new(part.Velocity.X, 0, part.Velocity.Z) end
        end
    end
    if Config.AntiFling then
        for _, part in pairs(c:GetDescendants()) do if part:IsA("BasePart") and part.Velocity.Magnitude > 100 then part.Velocity = Vector3.zero end end
    end
end)
