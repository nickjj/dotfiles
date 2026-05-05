-- Create an auto-incremented clip of the media based on setting 2 markers.

local utils = require("mp.utils")

local mark_1 = nil
local mark_2 = nil

-- Add a temporary chapter to the player's timeline to act as a visual marker.
local function set_visual_mark(num)
	local time_pos = mp.get_property_number("time-pos")

	if num == 1 then
		mark_1 = time_pos
	else
		mark_2 = time_pos
	end

	local chapters = {}
	if mark_1 then
		table.insert(chapters, { title = "Clip start", time = mark_1 })
	end
	if mark_2 then
		table.insert(chapters, { title = "Clip end", time = mark_2 })
	end

	mp.set_property_native("chapter-list", chapters)

	local message = string.format("Mark %d: %s", num, mp.format_time(time_pos))

	if mark_1 and mark_2 then
		local duration = math.abs(mark_1 - mark_2)

		message = message .. " (duration: " .. mp.format_time(duration) .. ")"

		if num == 2 then
			mp.set_property("pause", "yes")
		end
	end

	mp.osd_message(message, 3)
end

-- Clear the visual chapters and reset marks.
local function clear_marks()
	mark_1 = nil
	mark_2 = nil

	mp.set_property_native("chapter-list", {})
	mp.osd_message("Marks cleared")
end

local function create()
	if not (mark_1 and mark_2) then
		mp.osd_message("Both mark 1 and 2 must be set, aborting!")
		return
	end

	-- Be more user friendly by always creating a clip within the marker range,
	-- even if mark 1 comes after mark 2.
	local start_time = math.min(mark_1, mark_2)
	local end_time = math.max(mark_1, mark_2)

	if end_time - start_time < 0.1 then
		mp.osd_message("Clip duration too short, aborting!")
		return
	end

	local input_path = mp.get_property("path")
	local dir, filename = utils.split_path(input_path)
	local basename = mp.get_property("filename/no-ext")
	local extension = filename:match("%.%w+$") or ""

	local output_path

	-- Increment the filename with -1, -2, etc..
	local counter = 1
	repeat
		output_path = utils.join_path(dir, basename .. "-" .. counter .. extension)
		counter = counter + 1
	until not utils.file_info(output_path)

	-- Extra layer of defense in case the increment logic gets changed and a bug
	-- is introduced. We never ever ever want to overwrite the original file.
	if input_path == output_path then
		mp.osd_message("Input and output path cannot be the same, aborting!")
		return
	end

	-- Create the clip without re-encoding the file.
	local ffmpeg_command = {
		"ffmpeg",
		"-ss",
		tostring(start_time),
		"-to",
		tostring(end_time),
		"-i",
		input_path,
		"-c",
		"copy",
		output_path,
	}

	mp.command_native_async({
		name = "subprocess",
		args = ffmpeg_command,
		capture_stderr = true,
	}, function(success, result, error)
		if success and result.status == 0 then
			-- This is commented out to reference that it could be done here but for
			-- creating clips I find that sometimes I want to extend mark 2 by a few
			-- seconds afterwards and this avoids them being auto-cleared.
			--clear_marks()

			-- Ensure the clip has the original file's timestamp information.
			local touch_command = { "touch", "-r", input_path, output_path }
			mp.command_native_async({ name = "subprocess", args = touch_command })

			mp.osd_message("Clip saved: " .. output_path, 3)
		else
			local error_message = error or (result and result.stderr) or "Unknown error"
			error_message = error_message:gsub("%s+$", "")

			print("Error:\n" .. error_message)
			mp.osd_message("FFmpeg failed, check the console (` key) for details, aborting!", 3)
		end
	end)
end

mp.add_key_binding(nil, "mkclip_mark_start", function()
	set_visual_mark(1)
end)
mp.add_key_binding(nil, "mkclip_mark_end", function()
	set_visual_mark(2)
end)
mp.add_key_binding(nil, "mkclip_create", create)
mp.add_key_binding(nil, "mkclip_clear_marks", clear_marks)
