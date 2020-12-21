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

function ply:activateLevel(level)
    self:setLevel(level.id)

    self:SetAvoidPlayers(false)

    for k, v in pairs(player.GetAll()) do
        if self:getLevel() != v:getLevel() then
            v:SetPreventTransmit(self, true)
        end
    end

    if not self:GetCustomCollisionCheck() then
        self:SetCustomCollisionCheck(true)
        self:CollisionRulesChanged()
    end

    for k, ent in pairs(ents.GetAll()) do
        ent:SetPreventTransmit(self, ent:getLevel() != self:getLevel())
    end
end

function ply:deactivateLevel(level)
    self:setLevel(0)

    if self:GetCustomCollisionCheck() then
        self:SetCustomCollisionCheck(false)
        self:CollisionRulesChanged()
    end

    for k, ent in pairs(ents.GetAll()) do
        ent:SetPreventTransmit(self, ent:getLevel() != self:getLevel())
    end
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

function ent:activateLevel(level)
    self:setLevel(level.id)

    if not self:GetCustomCollisionCheck() then
        self:SetCustomCollisionCheck(true)
        self:CollisionRulesChanged()
    end

    for k, ply in pairs(player.GetAll()) do
        self:SetPreventTransmit(ply, ply:getLevel() != self:getLevel())
    end
end

function ent:deactivateLevel(level)
    self:setLevel(0)

    if self:GetCustomCollisionCheck() then
        self:SetCustomCollisionCheck(false)
        self:CollisionRulesChanged()
    end

    for k, ply in pairs(player.GetAll()) do
        self:SetPreventTransmit(ply, ply:getLevel() != self:getLevel())
    end
end

/*
    Miscalleonuisn
*/

function table.removef(tbl)
    local t = {}

    for k, v in pairs(tbl) do
        if (not isfunction(v)) then
            t[k] = v
        end
    end

    return t
end