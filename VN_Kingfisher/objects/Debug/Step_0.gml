// Is tilde pressed?
if ( keyboard_check_pressed(192) )
{
    // Toggle the menu when it is pressed down:
	if (!on)
	{
		// Enable & create debug menu
		on = true;
		visible = true;
		//if (!iexists(o_debugMenu)) {
		//	inew(o_debugMenu);	
		//}
	}
	else
	{
		// Disable debug menu
		on = false;
		visible = false;
	}
}