property = property or {}
property.Properties = {}

local add = 1

PROPERTY_BUY = 1
PROPERTY_SELL = 2
PROPERTY_ADD = 3
PROPERTY_REMOVE = 4

function property.Add(name, price, doors, tbl, tableang)
	if property.Properties[add] then
		return
	end

	if istable(price) then
		property.Properties[add] = {name = name, price = 0, doors = doors, tbl = tbl, tableang = tableang, householders = {}, teams = price}
	else
		property.Properties[add] = {name = name, price = price, doors = doors, tbl = tbl, tableang = tableang, householders = {}}
	end

	add = add + 1
end

--property.Add("Townhall", {TEAM_CIVILIAN}, {2502, 2503, 2504, 2505, 2500, 2501, 2514, 2515, 2527, 2525, 2524, 2517, 2516, 2518, 2519, 2520, 2521, 2523, 2522}, Vector(-4824.3286132813, -5853.96875, 787.95349121094), Angle(-0, 90, 0))
property.Add("Fire Station", {}, {3578, 3579, 3580, 3581, 3577, 3575, 3573, 1587, 4111, 4027, 3586, 3587, 3588, 3589, 3590, 3682, 3681, 3583, 3582, 3584, 3585}, Vector(-4498.9853515625, -2813.96875, 102.9774017334), Angle(-0, 90, 0))
property.Add("Bank", {}, {3729, 3730, 3732, 3795, 3733}, Vector(-3018.03125, -3486.9645996094, 106.84413146973), Angle(-0, 180, 0))
property.Add("Cobs GM", {}, {1632, 1633, 1718}, Vector(-3941.0280761719, -1088.03125, 81.329513549805), Angle(-0, 270, 0))
property.Add("Hospital", {TEAM_CIVILIAN}, {2703, 2706, 2699, 2741, 2709, 2708, 2701, 2711, 2712, 2702, 2698}, Vector(-505.48199462891, -6045.96875, 142.91552734375), Angle(-0, 90, 0))
property.Add("PD", {}, {3925, 3927, 3922, 4045, 4046, 4047, 4076, 4075, 4083, 4088, 4087, 4085, 4086, 4071, 4059, 4070, 4058, 4069, 4057, 4041, 3923, 3924}, Vector(-8898.03125, -5672.9794921875, 82.389938354492), Angle(-0, 180, 0))
property.Add("Cinema", {}, {3804, 3803, 3806, 3805, 3807, 3808}, Vector(-829.96875, 2063.26171875, 627.99591064453), Angle(-0, 0, 0))
property.Add("Taco Bell", {}, {1630, 1631, 1720, 1721}, Vector(759.05316162109, 2306.03125, 619.45294189453), Angle(-0, 90, 0))
property.Add("Shell", {}, {1629, 1628}, Vector(653.26824951172, 3645.96875, 621.15112304688), Angle(-0, 270, 0))
property.Add("Shell", {}, {2953, 2952}, Vector(-14269.96875, 2383.6940917969, 474.62487792969), Angle(-0, 0, 0))
property.Add("Minimarket", {}, {1525, 1524}, Vector(1719.1380615234, 5714.03125, 658.83233642578), Angle(-0, 90, 0))
property.Add("Fashion", {}, {2858, 2859}, Vector(2240.03125, 3731.7106933594, 613.26782226563), Angle(-0, 0, 0))
property.Add("RTA", {}, {3797, 3798}, Vector(-1526.6868896484, 4226.03125, 614.81408691406), Angle(-0, 90, 0))
property.Add("Bar", {}, {3849, 3850}, Vector(-778.03125, 5589.8168945313, 656.56195068359), Angle(-0, 180, 0))
property.Add("Customs", {}, {4022}, Vector(-7812.8530273438, -1986.03125, 79.758277893066), Angle(-0, 270, 0))

property.Add("Shop", 1000, {1642, 1643, 1971, 1972}, Vector(-7101.96875, 200.65936279297, 85.437812805176), Angle(-0, 0, 0))
property.Add("Shop", 1000, {1641, 1640, 1970}, Vector(-8672.03125, -26.220802307129, 88.339157104492), Angle(-0, 180, 0))
property.Add("Shop", 1000, {1639, 1638, 1968}, Vector(-8672.03125, 1065.0119628906, 90.456665039063), Angle(-0, 180, 0))
property.Add("Shop", 1000, {1644, 1967}, Vector(-8674.03125, 1507.5855712891, 87.076843261719), Angle(-0, 180, 0))
property.Add("Shop", 1000, {1645}, Vector(-7261.96875, -3012.2053222656, 90.500816345215), Angle(-0, 0, 0))
property.Add("Shop", 1000, {1636, 1637}, Vector(-8672.03125, -3600.76953125, 90.080978393555), Angle(-0, 180, 0))
property.Add("Shop", 1000, {1634, 1635}, Vector(-8672.03125, -2949.47265625, 85.662040710449), Angle(-0, 180, 0))

