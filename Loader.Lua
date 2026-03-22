local _ENV = (getgenv or getrenv or getfenv)()

---------------------------------------------------
-- 🧠 CONFIG
---------------------------------------------------

local Scripts = {
    {
        GameId = 994732206,
        UrlPath = "Main.lua"
    },
    {
        PlacesIds = {10260193230},
        UrlPath = "MemeSea.lua"
    }
}

---------------------------------------------------
-- 🌐 TU REPO (ESTO ES LA CLAVE)
---------------------------------------------------

local urls = {}
urls.Repository = "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/"

---------------------------------------------------
-- ⚡ ANTI SPAM EXEC
---------------------------------------------------

if _ENV.NexusDebounce and tick() - _ENV.NexusDebounce < 5 then
    return
end
_ENV.NexusDebounce = tick()

---------------------------------------------------
-- 📊 LOGS
---------------------------------------------------

local function log(msg)
    print("[NEXUS] > "..msg)
end

log("Loader iniciado...")

---------------------------------------------------
-- 🌐 FETCHER (TIPO REDZ)
---------------------------------------------------

local fetcher = {}

function fetcher.get(path)
    local success, res = pcall(function()
        return game:HttpGet(urls.Repository .. path)
    end)

    if success then
        return res
    else
        warn("❌ Error al obtener:", path)
    end
end

function fetcher.load(path)
    local raw = fetcher.get(path)
    if not raw then return end

    local func, err = loadstring(raw)

    if func then
        return func()
    else
        warn("❌ Error en script:", err)
    end
end

---------------------------------------------------
-- 🎮 DETECTAR JUEGO
---------------------------------------------------

local placeId = game.PlaceId
local gameId = game.GameId

local function IsPlace(script)
    if script.PlacesIds then
        for _,id in pairs(script.PlacesIds) do
            if id == placeId then return true end
        end
    end

    if script.GameId and script.GameId == gameId then
        return true
    end

    return false
end

---------------------------------------------------
-- 🚀 EJECUTAR
---------------------------------------------------

for _,script in pairs(Scripts) do
    if IsPlace(script) then
        log("Cargando: "..script.UrlPath)
        return fetcher.load(script.UrlPath)
    end
end

---------------------------------------------------
-- ❌ NO SOPORTADO
---------------------------------------------------

log("Juego no soportado")
