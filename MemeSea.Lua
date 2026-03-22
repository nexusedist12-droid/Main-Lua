repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

---------------------------------------------------
-- UI
---------------------------------------------------

local WindUI = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "🌊 Nexus Hub | MemeSea",
    Icon = "swords",
    Folder = "NexusHub",
    Size = UDim2.fromOffset(420,360),
    Transparent = true
})

local Main = Window:Tab({ Title = "Main" })
local Farm = Window:Tab({ Title = "Farm" })

---------------------------------------------------
-- TEST
---------------------------------------------------

Main:Button({
    Title = "🔥 TEST",
    Callback = function()
        print("MemeSea funcionando 🔥")
    end
})

---------------------------------------------------
-- AUTO FARM NPC (ARRIBA + HIT)
---------------------------------------------------

local AutoFarm = false

Farm:Toggle({
    Title = "🧠 Auto Farm NPC",
    Callback = function(v)
        AutoFarm = v

        task.spawn(function()
            while AutoFarm do
                pcall(function()
                    local char = GetChar()
                    local hrp = char:FindFirstChild("HumanoidRootPart")

                    for _,enemy in pairs(workspace:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid")
                        and enemy:FindFirstChild("HumanoidRootPart")
                        and enemy.Humanoid.Health > 0 then

                            -- subir arriba
                            hrp.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,8,0)

                            -- ataque
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                        end
                    end
                end)

                task.wait(0.2)
            end
        end)
    end
})

print("🔥 MemeSea Hub cargado 🔥")
