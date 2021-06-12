function ANodeLinesUpdate() : INode() constructor
{
	// Loaded from outside
	count = 0;
	line0 = "";
	audio0 = "";
	style = kGabberStyleNormal;
	character = kCharacterNobody;
	
	// Internal state
	m_state = 0;
	m_currentLine = 0;
	m_gabber = null;
	
	static OnFrame = function()
	{
		if (m_state == 0)
		{
			// Create the message
			m_gabber = inew(o_ctsGabber);
			m_gabber.input.taskId = taskIndex;
			m_gabber.input.text = line0;
			m_gabber.input.style = style;
			
			// Parse dialogue
			parseDialogue();
			
			// Go to next state
			m_state = 1;
		}
		else if (m_state == 1)
		{
			// Wait for lines to go away
			
			//if (m_gabber.isDone)
			//{
			//	m_state = 2;
			//}
			if (!iexists(m_gabber) || m_gabber.state.close)
			{
				m_state = 2;
			}
		}
	};
	
	static IsDone = function()
	{
		return m_state >= 2;
	};
	
	static parseDialogue = function()
	{
		// Replace unicode characters for sanity
		m_gabber.input.text = string_replace_all(m_gabber.input.text, "\u2018", "'");
		m_gabber.input.text = string_replace_all(m_gabber.input.text, "\u2019", "'");
		m_gabber.input.text = string_replace_all(m_gabber.input.text, "\u201C", "\"");
		m_gabber.input.text = string_replace_all(m_gabber.input.text, "\u201D", "\"");
		
		// Initialize text
		m_gabber.display.text = "";
		for (var i = 0; i <= string_length(m_gabber.input.text); ++i)
		{
			m_gabber.display.flags[i] = null;
		}
		
		// Go through the input text character by character to parse
		var str_len = 0;
		for (var i = 1; i <= string_length(m_gabber.input.text); ++i)
		{
		    var next_char = string_char_at(m_gabber.input.text, i);
		    if (next_char == "$")
		    {   
				// Escape character! We pull the next character as the code.
		        i += 1;
		        next_char = string_char_at(m_gabber.input.text, i);
        
				// Create flags array if it does not exist yet.
				if (!is_array(m_gabber.display.flags[str_len]))
				{
					m_gabber.display.flags[str_len] = array_create(0);
				}
				// Add flag to the end of the array.
				var flags = m_gabber.display.flags[str_len];
				flags[array_length(flags)] = ord(next_char);
				m_gabber.display.flags[str_len] = flags;
		    }
		    else
		    {   
				// It's a display character! Just save it and keep track of the length.
		        m_gabber.display.text += next_char;
		        str_len++;
		    }
		}
		
		// Display text properly parsed.
	}
}