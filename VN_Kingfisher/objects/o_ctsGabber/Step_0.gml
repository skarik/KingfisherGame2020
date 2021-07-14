/// @description Insert description here
// You can write your code in this editor

display.time += Time.deltaTime;

// Step through the string and display characters
if ( display.delay > 0.0 )
{
	display.delay -= Time.deltaTime;
}
else
{
	var l_displaySpeed = 60; // TODO: Pull this from settings.
	if (display.shake != EGabberShake.None)
	{
		l_displaySpeed *= 0.3;
	}
	
	var previous_display_count = display.count;
	if ( image_alpha > 0.5 )
	{
		display.count += Time.deltaTime * l_displaySpeed;
	}
	
	// Limit the count to the length of the display string
	display.count = min( string_length(display.text), display.count);
	
	// Check if we went to a new character and update behavior
	var current_display_count = floor(display.count);
	for (var i = previous_display_count; i < current_display_count; ++i)
	{
		// Do flag-based updates
		var flags = display.flags[ceil(i)];
		if (is_array(flags))
		{
			var flags_len = array_length(flags);
			for (var flagIndex = 0; flagIndex < flags_len; ++flagIndex)
			{
				var flag = flags[flagIndex];
				// $p: delay 0.5s
				if (flag == ord("p"))
				{
					display.delay = 0.5;
				}
				// $k: shake per-letter
				else if (flag == ord("k"))
				{
					display.shake = EGabberShake.PerLetter;
				}
				// $$: reset all display states:
				else if (flag == ord("$"))
				{
					display.shake = EGabberShake.None;
				}
			}
		}
		
		// Do per-character effects
		if (display.shake == EGabberShake.PerLetter)
		{
			// TODO: shake
		}
		
		// Play sound on a new character
		if ((floor(i) % 6) == 0 || display.delay > 0.0)
		{
			// Do audio playing
			/*var audio = sound_play_channel("audio/ui/message_bep_type.wav", kSoundChannelUi);
			audio.gain = random_range(0.3, 0.4) * 0.5;
			audio.pitch = choose(0.2, 0.2, 0.25, 0.25, 0.3) * 4.0;*/
			// TODO: Audio
		}
		
		// Stop outputting text if there's any sort of delay
		if (display.delay > 0.0)
		{
			display.count = i + 1 + frac(display.count);
			break;
		}
    } // End for-loop (adding characters & parsing effects)
}

// Check for end-of-string behavior
var l_canEnd = false;
if (display.count >= string_length(display.text))
{
	l_canEnd = true;
	// TODO: fade in done alpha
}
else
{
	// TODO: fade out done alpha
}

// We ready to continue?
if (l_canEnd)
{
	if (!input.disable && !input.minimal)
	{
		// Poll input
		if (window_has_focus() && keyboard_check_pressed(vk_anykey))
		{
			if (!state.close)
			{
				state.close = true;
			}
		}
	}
}
else
{
	// Clear input
}


// Fade automatically over time if the option is given
if ( input.disable || !input.priority )
{
    if ( display.time > max(1.0, 0.2 + string_length(display.text) / 8) )
    {
        state.close = true;
    }
}
if ( input.autoclose )
{
    if ( display.count >= string_length(display.text) - 2 &&
         display.time > max(0.5, string_length(display.text) / 50) )
    {
        state.close = true;
    }
}


// Fade in and out
if (!state.close)
{
	// Fade in
}
else 
{
	idelete(this);
	exit;
}