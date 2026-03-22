repeat task.wait() until game:IsLoaded()

local gameId = game.GameId
local placeId = game.PlaceId

print("GameId:", gameId)
print("PlaceId:", placeId)

-- BLOX FRUITS
if gameId == 2753915549 then
    print("Cargando Blox Fruits...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/BloxFruits.lua"))()
end

-- MEME SEA
if placeId == 10260193230 then
    print("Cargando MemeSea...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/MemeSea.lua"))()
end
