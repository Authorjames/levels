util.AddNetworkString("Property Interact")

net.Receive("Property Interact", function(len, client)
	local cmd = net.ReadInt(8)
	local prop = property.Get(net.ReadInt(8))

	if cmd == PROPERTY_BUY then
		property.Purchase(prop, client)
	elseif cmd == PROPERTY_SELL then
		if not property.GetOwners(prop) then return end
		if not property.GetOwners(prop)[1] == client then
			return
		end

		property.Sell(prop, client)
	elseif cmd == PROPERTY_ADD then
		if not property.GetOwners(prop) then return end
		if not property.GetOwners(prop)[1] == client then
			return
		end

		local ply = net.ReadEntity()

		property.AddOwner(prop, ply, client)
	elseif cmd == PROPERTY_REMOVE then
		if not property.GetOwners(prop) then return end
		if not property.GetOwners(prop)[1] == client then
			return
		end

		local ply = net.ReadEntity()

		property.RemoveOwner(prop, ply, client)
	end
end)

hook.Add("OnPlayerChangedTeam", "Property Add", function(ply, before, after)
	for k, v in pairs(property.Properties) do
		if v.teams then
			if table.HasValue(v.teams, after) then
				property.AddOwner(v, ply)
			elseif table.HasValue(v.teams, before) then
				if table.HasValue(v.householders, ply) then
					property.RemoveOwner(v, ply)
				end
			end
		end
	end
end)

hook.Add("PlayerDisconnected", "Property Disconnect", function(ply)
	for k, v in pairs(property.Properties) do
		if v.householders >= 1 and not v.teams then
			if ply == v.householders[1] then
				property.Sell(v, ply)
			end
		end
	end
end)