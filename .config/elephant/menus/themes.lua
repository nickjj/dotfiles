Name = "themes"
NamePretty = "Themes"
Description = "Pick available themes"
Icon = "image-x-generic"
HideFromProviderlist = true
Action = "dot-theme-set %VALUE%"
Cache = false

local themes_dir = os.getenv("DOTFILES_PATH") .. "/_themes/"

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

local function WallpaperCount(data_path)
	local command = string.format("jq '.wallpaper.synergy | length // 0' %q 2>/dev/null", data_path)
	local handle = io.popen(command)

	if not handle then
		return 0
	end

	local count = handle and handle:read("*all"):gsub("%s+", "")
	handle:close()

	return count
end

function GetEntries()
	local entries = {}

	local command = "find " .. themes_dir .. " -mindepth 1 -maxdepth 1 -type d -printf '%P\\n' 2>/dev/null"
	local handle = io.popen(command)

	if not handle then
		return entries
	end

	for theme in handle:lines() do
		local full_path = themes_dir .. theme
		local theme_data_path = full_path .. "/_theme.json"
		local preview_path = full_path .. "/_preview.jpg"
		local wallpaper_count = WallpaperCount(theme_data_path)

		table.insert(entries, {
			Text = PrettyName(theme),
			Subtext = theme .. " has " .. wallpaper_count .. " wallpaper(s)",
			Value = theme,
			Icon = preview_path,
			Preview = preview_path,
		})
	end

	return entries
end
