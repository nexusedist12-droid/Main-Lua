-- 🔥 NEXUS LOADER PRO

repeat task.wait() until game:IsLoaded()

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

---------------------------------------------------
-- 📊 DETECCIÓN DE JUEGO
---------------------------------------------------

local placeId = game.PlaceId
local UniverseID = HttpService:JSONDecode(
    game:HttpGet("https://apis.roblox.com/universes/v1/places/"..placeId.."/universe")
).universeId

---------------------------------------------------
-- 🎮 BLOX FRUITS CHECK
---------------------------------------------------

local isBloxFruits = (
    placeId == 2753915549 or -- First Sea
    placeId == 4442272183 or -- Second Sea
    placeId == 7449423635 or -- Third Sea
    UniverseID == 994732206  -- Universe
)

---------------------------------------------------
-- 🔔 NOTIFICACIÓN SIMPLE
---------------------------------------------------

local function Notify(text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Nexus Loader",
            Text = text,
            Duration = 3
        })
    end)
end

---------------------------------------------------
-- 🚀 LOAD SCRIPT
---------------------------------------------------

if isBloxFruits then

    Notify("Detectado Blox Fruits...")

    local success, err = pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/Main.lua"
        ))()
    end)

    if success then
        Notify("🔥 Nexus Hub cargado")
    else
        warn("Error:", err)
        Notify("❌ Error al cargar script")
    end

else
    Notify("❌ Juego no soportado")
end
