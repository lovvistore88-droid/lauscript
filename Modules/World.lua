local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local Config = _G.LauConfig

local p = _G.GetPage("World")
_G.MakeSection(p, "Server & World")
_G.MakeToggle(p, "Anti AFK", "AntiAfk", function(s) 
    if s then LocalPlayer.Idled:Connect(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end) end 
end)
_G.MakeToggle(p, "Anti Void", "AntiVoid", function(s)
    RunService.Heartbeat:Connect(function() if s and LocalPlayer.Character then local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart"); if hrp and hrp.Position.Y < -50 then hrp.CFrame = CFrame.new(0, 50, 0) end end end)
end)
_G.MakeToggle(p, "Auto Server Hop", "AutoServerHop")
_G.MakeToggle(p, "Lag Switch", "LagSwitch", function(s)
    if s then task.spawn(function() while Config.LagSwitch do local start = tick(); while tick() - start < 0.1 do end; task.wait() end end) end
end)

_G.MakeSection(p, "Exploits")
_G.MakeToggle(p, "Hitbox Expander", "Hitbox")
_G.MakeSlider(p, "Hitbox Size", 2, 20, 5, function(v) 
    Config.HitboxSize = v
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then local hrp = plr.Character:FindFirstChild("HumanoidRootPart"); if hrp and Config.Hitbox then hrp.Size = Vector3.new(v, v, v) end end
    end
end)
_G.MakeToggle(p, "Fling Player", "Fling", function(s)
    if s then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart; hrp.Velocity = Vector3.new(math.random(-1000, 1000), 1000, math.random(-1000, 1000))
            end
        end
    end
end)
_G.MakeToggle(p, "Spam Chat", "SpamChat", function(s)
    if s then task.spawn(function() while Config.SpamChat do game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Lau Dev On Top!", "All"); task.wait(1) end end) end
end)

local btn = Instance.new("TextButton", p); btn.Size = UDim2.new(1, 0, 0, 35); btn.BackgroundColor3 = Color3.fromRGB(255, 80, 120); btn.Text = "Server Hop (Pindah Server)"; btn.TextColor3 = Color3.fromRGB(255,255,255); btn.Font = Enum.Font.GothamBold; btn.TextSize = 12
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
    local ok, res = pcall(function() return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")) end)
    if ok and res and res.data then for _, s in pairs(res.data) do if s.playing < s.maxPlayers and s.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer) return end end end
end)
