function ANodeGeneric() : INode() constructor
{
	state = 0;
	
	static OnFrame = function()
	{
		if (state == 0)
		{
			show_message("Starting generic node with guid \"" + string(guid) + "\"");
			state = 1;
		}
		else if (state == 1)
		{
			// Wait for anything to be pressed
			if (keyboard_check_pressed(vk_anykey))
			{
				state = 2;
			}
		}
	};
	
	static IsDone = function()
	{
		return state >= 2;
	};
}