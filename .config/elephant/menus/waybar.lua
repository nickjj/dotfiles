Name = "waybar"
NamePretty = "Waybar"
Description = "Mouse actions for Waybar"
Icon = "input-mouse"
HideFromProviderlist = true
Action = "%VALUE%"
Cache = false

local config = io.open(os.getenv("XDG_CONFIG_HOME") .. "/waybar/config.jsonc", "r")

function GetEntries()
	if not config then
		return {}
	end

	local content = config:read("*all")
	config:close()

	local entries = {}

	-- Strip single and multi-line comments.
	content = content:gsub("\n%s*//[^\n]*", ""):gsub("/%*.-%*/", ""):gsub("%\n", " ")

	-- These aren't normal commands we can execute, they are internal to Waybar,
	-- we'll still display them but won't run them.
	local module_action = { tz_up = 1, tz_down = 1, activate = 1, toggle = 1 }

	local on_event_map = {
		["on-click"] = "Left Click",
		["on-click-right"] = "Right Click",
		["on-click-middle"] = "Middle Click",
		["on-click-backward"] = "Backward Click",
		["on-click-forward"] = "Forward Click",
		["on-scroll-up"] = "Scroll Up",
		["on-scroll-down"] = "Scroll Down",
	}

	-- Parse module blocks: "name": { ... }
	for mod, block in content:gmatch('"([^"]+)":%s*(%b{})') do
		if not mod:find("^modules%-") then
			-- Parse keys: "on-click": "command"
			for key, command in block:gmatch('"([^"]+)":%s*"%s*(.-)%s*"[%s,}]') do
				local label = on_event_map[key]

				if not label then
					goto continue
				end

				-- Unescape escaped JSON slashes.
				local cmd_parsed = command:gsub('\\"', '"')

				local text = mod:gsub("^%l", string.upper)
				local sub_text = cmd_parsed
				local value = sub_text
				local icon = Icon

				if module_action[cmd_parsed] ~= nil then
					sub_text = "(Module Action) " .. sub_text
					value = ""
					icon = "help-about-symbolic"
				end

				table.insert(entries, {
					Text = text .. ": " .. label,
					Subtext = sub_text,
					Value = value,
					Icon = icon,
				})

				::continue::
			end
		end
	end

	return entries
end
