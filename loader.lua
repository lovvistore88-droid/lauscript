local baseUrl = "https://raw.githubusercontent.com/lovvistore88-droid/lauscript/main/"

local function loadFile(file)
    local ok, data = pcall(function()
        return game:HttpGet(baseUrl .. file .. "?t=" .. tick())
    end)
    if ok and data then
        local func, err = loadstring(data)
        if func then 
            -- Eksekusi pake pcall biar kalo error, script utama gak mati
            local success, exec_err = pcall(func)
            if not success then
                warn("[Lau Dev] RUNTIME ERROR di " .. file .. ": " .. tostring(exec_err))
            end
        else 
            warn("[Lau Dev] SYNTAX ERROR di " .. file .. ": " .. tostring(err)) 
        end
    else
        warn("[Lau Dev] Gagal download: " .. file)
    end
end

_G.LoadMenuFiles = function()
    loadFile("Config.lua")
    task.wait(0.1)
    
    -- Load UI dulu (karena Modules butuh fungsi dari UI)
    loadFile("UI.lua")
    task.wait(0.5)
    
    -- Load Modules satu per satu
    loadFile("Modules/Aimbot.lua")
    loadFile("Modules/Visuals.lua")
    loadFile("Modules/Player.lua")
    loadFile("Modules/World.lua")
    loadFile("Modules/Bypass.lua")
end

-- Cek Cache
local cacheFile = "LauDev_Cache.txt"
local isCacheValid = false

if isfile and isfile(cacheFile) then
    local ok, data = pcall(function() return readfile(cacheFile) end)
    if ok and data then
        local success, cacheData = pcall(function() return game:GetService("HttpService"):JSONDecode(data) end)
        if success and cacheData.expires > os.time() and cacheData.userId == tostring(game.Players.LocalPlayer.UserId) then
            isCacheValid = true
        end
    end
end

if isCacheValid then
    _G.LoadMenuFiles()
else
    loadFile("KeySystem.lua")
end
