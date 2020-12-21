util.AddNetworkString("levelOpen");
util.AddNetworkString("levelClose");
util.AddNetworkString("levelUpdate");
util.AddNetworkString("Level Death");

Level = Level or {
    levels = {}
}

function Level:__tostring()
    return string.format("Level [%s][%s]", self.id, self.name)
end

Level.createdLevels = 0;

function Level:new(name)
    if #self.levels == 0 then
        Level.createdLevels = 0
    end

    Level.createdLevels = Level.createdLevels + 1;

    local level = {
        name = name,
        entities = {},
        players = {},
        isOpen = false,
        id = Level.createdLevels,
    }

    Level.levels[Level.createdLevels] = level

    setmetatable(level, Level)

    return level
end

function Level:addEntity(ent)
    ent = istable(ent) and ent or {ent}
    for k, v in pairs(ent) do
        table.insert(self.entities, v)

        if self.isOpen then
            v:activateLevel(self)
            self:update(true, v)
        end
    end
end

function Level:addPlayer(ply)
    ply = istable(ply) and ply or {ply}
    for k, v in pairs(ply) do
        local level = Level.getLevel(v:getLevel())
        if (level) then
            level:removePlayer(v)
        end

        for j, ent in pairs(v:GetChildren()) do
            if IsValid(ent) then
                self:addEntity(ent)
            end
        end

        table.insert(self.players, v)

        if self.isOpen then
            v:activateLevel(self)
            self:update(true, v)
        end
    end
end

function Level:removeEntity(ent)
    ent:deactivateLevel(self)

    table.RemoveByValue(self.entities, ent)

    if self.isOpen then
        self:update(false, ent)
    end
end

function Level:removePlayer(ply)
    ply:deactivateLevel(self)

    for j, ent in pairs(ply:GetChildren()) do
        if IsValid(ent) then
            self:removeEntity(ent)
        end
    end

    table.RemoveByValue(self.players, ply)

    if self.isOpen then
        self:update(false, ply)
    end
end

function Level:open()
    print("open level", self)

    self.isOpen = true;

    for k, ply in pairs(self.players) do
        ply:activateLevel(self)
    end

    for k, ent in pairs(self.entities) do
        ent:activateLevel(self)
    end

    net.Start("levelOpen")
    net.WriteInt(self.id, 6)
    net.WriteTable(table.removef(self))
    net.Broadcast()
end

function Level:close()
    print("close level", self)

    PrintTable(Level.getLevel(self.id))

    for k, v in pairs(self.entities) do
        if not IsValid(v) then
            self.entities[k] = nil
        end
    end

    for k, ply in pairs(player.GetAll()) do
        if ply:getLevel() != self.id then
            for k, ent in pairs(self.entities) do
                ent:SetPreventTransmit(ply, false)
            end
        end
    end

    for k, ply in pairs(self.players) do
        ply:deactivateLevel(self)
    end

    for k, ent in pairs(self.entities) do
        ent:deactivateLevel(self)
    end

    net.Start("levelClose")
    net.WriteInt(self.id, 6)
    net.Broadcast()

    table.remove(Level.levels, self.id)
end

function Level:update(toAdd, ent)
    net.Start("levelUpdate")
    net.WriteInt(self.id, 6)
    net.WriteBool(toAdd)
    net.WriteEntity(ent)
    net.Broadcast()
end

function Level.getLevel(id)
    return Level.levels[id]
end

function Level.getLevels()
    return Level.levels
end

setmetatable(Level, {
    __call = Level.new,
})

Level.__index = Level

/*
    Test
*/
concommand.Add("level_start", function()
	local level = Level("test")
    print(level)
	level:addPlayer(player.GetByID(1))
	//level:addEntity(ents.FindByClass("prop_physics")[6])
	level:open()
end)

concommand.Add("level_stop", function(ply, cmd, args)
    local level = Level.getLevel(tonumber(args[1])) or Level.getLevel(ply:getLevel())
    
    if level then
        level:close()
        level = nil
    end
end)

concommand.Add("level_transfer", function(ply, cmd, args)
    local oldLevel = Level.getLevel(ply:getLevel())
    local newLevel = Level.getLevel(tonumber(args[1]))
    print(oldLevel, newLevel)

    if (oldLevel) then
        oldLevel:removePlayer(ply)
    end

    if (newLevel) then
        newLevel:addPlayer(ply)
    end
end)

concommand.Add("level_list", function()
    //PrintTable(Level.getLevels())
end)

concommand.Add("level_leave", function(ply)
    local level = Level.getLevel(ply:getLevel())
    
    if level then
        level:removePlayer(ply)
    end
end)