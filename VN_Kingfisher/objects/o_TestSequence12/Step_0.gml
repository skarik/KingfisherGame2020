/// @description Test seq

SequenceUpdate();

// debug tools to go forward and back
/*if (window_has_focus())
{
	if (keyboard_check_pressed(vk_pageup))
	{
		// Go back
		
	}
}*/

// have a "reload to position" tool.
// states of BG and FG should stay the same.
// reload the current script should suffice

if (window_has_focus())
{
	if (keyboard_check_pressed(vk_home))
	{
		SequenceCleanup();
		SequenceLoad(sqm_source_filename);
	}
}