-- by cinema and stuff

property.Add("Shop", 5000, {2857, 2856}, Vector(2240.03125, 3346.7124023438, 621.72485351563), Angle(-0, 0, 0))
property.Add("Shop", 5000, {2855, 2854}, Vector(2240.03125, 2970.9914550781, 624.43493652344), Angle(-0, 0, 0))
property.Add("Shop", 5000, {2852, 2853}, Vector(2240.03125, 2596.3540039063, 626.00305175781), Angle(-0, 0, 0))
property.Add("Shop", 5000, {2850, 2851}, Vector(2240.03125, 2201.6081542969, 627.75494384766), Angle(-0, 0, 0))
property.Add("Shop", 5000, {2848, 2849}, Vector(2240.03125, 1814.0496826172, 628.92547607422), Angle(-0, 0, 0))
property.Add("Shop", 5000, {2846, 2847}, Vector(2240.03125, 1434.5932617188, 620.96710205078), Angle(-0, 0, 0))

-- townhall street
-- left building
property.Add("Apartment", 4000, {1236, 1237, 1238}, Vector(-3234.03125, -7194.3291015625, 83.046524047852), Angle(-0, 180, 0))
property.Add("Apartment", 4000, {1239, 1240, 1241}, Vector(-3234.03125, -7198.0712890625, 210.41020202637), Angle(-0, 180, 0))
property.Add("Apartment", 4000, {1242, 1244, 1243}, Vector(-3234.03125, -7201.3676757813, 322.76974487305), Angle(-0, 180, 0))

--right building
property.Add("Apartment", 4000, {1251, 1253, 1252}, Vector(-3869.96875, -7287.1689453125, 80.876159667969), Angle(-0, 0, 0))
property.Add("Apartment", 4000, {1245, 1247, 1246}, Vector(-3869.96875, -7314.1782226563, 193.60882568359), Angle(-0, 0, 0))
property.Add("Apartment", 4000, {1248, 1250, 1249}, Vector(-3869.96875, -7318.4516601563, 310.74084472656), Angle(-0, 0, 0))

--upper area
--325

property.Add("Apartment", 9000, {1673, 1666, 1670, 1667}, Vector(-1292.6292724609, 9162.03125, 686.81408691406), Angle(-0, 90, 0))
property.Add("Apartment", 9000, {1672, 1671, 1669, 1668}, Vector(-1519.5549316406, 9341.96875, 694.24145507813), Angle(-0, 270, 0))
property.Add("Apartment", 9000, {1662, 1658, 1661, 1659}, Vector(-1446.1981201172, 9162.03125, 828.86212158203), Angle(-0, 90, 0))
property.Add("Apartment", 9000, {1663, 1660, 1656, 1657, 1665}, Vector(-1289.1306152344, 9162.03125, 833.52545166016), Angle(-0, 90, 0))
property.Add("Apartment", 9000, {1652, 1654, 1648, 1651, 1649}, Vector(-1446.1427001953, 9162.03125, 967.22430419922), Angle(-0, 90, 0))
property.Add("Apartment", 9000, {1653, 1655, 1646, 1650, 1647}, Vector(-1290.0474853516, 9162.03125, 966.92987060547), Angle(-0, 90, 0))

property.Add("Apartment", 9000, {1681, 1674, 1678, 1675}, Vector(265.78994750977, 8245.96875, 690.44348144531), Angle(-0, 270, 0))
property.Add("Apartment", 9000, {1680, 1676, 1679, 1677}, Vector(498.75631713867, 8066.03125, 686.98278808594), Angle(-0, 90, 0))
property.Add("Apartment", 9000, {1689, 1682, 1686, 1683}, Vector(265.28161621094, 8245.96875, 826.05670166016), Angle(-0, 270, 0))
property.Add("Apartment", 9000, {1688, 1690, 1684, 1687, 1685}, Vector(425.34686279297, 8245.96875, 824.42895507813), Angle(-0, 270, 0))
property.Add("Apartment", 9000, {1699, 1701, 1692, 1696, 1693}, Vector(269.85296630859, 8245.96875, 964.64483642578), Angle(-0, 270, 0))
property.Add("Apartment", 9000, {1698, 1694, 1697, 1695, 1700}, Vector(425.58248901367, 8245.96875, 964.99932861328), Angle(-0, 270, 0))

