Name = "wallpapers"
NamePretty = "Wallpapers"
Description = "Pick available wallpapers for active theme"
Icon = "image-x-generic"
HideFromProviderlist = true
Action = "dot-theme-set-bg %VALUE%"
Cache = false

local wallpapers_dir = os.getenv("DOTFILES_PATH") .. "/_wallpapers/"

local theme_data_path = os.getenv("XDG_CONFIG_HOME") .. "/wallpaper/theme.json"
local theme_data = io.open(theme_data_path, "r")

local function PrettyName(str)
	-- Strip file extension.
	local pretty_name = str:gsub("%.%w+$", "")

	pretty_name = pretty_name:gsub("[_-]", " ")

	-- Capitalize every word.
	pretty_name = pretty_name:gsub("(%a)([%w]*)", function(first, rest)
		return first:upper() .. rest:lower()
	end)

	return pretty_name
end

local function ActiveTheme(path)
	local command = string.format("basename $(dirname $(readlink -f %q))", path)
	local handle = io.popen(command)

	if not handle then
		return "unknown"
	end

	-- Trim trailing new line from shell readlink command.
	local theme = handle:read("*a"):gsub("%s+$", "")
	handle:close()

	return theme
end

local active_theme = ActiveTheme(theme_data_path)

function GetEntries()
	if not theme_data then
		return {}
	end

	local content = theme_data:read("*all")
	theme_data:close()

	local entries = {}

	local synergized_wallpapers = content:match('"synergy"%s*:%s*%[(.-)%]')
	if not synergized_wallpapers then
		return entries
	end

	for name in synergized_wallpapers:gmatch('"([^"]+)"') do
		table.insert(entries, {
			Text = PrettyName(name),
			Subtext = name .. " synergizes with " .. PrettyName(active_theme),
			Value = name,
			Icon = wallpapers_dir .. name,
			Preview = wallpapers_dir .. name,
		})
	end

	return entries
end
