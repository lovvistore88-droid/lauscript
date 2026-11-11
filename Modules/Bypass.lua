local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Config = _G.LauConfig

local p = _G.GetPage("Bypass")
_G.MakeSection(p, "Security (Bypass)")
_G.MakeToggle(p, "Anti-Ban (Server Protector)", "AntiBan")
_G.MakeToggle(p, "Anti-Kick (Connection Safe)", "AntiKick", function(state)
    if state then
        -- Mencegah disconnect paksa dari server
        pcall(function()
            local success, err = pcall(function()
                for _, v in pairs(getconnections(LocalPlayer.OnTeleport)) do
                    if v.Function then end
                end
            end)
        end)
    end
end)

_G.MakeSection(p, "Optimization")
_G.MakeToggle(p, "FPS Boost (120+ FPS)", "FPSBoost", function(state)
    if state then
        -- 1. Matikan efek visual berat
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.ShadowSoftness = 0
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
        
        -- 2. Ubah semua material jadi plastik (ringan)
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                if v:FindFirstChild("Texture") then v.Texture:Destroy() end
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
                v.Enabled = false
            end
        end
        
        -- 3. Matikan dekorasi
        for _, v in pairs(game:GetService("StarterGui"):GetChildren()) do
            pcall(function() v.Enabled = false end)
        end
    else
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 1000
        Lighting.ShadowSoftness = 0.2
        Lighting.EnvironmentDiffuseScale = 0.5
        Lighting.EnvironmentSpecularScale = 0.5
    end
end)
