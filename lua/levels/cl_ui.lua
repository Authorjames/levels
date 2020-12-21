concommand.Add("levels_menu", function()
	local frame = semantic.add("frame", {
		w = scalew(75),
		h = scale(75),
		center = true,
		title = "Levels",
		footer = function(panel)
			panel.Text = "Version 1.0"
		end,
	})

	local function preview(frame)
		local message = frame:addto("message", {
			h = scale(6),
		})

		local primary = frame:addto("button", {
			dock = TOP,
			h = scale(4),
			margin = MARGIN_DEFAULT,
			text = "Primary",
			type = BUTTON_PRIMARY,
		})

		local standard = frame:addto("button", {
			dock = TOP,
			h = scale(4),
			margin = MARGIN_DEFAULT,
			text = "Standard",
			type = BUTTON_STANDARD,
		})

		local divider = frame:addto("divider", {
			text = "Divider",
		})

		local input = frame:addto("input", {
			dock = TOP,
			h = scale(4),
			margin = MARGIN_DEFAULT,
			text = "Search.."
		})

		local text = frame:addto("text", {
			dock = TOP,
			margin = {scale(2.5), scale(2.5), scale(2.5), scale(2.5)},
			h = scale(5),
		})

		text:AppendLine({
		    Type = "Font",
            Data = "Lato Text Regular",
        },
        {
            Type = "Color",
            Data = semantic.color.text,
        },
        {
            Type = "Text",
            Data = [[Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.]],
        },
        {
            Type = "Spacer",
            Data = 16
		})
	end

	local sidebar = frame:addto("sidebar", {
		dock = LEFT,
		w = frame:GetWide(),

		items = {
			{
				text = "Home",
				func = function(panel)
					preview(panel)
				end,
			},
			{
				text = "Topics",
				func = function(panel)
					
				end,
			},
			{
				text = "Friends",
				func = function(panel)
					
				end,
			},
			{
				text = "History",
				func = function(panel)
					
				end,
			},
		},
	})
end)