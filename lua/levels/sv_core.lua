util.AddNetworkString("levels")

hook.Add("PhysgunPickup", "levels", function(ply, ent)
	if not (IsValid(ply) and IsValid(ent)) then
		return
	end

	if ply:getLevel() != ent:getLevel() then
		return false
	end
end)

function util.GetPlayerTrace( ply, dir )
	dir = dir or ply:GetAimVector()

	local trace = {}
	
	trace.start = ply:EyePos()
	trace.endpos = trace.start + (dir * (4096 * 8))

	if level.players then
		if table.HasValue(level.players, ply) then
			local t = {}
			for k, v in pairs(player.GetAll()) do
				if not table.HasValue(level.players, v) then
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

hook.Add("PlayerShouldTakeDamage", "levels", function(ply, attacker)
	if not (IsValid(ply) and IsValid(attacker)) then
		return
	end

	return ply:getLevel() == attacker:getLevel()
end)

hook.Add("ShouldCollide", "levels", function(ent1, ent2)
	if not (IsValid(ent1) and IsValid(ent2)) then
		return
	end

	return ent1:getLevel() == ent2:getLevel()
end)

levels.new = function(name, index)
	for k, v in pairs(levels.levels) do
		if v.name == name then
			error("Level with same name already exists!")
			return
		end
	end

	local count = index or (table.Count(levels.levels) + 1)
	local t = {
		name = name,
		players = {},
		entities = {},
		level = count,
	}

	levels.levels[count] = setmetatable(t, {
		__index = t,
		__tostring = function(t)
			return "Level [" .. count .. "][" .. name .. "]"
		end,
	})

	local level = levels.levels[count]

	function level:addPlayer(ply)
		if istable(ply) then
			for k, v in pairs(ply) do
				v.levels_Level = self.level
				table.insert(self.players, v)
			end

			return
		end

		ply.levels_Level = self.level
		table.insert(self.players, ply)
	end

	function level:addEntity(ent)
		if istable(ent) then
			for k, v in pairs(ent) do
				v.levels_Level = self.level
				table.insert(self.entities, v)
			end

			return
		end

		ent.levels_Level = self.level
		table.insert(self.entities, ent)
	end

	function level:removePlayer(ply)
		if istable(ply) then
			for k, v in pairs(ply) do
				v.levels_Level = false
				table.RemoveByValue(self.players, v)
			end

			return
		end

		ply.levels_Level = false
		table.RemoveByValue(self.players, ply)
	end

	function level:removeEntity(ent)
		if istable(ent) then
			for k, v in pairs(ent) do
				v.levels_Level = false
				table.RemoveByValue(self.entities, v)
			end

			return
		end

		ent.levels_Level = false
		table.RemoveByValue(self.entities, ent)
	end

	function level:getPlayers()
		return self.players
	end

	function level:getEntities()
		return self.entities
	end

	function level:open()
		for k, v in pairs(self.entities) do
			if v:GetCustomCollisionCheck() then
				continue
			end

			v:SetCustomCollisionCheck(true)
			v.levels_DisableCollisionCheck = true
		end

		for k, ply in pairs(player.GetAll()) do
			if not (ply:getLevel() == self.level) then
				for k, ent in pairs(self.entities) do
					ent:SetPreventTransmit(ply, true)
				end
			end
		end

		for k, v in pairs(self.players) do
			v:SetAvoidPlayers(false)

			if v:GetCustomCollisionCheck() then
				continue
			end

			v:SetCustomCollisionCheck(true)
			v.levels_DisableCollisionCheck = true
		end

		local t = {}
		for k, v in pairs(self) do
			if not isfunction(v) then
				t[k] = v
			end
		end

		net.Start("levels")
		net.WriteInt(1, 6)
		net.WriteInt(self.level, 6)
		net.WriteTable(t)
		net.Broadcast()
	end

	function level:close()
		for k, ply in pairs(player.GetAll()) do
			for k, ent in pairs(self.entities) do
				ent:SetPreventTransmit(ply, false)
			end
		end

		for k, v in pairs(self.entities) do
			v.levels_Level = nil
			if v.levels_DisableCollisionCheck then
				v:SetCustomCollisionCheck(false)
			end
		end

		for k, ply1 in pairs(self.players) do
			ply1.levels_Level = nil

			for k, ply2 in pairs(player.GetAll()) do
				ply2:SetPreventTransmit(ply1, false)
			end
		end

		for k, v in pairs(self.players) do
			if v.levels_DisableCollisionCheck then
				v:SetCustomCollisionCheck(false)
			end
		end

		net.Start("levels")
		net.WriteInt(2, 6)
		net.WriteInt(self.level, 6)
		net.Broadcast()

		levels.levels[self.level] = nil
	end

	return level
end

local ply = FindMetaTable("Player")
function ply:getLevel()
	return self.levels_Level or false
end

local ent = FindMetaTable("Entity")
function ent:getLevel()
	return self.levels_Level or false
end

function IsValidPlayer(...)
	local args = {...}
	for k, v in pairs(args) do
		if IsValid(v) then
			if v:IsPlayer() then
				continue
			end

			return false
		end

		return false
	end

	return true
end

levels.levels = {}

concommand.Add("test", function()
	local level = levels.new("test")
	level:addPlayer({player.GetByID(1), player.GetByID(2)})
	level:removePlayer(player.GetByID(2))
	level:addEntity(ents.FindByClass("prop_physics"))
	level:open()

	PrintTable(levels.levels)

	timer.Simple(5, function()
		level:close()
		level = nil
	end)
end)