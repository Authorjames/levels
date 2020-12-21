hook.Add("EntityEmitSound", "levels", function(data)
	local ent = data.Entity
    local me = LocalPlayer()

    return ent:getLevel() == me:getLevel()
end)

hook.Add("PlayerFootstep", "levels", function(ply, pos, foot, sound, volume, rf)
local me = LocalPlayer()
    return me:getLevel() != ply:getLevel()
end)

hook.Add("CreateClientsideRagdoll", "levels", function(entity, ragdoll)
	local me = LocalPlayer()

	print("ragdoll spawned", entity, ragdoll)

    ragdoll:SetNoDraw(me:getLevel() != entity:getLevel())
end)

hook.Add("ShouldCollide", "levels", function(ent1, ent2)
	if IsValid(ent1) and IsValid(ent2) then
        return ent1:getLevel() == ent2:getLevel()
    end
end)

hook.Add("OnEntityCreated", "levels", function(ent)
	local me = LocalPlayer()
    local owner = ent:GetOwner()

    if IsValid(owner) and IsValid(ent) then
        local toDraw = owner:getLevel() != me:getLevel()
        ent:SetNoDraw(toDraw)
        owner:SetNoDraw(toDraw)
    end
end)

hook.Add("EntityRemoved", "levels", function(ent)
    local level = Level.levels[ent:getLevel()]

    if level then
        table.RemoveByValue(level.entities, ent)
    end
end)

hook.Add("EntityEmitSound", "levels", function(data)
	local me = LocalPlayer()
	local ent = data.Entity

	//print(data.Entity, data.SoundName)

	if (me:getLevel() != ent:getLevel()) then
		data.Volume = 0;
	end

	return true
end)

hook.Add("EntityFireBullets", "levels", function(ent, data)
    if IsValid(ent) then
		local me = LocalPlayer()

        return ent:getLevel() == me:getLevel()
    end
end)

/*
hook.Add("DrawPhysgunBeam", "levels", function(ply)
    if IsValid(ply) then
        return ply:getLevel() == me:getLevel()
    end
end)
*/

function util.GetPlayerTrace( ply, dir )
	dir = dir or ply:GetAimVector()

	local trace = {}
	
	trace.start = ply:EyePos()
	trace.endpos = trace.start + (dir * (4096 * 8))

	local level = Level.levels[ply:getLevel()]
	if level then
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