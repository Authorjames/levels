levels.levels = levels.levels or {}

levels_Level = levels_Level or false

net.Receive("levels", function(l, c)
	local cmd = net.ReadInt(6)
	local level = net.ReadInt(6)
	local me = LocalPlayer()

	if cmd == 1 then
		local levelobj = net.ReadTable()
		levels.levels[level] = levelobj

		PrintTable(levelobj)

		for k, v in pairs(levels.levels[level].entities) do
			v.levels_Level = level
		end

		for k, v in pairs(player.GetAll()) do
			if not table.HasValue(levels.levels[level].players, v) then
				if table.HasValue(levels.levels[level].players, me) then
					v:SetNoDraw(true)
					v.levels_Solid = v:GetSolid()
					v:SetSolid(SOLID_NONE)
					for k, ent in pairs(v:GetWeapons()) do
						ent:SetNoDraw(true)
					end
				end
			else
				v.levels_Level = level
			end
		end

		if not table.HasValue(levels.levels[level].players, me) then
			for k, v in pairs(levels.levels[level].players) do
				v:SetNoDraw(true)
				v.levels_Solid = v:GetSolid()
				v:SetSolid(SOLID_NONE)
				for k, ent in pairs(v:GetWeapons()) do
					ent:SetNoDraw(true)
				end
			end
		end

		if table.HasValue(levels.levels[level].players, me) then
			levels_Level = level
		end
	elseif cmd == 2 then
		if table.HasValue(levels.levels[level].players, me) then
			for k, v in pairs(player.GetAll()) do
				if v:GetNoDraw() then
					v:SetNoDraw(false)
					v:SetSolid(v.levels_Solid)
					for k, v in pairs(v:GetWeapons()) do
						v:SetNoDraw(false)
					end
				end
			end
		end

		for k, v in pairs(levels.levels[level].players) do
			v.levels_Level = false

			if v:GetNoDraw() then
				v:SetNoDraw(false)
				v:SetSolid(v.levels_Solid)
				for k, v in pairs(v:GetWeapons()) do
					v:SetNoDraw(false)
				end
			end
		end

		levels.levels[level] = {}
	end
end)

local ply = FindMetaTable("Player")
function ply:getLevel()
	return self.levels_Level or false
end

local ent = FindMetaTable("Entity")
function ent:getLevel()
	return self.levels_Level or false
end

hook.Add("EntityEmitSound", "levels", function(data)
	local ent = data.Entity
	if ent and IsValid(ent) then
		return ent:getLevel() == levels_Level
	end
end)

hook.Add("PlayerFootstep", "levels", function(ply, pos, foot, sound, volume, rf)
	if ply:getLevel() and levels_Level then
		return not (ply:getLevel() == levels_Level)
	end
end)

function util.GetPlayerTrace( ply, dir )
	dir = dir or ply:GetAimVector()

	local trace = {}
	
	trace.start = ply:EyePos()
	trace.endpos = trace.start + (dir * (4096 * 8))

	local level = ply:getLevel()
	if level then
		if table.HasValue(levels.levels[level].players, ply) then
			local t = {}
			for k, v in pairs(player.GetAll()) do
				if not table.HasValue(levels.levels[level].players, v) then
					table.insert(t, v)
				end
			end

			trace.filter = t
		end
	end

	if trace.filter then
		table.insert(trace.filter, ply)
	else
		trace.filter = ply
	end
	
	return trace
end