hook.Add("PhysgunPickup", "levels", function(ply, ent)
	if not (IsValid(ply) and IsValid(ent)) then
		return
	end

	return ply:getLevel() == ent:getLevel()
end)

hook.Add("GravGunPunt", "levels", function(ply, ent)
    return ply:getLevel() == ent:getLevel()
end)

hook.Add("GravGunPickupAllowed", "levels", function(ply, ent)
    return ply:getLevel() == ent:getLevel()
end)

hook.Add("AllowPlayerPickup", "levels", function(ply, ent)
    return ply:getLevel() == ent:getLevel()
end)

hook.Add("PlayerSpawnedProp", "levels", function(ply, mdl, ent)
	local level = Level.getLevel(ply:getLevel());
	if (level) then
        timer.Simple(0.1, function()
		    level:addEntity(ent)
        end)
	end
end)


hook.Add("PlayerShouldTakeDamage", "levels", function(ply, attacker)
	if not (IsValid(ply) and IsValid(attacker)) then
		return
	end

	return ply:getLevel() == attacker:getLevel()
end)

hook.Add("ShouldCollide", "levels", function(ent1, ent2)
	if IsValid(ent1) and IsValid(ent2) then
        return ent1:getLevel() == ent2:getLevel()
    end
end)

hook.Add("EntityRemoved", "levels", function(ent)
    local level = Level.getLevel(ent:getLevel())

    if level then
        table.RemoveByValue(level.entities, ent)
    end
end)

/*hook.Add("InitialPlayerSpawn", "levels", function(ply)
    if IsValid(ply) then
        for k, v in pairs(player.GetAll()) do
            if ply:getLevel() != v:getLevel() then
                local level = Level.getLevel(v:getLevel())

                if level then
                    for j, ent in pairs(level.entities) do
                        ent:SetPreventTransmit(ply, true)
                    end
                end
            end
        end

        for k, level in pairs(Level.getLevels()) do
            net.Start("levelOpen")
            net.WriteInt(level.id, 6)
            net.WriteTable(table.removef(level))
            net.Send(ply)
        end
    end
end)*/

hook.Add("PlayerSpawn", "levels", function(ply)
    for k, v in pairs(player.GetAll()) do
        if ply:getLevel() != v:getLevel() then
            ply:SetPreventTransmit(v, true)
        end
    end
end)

hook.Add("CreateEntityRagdoll", "levels", function(owner, ent)
    print("ragdoll  spawned", owner, ent)
end)

hook.Add("OnEntityCreated", "levels", function(ent)
    timer.Simple(0, function()
        if IsValid(ent) then
            //print("ent spawned", ent:GetOwner(), CurTime())
            
            local owner = ent:GetOwner()
            local parent = ent:GetParent()
            
            local function findOwner(owner, parent)
                if owner != NULL and IsValid(owner) then
                    local id = owner:getLevel()
                    local level = Level.getLevel(id)
                    if level then
                        level:addEntity(ent);
                    end
                elseif parent != NULL and IsValid(parent) then
                    findOwner(parent:GetOwner())
                end
            end

            findOwner(owner, parent)
        end
    end)
end)

hook.Add("PlayerDeathSound", "levels", function()
    return true
end)

hook.Add("EntityEmitSound", "levels", function(t)
end)

hook.Add("PlayerDeath", "levels", function(vic, inf, att)
    local shouldHear = {}
    print(vic, vic:getLevel())
    for k, v in pairs(player.GetAll()) do
        if (v:getLevel() == vic:getLevel()) then
            table.insert(shouldHear, v)
        end
    end

    if #shouldHear > 0 then
        net.Start("Level Death")
        net.WriteEntity(vic)
        net.Send(shouldHear)
    end
end)