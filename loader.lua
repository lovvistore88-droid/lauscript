local baseUrl = "https://raw.githubusercontent.com/UsernameGithubLo/NamaRepo/main/"
-- GANTI "UsernameGithubLo/NamaRepo" SAMA PUNYA LO!

local function loadFile(file)
    local ok, data = pcall(function()
        return game:HttpGet(baseUrl .. file .. "?t=" .. tick())
    end)
    
    if ok and data then
        local func, err = loadstring(data)
        if func then
            task.spawn(func)
        else
            warn("[Lau Dev] Error syntax di file " .. file .. ": " .. tostring(err))
        end
    else
        warn("[Lau Dev] Gagal download file: " .. file)
    end
end

loadFile("Config.lua")
task.wait(0.1)
loadFile("UI.lua")
task.wait(0.5)
loadFile("Modules/Aimbot.lua")
loadFile("Modules/Visuals.lua")
loadFile("Modules/Player.lua")
loadFile("Modules/World.lua")
loadFile("Modules/Bypass.lua") -- File baru
