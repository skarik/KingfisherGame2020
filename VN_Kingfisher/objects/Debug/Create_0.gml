// This motherfucker best be alive at all times
persistent = true;

captureModeEnabled = false;
recordModeEnabled = false;
convention_mode = false; // turn on for convention demos
demo_mode = false;

// Enable debug mode for now
on = false;
enable_gmlive = false;

// Debug lines:
debug_line[0] = "";
debug_line_count = 0;

// Debug mode restart all swatch:
reset = convention_mode || demo_mode;// || debug_mode;

// Debug effects
//var record_overlay = inew(o_debugRecordOverlay);
//	record_overlay.persistent = true;

// status
gifWidth = 560;//Screen.width;// / Screen.pixelScale;
gifHeight = 560;//Screen.height;// / Screen.pixelScale;

if (convention_mode || demo_mode)
{
	window_set_fullscreen(true);
}

show_debug_overlay(true);