property.Add("Residential", 15000, {1713, 1319, 1320, 1322, 1321, 1625, 1707, 1324, 1331, 1325, 1329, 1323, 1327, 1328}, Vector(8176.0727539063, 5514.03125, 1651.9581298828), Angle(-0, 90, 0))
property.Add("Residential", 15000, {1293, 1295, 1714, 1290, 1288, 1287, 1289, 1291, 1292, 1294}, Vector(8962.03125, 1555.5078125, 1646.2426757813), Angle(-0, 0, 0))
property.Add("Residential", 15000, {1715, 1308, 1311, 1310, 1309, 1317, 1318, 1314, 1316, 1315, 1313, 1312, 1709}, Vector(10954.03125, 5383.6220703125, 1646.4691162109), Angle(-0, 0, 0))

property.Add("Cabin", 11000, {1623, 1624, 1286, 1285, 1280, 1283, 1282, 1281, 1703}, Vector(10687.276367188, 7165.96875, 1640.4835205078), Angle(-0, 270, 0))

property.Add("House", 12000, {1300, 1304, 1305, 1307, 1303, 1301, 1306, 1302, 1711}, Vector(10511.490234375, 2562.03125, 1630.8491210938), Angle(-0, 90, 0))
property.Add("House", 12000, {1297, 1298, 1296, 1299}, Vector(8165.96875, 7400.3134765625, 1646.5114746094), Angle(-0, 180, 0))
property.Add("House", 12000, {2942, 2940, 2938, 2937, 2939, 1450, 1451, 2941, 1446, 1447, 1448, 1449}, Vector(-8317.96875, -13807.194335938, 219.57333374023), Angle(-0, 0, 0))

property.Add("Cabin", 20000, {1455, 1454, 1459, 1458, 1457, 1456, 1461, 1460}, Vector(12802.03125, -5367.8798828125, 429.81988525391), Angle(-0, 0, 0))
property.Add("Cabin", 20000, {1463, 1462, 1466, 1467, 1465, 1464, 1468, 1469}, Vector(12162.03125, -8756.1357421875, 430.80447387695), Angle(-0, 0, 0))

--327
property.Add("Powerplant", 10000, {1569, 1570, 1986, 1987, 1989, 1988}, Vector(-8887.95703125, 6307.7568359375, 82.369323730469), Angle(1.4027779116077e-006, 180, 0))

property.Add("Warehouse", 5000, {3178, 3177, 3179}, Vector(-6450.03125, 7149.6303710938, 87.536468505859), Angle(-0, 180, 0))
property.Add("Warehouse", 5000, {1588, 1568}, Vector(-8394.89453125, 4610.03125, 86.393768310547), Angle(-0, 90, 0))
property.Add("Warehouse", 5000, {3048, 3036}, Vector(7130.7065429688, -12853.96875, 404.07025146484), Angle(-0, 90, 0))
property.Add("Warehouse", 5000, {3024, 3023}, Vector(-13373.96875, 12459.305664063, 591.26672363281), Angle(-0, 0, 0))
property.Add("Warehouse", 5000, {3011, 3021}, Vector(-1770.03125, 12319.708984375, 604.26971435547), Angle(-0, 180, 0))

property.Add("Club", 30000, {2326, 2327}, Vector(-9853.96875, -760.81506347656, 90.010726928711), Angle(-0, 0, 0))

property.Add("Storage", 1500, {2513}, Vector(-2969.1750488281, -4994.03125, 142.52056884766), Angle(-0, 270, 0))
property.Add("Storage", 1500, {2512}, Vector(-3127.2463378906, -4994.03125, 138.09268188477), Angle(-0, 270, 0))
property.Add("Storage", 1500, {2511}, Vector(-3487.2268066406, -4994.03125, 139.42520141602), Angle(-0, 270, 0))
property.Add("Storage", 1500, {2510}, Vector(-3646.6821289063, -4994.03125, 138.29974365234), Angle(-0, 270, 0))

function property.Get(prop)
	return property.Properties[prop]
end

function property.GetIndex(prop)
	for k, v in pairs(property.Properties) do
		if v == prop then
			return k
		end
	end
end

function property.CanAfford(prop, ply)
	return ply:getDarkRPVar("money") > prop.price
end

