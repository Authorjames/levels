Level = Level or {
    levels = {},
}

net.Receive("LevelOpen", function(length)
    local me = LocalPlayer()
    local id = net.ReadInt(6)
    local level = net.ReadTable()

    print("level opened", id)
    PrintTable(level)

    for k, ply in pairs(level.players) do
        ply:setLevel(id)
    end

    for k, ent in pairs(level.entities) do
        ent:setLevel(id)
    end

    for k, ent in pairs(ents.GetAll()) do
        if IsValid(ent) then
            ent:SetNoDraw(ent:getLevel() != me:getLevel())
        end
    end

    for k, ply in pairs(player.GetAll()) do
        if (ply:getLevel() != me:getLevel()) then
            ply:SetNoDraw(true)

            ply.previousSolid = ply:GetSolid()
            ply:SetSolid(SOLID_NONE)

            for k, wep in pairs(ply:GetWeapons()) do
                wep:SetNoDraw(true)
            end
        else
            ply:SetNoDraw(false)

            if ply.previousSolid then
                ply:SetSolid(ply.previousSolid)
                ply.previousSolid = nil
            end

            for k, wep in pairs(ply:GetWeapons()) do
                wep:SetNoDraw(false)
            end
        end
    end

    Level.levels[id] = level
end)

net.Receive("levelClose", function(length)
    local me = LocalPlayer()
    local id = net.ReadInt(6)
    local level = Level.levels[id]

    for k, ply in pairs(level.players) do
        ply:setLevel(0)
    end

    for k, ent in pairs(level.entities) do
        ent:setLevel(0)
    end

    for k, ent in pairs(ents.GetAll()) do
        if IsValid(ent) then
            ent:SetNoDraw(ent:getLevel() != me:getLevel())
        end
    end

    for k, ply in pairs(player.GetAll()) do
        if (ply:getLevel() == me:getLevel()) then
            ply:SetNoDraw(false)

            if ply.previousSolid then
                ply:SetSolid(ply.previousSolid)
                ply.previousSolid = nil
            end

            for k, wep in pairs(ply:GetWeapons()) do
                wep:SetNoDraw(false)
            end
        else
            ply:SetNoDraw(true)

            ply.previousSolid = ply:GetSolid()
            ply:SetSolid(SOLID_NONE)

            for k, wep in pairs(ply:GetWeapons()) do
                wep:SetNoDraw(true)
            end
        end
    end

    print("level closed", id)
    Level.levels[id] = nil
end)

net.Receive("levelUpdate", function(length)
    local me = LocalPlayer()
    local id = net.ReadInt(6)
    local toAdd = net.ReadBool()
    local ent = net.ReadEntity()

    local level = Level.levels[id]

    if (ent:IsPlayer()) then
        if (toAdd) then
            table.insert(level.players, ent)
            ent:setLevel(id)
        else
            table.RemoveByValue(level.players, ent)
            ent:setLevel(0)
        end
    else
        if (toAdd) then
            table.insert(level.entities, ent)
            ent:setLevel(id)
        else
            table.RemoveByValue(level.entities, ent)
            ent:setLevel(0)
        end
    end

    for k, ent in pairs(ents.GetAll()) do
        if IsValid(ent) and (not ent:GetOwner() == me) then
            ent:SetNoDraw(ent:getLevel() != me:getLevel())
        end
    end
end)

net.Receive("Level Death", function(length)
    local victim = net.ReadEntity()
    
    victim:EmitSound("Player.Death")
    victim:EmitSound("common/null.wav")
end)