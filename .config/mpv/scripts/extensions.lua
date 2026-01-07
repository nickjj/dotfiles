local function zoom_reset()
	mp.set_property("window-scale", 1.0)
	mp.set_property("video-zoom", 0)
	mp.osd_message("Reset Scale / Zoom: 1.0x")
end

mp.add_key_binding(nil, "zoom_reset", zoom_reset)
