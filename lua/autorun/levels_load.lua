levels = levels or {}
levels.version = "1.0"
levels.author = "Author."
levels.levels = {}

local color_debug_text=Color(255,255,255)
local color_debug_client=Color(245,184,0)
local color_debug_server=Color(0,200,255)

function levels.debugprint(...)

	local s="";
	for k,v in ipairs{...}do
		local part;

		if type(v) == "table" then
			part=util.TableToJSON(v)
		elseif type(v) == "Entity" and v:IsPlayer() and IsValid(v) then
			part=v:Nick()
		else
			part=tostring(v)
		end

		s=s.." "..part
	end
	s=s.."\n";

	MsgC(SERVER and color_debug_server or color_debug_client,"[levels "..levels.version.."]")
	MsgC(color_debug_text,s)

	return 0
end

local color_error=Color(240,30,0)
local color_error_text=Color(190,190,190)
function levels.Error(error,...)
	local s="";
	for k,v in ipairs{...}do
		local part;

		if type(v) == "table" then
			part=util.TableToJSON(v)
		elseif type(v) == "Entity" and v:IsPlayer() and IsValid(v) then
			part=v:Nick()
		else
			part=tostring(v)
		end

		s=s.." "..part
	end
	s=s.."\n";

	MsgC(color_error,"[levels "..levels.version.."] ERROR: ")
	MsgC(color_debug_text,error);
	MsgC(color_error_text," "..s);

	hook.Call("levelsError",GAMEMODE,error,s)

	return -1
end

levels.debugprint("Initializing levels @ version "..levels.version)

local path = "levels"
function levels.includefile(name, folder, runtype)

	if not runtype then
		runtype = string.Left(name, 2)
	end

	if not runtype or ( runtype ~= "sv" and runtype ~= "sh" and runtype ~= "cl" ) then levels.Error("include_NO_PREFIX","Could not include file, no prefix!") return false end

	path = ""

	if folder then
		path = path .. folder .. "/"
	end

	path = path .. name

	if SERVER then
		if runtype == "sv" then
			levels.debugprint("> Loading... "..path)
			include(path)
		elseif runtype == "sh" then
			levels.debugprint("> Loading... "..path)
			include(path)
			AddCSLuaFile(path)
		elseif runtype == "cl" then
			AddCSLuaFile(path)
		end
	elseif CLIENT then
		if (runtype == "sh" or runtype == "cl") then
			levels.debugprint("> Loading... "..path)
			include(path)
		end
	end

	return true
end


function levels.includefolder(folder,runtype)
	levels.debugprint("Initializing "..folder)

	local exp=(string.Explode("/",folder,false))[1]

	for k, v in pairs(file.Find(folder.."/*.lua","LUA")) do
		levels.includefile(v, folder, runtype)
	end
end

//
// Include
//

levels.includefolder("levels")