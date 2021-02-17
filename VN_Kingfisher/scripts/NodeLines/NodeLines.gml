function ANodeLines() : INode() constructor
{
	// Loaded from outside
	count = 0;
	line0 = "";
	audio0 = "";
	style = kGabberStyleNormal;
	
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
		}
	};
	
	static IsDone = function()
	{
		return m_state >= 2;
	};
}

#macro kGabberStyleNormal 0
#macro kGabberStyleNarration 1
#macro kGabberStyleIncidental 2

function AGabberInput() constructor
{
	actor = null;
	name = "";
	text = "";
	
	priority = true;
	disable = false;
	audio = null;
	autoclose = false;
	minimal = false;
	
	style = kGabberStyleNormal;
	
	taskId = null;	// Id of the task. If it's the main task ID, it should be null or 0.
					// Otherwise, it should not take input.
}