function property.AddOwner(prop, target, ply)
	if CLIENT then
		table.insert(property.Get(prop).householders, target)

		net.Start("Property Interact")
		net.WriteInt(PROPERTY_ADD, 8)
		net.WriteInt(prop, 8)
		net.WriteEntity(target)
		net.SendToServer()

		return
	end

	for k, ent in pairs(prop.doors) do
		ent = ents.GetMapCreatedEntity(ent)

	    local doorData = ent:getDoorData()
	    doorData.allowedToOwn = doorData.allowedToOwn or {}
	    doorData.allowedToOwn[target:UserID()] = true

	    DarkRP.updateDoorData(ent, "allowedToOwn")

	    property.BuyDoor(ent, target)
	end

	local t = prop.householders or {}
	table.insert(t, target)

	property.Update(prop, t)
end

function property.RemoveOwner(prop, target, ply)
	if CLIENT then
		table.RemoveByValue(property.Get(prop).householders, target)

		net.Start("Property Interact")
		net.WriteInt(PROPERTY_REMOVE, 8)
		net.WriteInt(prop, 8)
		net.WriteEntity(target)
		net.SendToServer()

		return
	end

	for k, ent in pairs(prop.doors) do
		ent = ents.GetMapCreatedEntity(ent)

	    ent:removeKeysAllowedToOwn(target)

	    property.SellDoor(ent, target)
	end

	local t = prop.householders or {}
	table.RemoveByValue(t, ply)

	property.Update(prop, t)
end

function property.BuyDoor(ent, ply)
	if not isentity(ent) then
		ent = ents.GetMapCreatedEntity(ent)
	end

    if ent:isKeysAllowedToOwn(ply) then
        ent:addKeysDoorOwner(ply)
        return
    end

    local Owner = ent:CPPIGetOwner()

    if not ent:isKeysOwned() and not ent:isKeysOwnedBy(ply) then
        local doorData = ent:getDoorData()
        doorData.owner = ply:UserID()
        DarkRP.updateDoorData(ent, "owner")
    end

    ply.OwnedNumz = ply.OwnedNumz or 1
    ply.Ownedz[ent:EntIndex()] = ent
end

function property.SellDoor(ent, ply)
	if not isentity(ent) then
		ent = ents.GetMapCreatedEntity(ent)
	end

    if not ply then
        ply = ent:getDoorOwner()

        if not IsValid(ply) then return end
    end

    if ent:isMasterOwner(ply) then
        local doorData = ent:getDoorData()
        ent:removeAllKeysExtraOwners()
        ent:setKeysTitle(nil)
        doorData.owner = nil
        DarkRP.updateDoorData(ent, "owner")
    else
        ent:removeKeysDoorOwner(ply)
    end

    ply.Ownedz[ent:EntIndex()] = nil
    ply.OwnedNumz = math.Clamp((ply.OwnedNumz or 1) - 1, 0, math.huge)

    if ent:isLocked() then
    	ent:Fire("Unlock")
    end
end

function property.Purchase(prop, ply)
	if CLIENT then
		net.Start("Property Interact")
		net.WriteInt(PROPERTY_BUY, 8)
		net.WriteInt(prop, 8)
		net.SendToServer()

		return
	end

	if prop.teams then
		return
	end

	if property.GetOwners(prop) then
		ply:ChatPrint("Bought!")

		return
	end

	if not property.CanAfford(prop, ply) then
		ply:ChatPrint("Can't afford! Hah!")

		return
	end

	for k, v in pairs(prop.doors) do
		property.BuyDoor(v, ply)
	end

	ply:addMoney(-prop.price)

	local t = prop.householders or {}
	table.insert(t, ply)

	property.Update(prop, t)
end

function property.Sell(prop, ply)
	if CLIENT then
		net.Start("Property Interact")
		net.WriteInt(PROPERTY_SELL, 8)
		net.WriteInt(prop, 8)
		net.SendToServer()

		return
	end

	if prop.teams then
		return
	end

	for k, v in pairs(prop.doors) do
		property.SellDoor(v, ply)
	end

	ply:addMoney(prop.price/4*3)

	prop.householders = {}

	property.Update(prop, prop.householders)
end

function property.GetOwners(prop)
	if prop.householders then
		return (#prop.householders > 0) and prop.householders or false
	end
end

function property.Update(prop, tbl)
	prop.householders = tbl

	net.Start("Property Interact")
	net.WriteInt(property.GetIndex(prop), 8)
	net.WriteTable(tbl)
	net.Broadcast()
end