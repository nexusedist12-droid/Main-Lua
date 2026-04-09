repeat task.wait() until game:IsLoaded()

local gameId = game.GameId
local placeId = game.PlaceId

print("GameId:", gameId)
print("PlaceId:", placeId)

-- BLOX FRUITS
if placeId == 2753915549 then
    print("Cargando Blox Fruits...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/BloxFruits.lua"))()
end

-- MEME SEA
if placeId == 10260193230 then
    print("Cargando MemeSea...")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nexusedist12-droid/Main-Lua/main/MemeSea.lua"))()
end

local _ENV = (getgenv or getrenv or getfenv)()
local BETA_VERSION = BETA_VERSION or _ENV.BETA_VERSION

--------------------------------------------------
-- 🎮 SCRIPTS
--------------------------------------------------

local Scripts = {
	{
		GameId = 2753915549,
		UrlPath = BETA_VERSION and "BLOX-FRUITS-BETA.lua" or "BloxFruits.luau",
		Name = "Blox Fruits"
	},
	{
		PlacesIds = {10260193230},
		UrlPath = "MemeSea.luau",
		Name = "MemeSea"
	}
}

--------------------------------------------------
-- ⚡ ANTI SPAM
--------------------------------------------------

if _ENV.rz_execute_debounce and (tick() - _ENV.rz_execute_debounce) <= 5 then
	return
end
_ENV.rz_execute_debounce = tick()

--------------------------------------------------
-- 🌐 URLS
--------------------------------------------------

local fetcher, urls = {}, {}

urls.Owner = "https://raw.githubusercontent.com/tlredz/"
urls.Repository = urls.Owner .. "Scripts/refs/heads/main/"
urls.Translator = urls.Repository .. "Translator/"
urls.Utils = urls.Repository .. "Utils/"

--------------------------------------------------
-- 🎨 UI
--------------------------------------------------

local WindUI = loadstring(game:HttpGet(
"https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"
))()

local Window = WindUI:CreateWindow({
	Title = "🌌 Nexus Loader",
	Size = UDim2.fromOffset(400,260),
	Transparent = true,
	Theme = "Dark"
})

local MainTab = Window:Tab({Title="Home", Icon="home"})

--------------------------------------------------
-- 🚀 TELEPORT QUEUE
--------------------------------------------------

do
	local executor = syn or fluxus
	local queueteleport = queue_on_teleport or (executor and executor.queue_on_teleport)

	if not _ENV.rz_added_teleport_queue and type(queueteleport) == "function" then
		_ENV.rz_added_teleport_queue = true
		
		local SourceCode = ("loadstring(game:HttpGet('%smain.luau'))()"):format(urls.Repository)

		if BETA_VERSION then
			SourceCode = "getgenv().BETA_VERSION=true;" .. SourceCode
		end

		pcall(queueteleport, SourceCode)
	end
end

--------------------------------------------------
-- ❌ ERROR HANDLER
--------------------------------------------------

if _ENV.rz_error_message then
	_ENV.rz_error_message:Destroy()
end

local function CreateMessageError(Text)
	local Message = Instance.new("Message", workspace)
	Message.Text = string.gsub(Text, urls.Owner, "")
	_ENV.rz_error_message = Message
	
	error(Text, 2)
end

--------------------------------------------------
-- 🌐 FORMAT URL
--------------------------------------------------

local function formatUrl(Url)
	for key, path in pairs(urls) do
		if string.find(Url, "{"..key.."}") then
			return string.gsub(Url, "{"..key.."}", path)
		end
	end
	return Url
end

--------------------------------------------------
-- 📦 FETCH
--------------------------------------------------

function fetcher.get(Url)
	local success, response = pcall(function()
		return game:HttpGet(formatUrl(Url))
	end)

	if success then
		return response
	else
		CreateMessageError("❌ Failed: "..Url.."\n"..response)
	end
end

--------------------------------------------------
-- ⚙️ LOAD
--------------------------------------------------

function fetcher.load(Url)
	local raw = fetcher.get(Url)

	local func, err = loadstring(raw)

	if not func then
		CreateMessageError("❌ Syntax error: "..Url.."\n"..err)
	end

	return func
end

--------------------------------------------------
-- 🎯 DETECT GAME
--------------------------------------------------

local CurrentGame = nil

local function IsPlace(Script)
	if Script.PlacesIds then
		for _, id in pairs(Script.PlacesIds) do
			if id == game.PlaceId then
				return true
			end
		end
	end

	if Script.GameId and Script.GameId == game.GameId then
		return true
	end

	return false
end

for _, Script in pairs(Scripts) do
	if IsPlace(Script) then
		CurrentGame = Script
	end
end

--------------------------------------------------
-- 📊 UI INFO
--------------------------------------------------

MainTab:Paragraph({
	Title = "🎮 Game Detectado",
	Desc = CurrentGame and CurrentGame.Name or "No soportado",
	Image = "info",
})

--------------------------------------------------
-- 🚀 EXEC BUTTON
--------------------------------------------------

MainTab:Button({
	Title = "🚀 Ejecutar Script",
	Callback = function()

		if not CurrentGame then
			return WindUI:Notify({
				Title = "Error",
				Content = "Juego no soportado ❌",
				Duration = 3
			})
		end

		WindUI:Notify({
			Title = "Cargando...",
			Content = CurrentGame.Name,
			Duration = 3
		})

		local scriptFunc = fetcher.load("{Repository}Games/" .. CurrentGame.UrlPath)

		if scriptFunc then
			scriptFunc(fetcher, ...)
		end
	end
})

--------------------------------------------------
-- 🔔 START
--------------------------------------------------

WindUI:Notify({
	Title = "🌌 Nexus Loader",
	Content = "Sistema listo 🚀",
	Duration = 3
})
