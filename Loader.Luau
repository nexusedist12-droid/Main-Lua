repeat task.wait() until game:IsLoaded()

local placeId = game.PlaceId

---------------------------------------------------
-- BLOX FRUITS
---------------------------------------------------

if placeId == 2753915549 or placeId == 4442272183 or placeId == 7449423635 then

    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/Main.lua"
    ))()

---------------------------------------------------
-- MEMESEA
---------------------------------------------------

elseif placeId == 10260193230 then

    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/MemeSea.Lua"
    ))()

---------------------------------------------------
-- OTROS
---------------------------------------------------

else
    warn("❌ Juego no soportado")
end
