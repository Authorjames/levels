local ply = FindMetaTable("Player")
local ent = FindMetaTable("Entity")

/*
    Player methods
*/
function ply:setLevel(level)
    self.level = level
end

function ply:getLevel()
	return self.level or 0
end

/*
    Entity methods
*/
function ent:setLevel(level)
    self.level = level
end

function ent:getLevel()
	return self.level or 0
end