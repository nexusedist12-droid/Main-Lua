local _ENV = (getgenv or getrenv or getfenv)()

---------------------------------------------------
-- 🔥 CONFIG
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
-- ⚡ ANTI DOUBLE EXEC
---------------------------------------------------

if _ENV.NexusLoaded and tick() - _ENV.NexusLoaded < 5 then
    return
end
_ENV.NexusLoaded = tick()

---------------------------------------------------
-- 🧠 DETECT GAME
---------------------------------------------------

local placeId = game.PlaceId
local gameId = game.GameId

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
-- 🚀 LOADER
---------------------------------------------------

for _,script in pairs(Scripts) do
    if IsGame(script) then
        print("🔥 Cargando:", script.Name)

        local success, result = pcall(function()
            return game:HttpGet(script.Url)
        end)

        if success then
            local func, err = loadstring(result)

            if func then
                return func()
            else
                warn("❌ Error en script:", err)
            end
        else
            warn("❌ Error al cargar URL")
        end
    end
end

---------------------------------------------------
-- ❌ NO SOPORTADO
---------------------------------------------------

warn("❌ Juego no soportado")
