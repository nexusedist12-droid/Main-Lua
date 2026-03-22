local _ENV = (getgenv or getrenv or getfenv)()

---------------------------------------------------
-- 🌐 CONFIG (AUTO UPDATE)
---------------------------------------------------

local VERSION = "1.0.0"
local VERSION_URL = "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/version.txt"

---------------------------------------------------
-- 📊 LOGS TIPO HACKER
---------------------------------------------------

local function log(msg)
    print("[NEXUS] > "..msg)
end

log("Inicializando loader...")
task.wait(0.2)

---------------------------------------------------
-- 🔄 AUTO UPDATE CHECK
---------------------------------------------------

pcall(function()
    local latest = game:HttpGet(VERSION_URL)

    if latest and latest ~= VERSION then
        log("Nueva versión detectada: "..latest)
        log("Actualizando...")
    else
        log("Versión actual: "..VERSION)
    end
end)

---------------------------------------------------
-- 🔥 SCRIPTS (TUS JUEGOS)
---------------------------------------------------

local Scripts = {
    {
        Name = "Blox Fruits",
        GameIds = {994732206},
        Url = "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/Main.lua"
    },
    {
        Name = "MemeSea",
        PlaceIds = {10260193230},
        Url = "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/MemeSea.Lua"
    }
}

---------------------------------------------------
-- 🧠 DETECTAR JUEGO
---------------------------------------------------

local placeId = game.PlaceId
local gameId = game.GameId

log("Detectando juego...")

local function IsGame(script)
    if script.PlaceIds then
        for _,id in pairs(script.PlaceIds) do
            if id == placeId then
                return true
            end
        end
    end

    if script.GameIds then
        for _,id in pairs(script.GameIds) do
            if id == gameId then
                return true
            end
        end
    end

    return false
end

---------------------------------------------------
-- 🚀 CARGA PRINCIPAL
---------------------------------------------------

for _,script in pairs(Scripts) do
    if IsGame(script) then
        log("Juego detectado: "..script.Name)
        log("Cargando script...")

        local success, response = pcall(function()
            return game:HttpGet(script.Url)
        end)

        if success then
            log("Script descargado ✔")

            local func, err = loadstring(response)

            if func then
                log("Ejecutando script...")
                return func()
            else
                warn("❌ Error de sintaxis:", err)
            end
        else
            warn("❌ Error al descargar script")
        end
    end
end

---------------------------------------------------
-- ❌ NO SOPORTADO
---------------------------------------------------

log("Juego no soportado ❌")
