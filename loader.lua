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

_G.StartScript = function()
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

loadFile("KeySystem.lua")
