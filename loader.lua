local baseUrl = "https://raw.githubusercontent.com/lovvistore88-droid/lauscript/main/"

local function loadFile(file)
    local ok, data = pcall(function()
        return game:HttpGet(baseUrl .. file .. "?t=" .. tick())
    end)
    if ok and data then
        local func, err = loadstring(data)
        if func then task.spawn(func) else warn("[Lau Dev] Error di " .. file .. ": " .. tostring(err)) end
    else
        warn("[Lau Dev] Gagal download: " .. file)
    end
end

_G.LoadMenuFiles = function()
    loadFile("Config.lua")
    task.wait(0.1)
    loadFile("UI.lua")
    task.wait(0.5)
    loadFile("Modules/Aimbot.lua")
    loadFile("Modules/Visuals.lua")
    loadFile("Modules/Player.lua")
    loadFile("Modules/World.lua")
    loadFile("Modules/Bypass.lua")
end

-- Cek Cache Dulu (Poin No 2)
local cacheFile = "LauDev_Cache.txt"
local isCacheValid = false

if isfile and isfile(cacheFile) then
    local ok, data = pcall(function() return readfile(cacheFile) end)
    if ok and data then
        local cacheData = game:GetService("HttpService"):JSONDecode(data)
        if cacheData.expires > os.time() and cacheData.userId == tostring(game.Players.LocalPlayer.UserId) then
            isCacheValid = true
        end
    end
end

if isCacheValid then
    -- Kalau cache masih aktif, langsung buka menu tanpa login
    _G.LoadMenuFiles()
else
    -- Kalau gak ada cache, suruh login
    loadFile("KeySystem.lua")
end
