local del = Material("icon16/delete.png")
local add = Material("icon16/add.png")

hook.Add("PostDrawTranslucentRenderables", "Paint Property", function()
    for k, v in pairs(property.Properties) do
        if LocalPlayer():GetPos():Distance(v.tbl) > (15*70) or v.teams then
            continue
        end
        
        v.p = v.p or tdui.Create()

        local owner = property.GetOwners(property.Get(k))

        if owner then
            if owner[1] == LocalPlayer() then
                v.mode = v.mode or 1
                v.p:Rect(0, 0, 32+400+32, 100+32+50+100+32+(owner and (100+32+100+32) or 0), Color(30, 30, 30, 255), _)
                v.p:Text(v.name, "!Roboto@100", 32, 32, _, TEXT_ALIGN_LEFT)
                v.p:Text("$" .. v.price, "!Roboto@50", 32, 100+16, Color(235, 75, 75, 255), TEXT_ALIGN_LEFT)

                if v.p:Button("Sell property", "DermaLarge", 32, 100+32+50, 400, 100) then
                    property.Sell(k)
                end

                if v.p:Button((v.mode == 1) and "Manage owners" or "Done", "DermaLarge", 32, 100+32+50+100+32, 400, 100) then
                    v.mode = (v.mode == 1) and 2 or 1
                end

                if v.p:Button("Edit property", "DermaLarge", 32, 100+32+50+100+32+100+32, 400, 100) then
                end
            end
        else
            v.mode = v.mode or 1
            v.p:Rect(0, 0, 32+400+32, 100+32+50+100+32+(owner and (100+32+100+32) or 0), Color(30, 30, 30, 255), _)
            v.p:Text(v.name, "!Roboto@100", 32, 32, _, TEXT_ALIGN_LEFT)
            v.p:Text("$" .. v.price, "!Roboto@50", 32, 100+16, Color(75, 230, 75, 255), TEXT_ALIGN_LEFT)

            if v.p:Button("Buy property", "DermaLarge", 32, 100+32+50, 400, 100) then
                property.Purchase(k)
            end
        end

        local householders = v.householders
        if table.Count(householders) > 0 then
            v.rectw = v.rectw or 75+32+32+(#householders*(40+8))
            v.p:Rect(32+400+32+32, 0, 32+400+32, v.rectw, Color(30, 30, 30, 255), _)
            v.p:Text("Householders", "!Roboto@75", 32+400+32+32+(32+400+32)/2, 32, _, TEXT_ALIGN_CENTER)
            local h = 48+75

            if v.mode == 1 then
                v.rectw = 75+32+32+(#householders*(40+8))
                for _, p in pairs(householders) do
                    v.p:Text(p:Name(), "!Roboto@40", 32+400+32+32+32, h+((_-1)*(40)), _ == 1 and Color(0, 175, 255, 255) or Color(230, 230, 230, 255), TEXT_ALIGN_LEFT)
                end
            elseif v.mode == 3 and owner[1] == LocalPlayer() then
                if v.p:Button("Back", "!Roboto@40", 32+400+32+32+32, h+((1-1)*(50+12)), 400, 50) then
                    v.mode = 2
                end

                local num = 0
                for _, ___ in pairs(householders) do
                    if _==1 or (not IsValid(p)) then continue end
                    num = num + 1
                end

                for _, p in pairs(player.GetAll()) do
                    if table.HasValue(householders, p) then
                        continue
                    end

                    if v.p:Button({add, " ", p:Name()}, "!Roboto@40", 32+400+32+32+32, h+((num*(50+(k*12))))+32+64, 400, 50, Color(230, 230, 230, 255)) then
                        property.AddOwner(k, p)
                    end
                end
            elseif v.mode == 2 and owner[1] == LocalPlayer() then
                if v.p:Button("New householder", "!Roboto@40", 32+400+32+32+32, h+((1-1)*(50+12)), 400, 50) then
                    v.mode = 3
                end

                v.rectw = 75+32+32+(#householders*(50+12))
                for _, p in pairs(householders) do
                    if _ == 1 or (not IsValid(p)) then
                        continue
                    end

                    if v.p:Button({del, " ", p:Name()}, "!Roboto@40", 32+400+32+32+32, h+((_-1)*(50+12)), 400, 50, Color(230, 230, 230, 255)) then
                        property.RemoveOwner(k, p)
                    end
                end
            end
        end

        v.p:Cursor()
        local ang = v.tableang + Angle(0, 180, 0)
        v.p:Render(v.tbl, ang, 0.1)
    end
end)

net.Receive("Property Interact", function(len, server)
    local prop = net.ReadInt(8)
    local tbl = net.ReadTable()

    property.Get(prop).householders = tbl
end)