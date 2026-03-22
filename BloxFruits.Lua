print("🔥 Blox Fruits Script Ejecutado")

game.StarterGui:SetCore("SendNotification",{
    Title = "Nexus Hub",
    Text = "Script cargado 🔥",
    Duration = 5
})

print("🔥 BLOX FRUITS CARGADO 🔥")

game.StarterGui:SetCore("SendNotification", {
    Title = "Nexus Hub",
    Text = "Blox Fruits funcionando 😈",
    Duration = 5
})

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

-- UI
local WindUI = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

---------------------------------------------------
-- 🌊 SEA DETECTION REAL
---------------------------------------------------

local place = game.PlaceId
local Sea = "Unknown"

if place == 2753915549 then
    Sea = "First"
elseif place == 4442272183 then
    Sea = "Second"
elseif place == 7449423635 then
    Sea = "Third"
end

print("🌊 Sea:", Sea)

---------------------------------------------------
-- 🗺 ISLANDS (COORDENADAS REALES SIMPLES)
---------------------------------------------------

local Islands = {
    ["Starter Island"] = CFrame.new(0,50,0),
    ["Jungle"] = CFrame.new(-1200,20,400),
    ["Pirate Village"] = CFrame.new(-1100,15,3500),
    ["Desert"] = CFrame.new(900,15,4500),
    ["Frozen"] = CFrame.new(1100,50,-1500)
}

---------------------------------------------------
-- WINDOW
---------------------------------------------------

local Window = WindUI:CreateWindow({
    Title = "🔥 Nexus Hub | "..Sea.." Sea",
    Icon = "swords",
    Folder = "NexusHub",
    Size = UDim2.fromOffset(420,360),
    Transparent = true
})

---------------------------------------------------
-- TABS
---------------------------------------------------

local Home = Window:Tab({ Title = "🏠 Home" })
local Farm = Window:Tab({ Title = "🚀 Farm" })
local Teleport = Window:Tab({ Title = "🗺 Teleport" })
local ESP = Window:Tab({ Title = "👁 ESP" })
local PlayerTab = Window:Tab({ Title = "🧍 Player" })
local Settings = Window:Tab({ Title = "⚙ Settings" })

---------------------------------------------------
-- HOME
---------------------------------------------------

Home:Paragraph({
    Title = "🔥 Nexus Hub",
    Desc = "Sea: "..Sea
})

---------------------------------------------------
-- ⚔ AUTO FARM + AUTO HIT REAL
---------------------------------------------------

local AutoFarm = true

Farm:Toggle({
    Title = "🚀 Auto Farm + Auto Hit",
    Callback = function(v)
        AutoFarm = v
        task.spawn(function()
            while AutoFarm do
                pcall(function()
                    local char = GetChar()
                    local hrp = char:FindFirstChild("HumanoidRootPart")

                    for _,enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("HumanoidRootPart") 
                        and enemy:FindFirstChild("Humanoid") 
                        and enemy.Humanoid.Health > 0 then

                            hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)

                            -- ATAQUE AUTOMÁTICO
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
})

---------------------------------------------------
-- 👑 AUTO BOSS
---------------------------------------------------

local AutoBoss = true

Farm:Toggle({
    Title = "👑 Auto Boss",
    Callback = function(v)
        AutoBoss = v
        task.spawn(function()
            while AutoBoss do
                pcall(function()
                    local char = GetChar()
                    local hrp = char.HumanoidRootPart

                    for _,enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy.Name:lower():find("boss") then
                            hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end
})

---------------------------------------------------
-- 🧠 FRUIT ESP REAL
---------------------------------------------------

local FruitESP = true

ESP:Toggle({
    Title = "🍎 Fruit ESP",
    Callback = function(v)
        FruitESP = v

        task.spawn(function()
            while FruitESP do
                for _,v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Fruit") then
                        print("🍎 Fruit encontrada:", v.Name)
                    end
                end
                task.wait(2)
            end
        end)
    end
})

---------------------------------------------------
-- 🗺 TELEPORT REAL
---------------------------------------------------

local SelectedIsland

Teleport:Dropdown({
    Title = "Seleccionar Isla",
    Values = (function()
        local t = {}
        for k in pairs(Islands) do table.insert(t,k) end
        return t
    end)(),
    Callback = function(v)
        SelectedIsland = v
    end
})

Teleport:Button({
    Title = "🧭 Teleport",
    Callback = function()
        if SelectedIsland then
            GetChar().HumanoidRootPart.CFrame = Islands[SelectedIsland]
        end
    end
})

---------------------------------------------------
-- 🧍 PLAYER
---------------------------------------------------

PlayerTab:Slider({
    Title = "WalkSpeed",
    Value = {Min=16,Max=200,Default=16},
    Callback = function(v)
        local char = GetChar()
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})

PlayerTab:Slider({
    Title = "JumpPower",
    Value = {Min=50,Max=200,Default=50},
    Callback = function(v)
        local char = GetChar()
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = v
        end
    end
})

---------------------------------------------------
-- ⚙ SETTINGS
---------------------------------------------------

Settings:Button({
    Title = "🔔 Notify",
    Callback = function()
        WindUI:Notify({
            Title = "Nexus Hub",
            Content = "Script Loaded 🔥",
            Duration = 3
        })
    end
})

Settings:Button({
    Title = "🔄 Rejoin",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

Settings:Button({
    Title = "❌ Close",
    Callback = function()
        Window:Destroy()
    end
})

print("🔥 NEXUS HUB PRO CARGADO 🔥")
