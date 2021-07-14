function ANodePortrait() : INode() constructor
{
	// Loaded from outside
	sprite_index = -1;
	time = 0.2;
	wait_for_finish = true;
	character = kCharacterNobody;
	expression = kExpressionNeutral;
	
	// Internal state
	m_state = 0;
	m_timing = 0.0;
	m_sideRoutine = null;
	
	static OnLoad = function()
	{
		if (is_string(character))
		{
			character = EnumFromCharacter(character);
		}
		
		if (is_string(expression))
		{
			expression = EnumFromExpression(expression);
		}
		
		if (!wait_for_finish)
		{
			// Start up a sideloaded routine that uses this struct.
			show_error(string(self.id), true);
			
			m_sideRoutine = CreateOnStep(self.id, OnFrame, IsAsyncDone);
		}
	};
	
	static OnFrame = function()
	{
		if (m_state == 0)
		{
			// create chara
			var chara = inew(o_ctsChara);
			chara.input.character = character;
			chara.input.expression = expression;
			
			m_state = 1;
		}
		else if (m_state == 1)
		{
			m_timing += Time.deltaTime;
		}	
	};
	
	static IsDone = function()
	{
		return wait_for_finish == false || IsAsyncDone();
	};
	
	static IsAsyncDone = function()
	{
		return m_timing >= time;
	};
	
	static OnCleanup = function()
	{
		if (m_sideRoutine != null)
		{
			StopOnStep(m_sideRoutine);
			m_sideRoutine = null;
		}
	};
}

function APortraitInput() constructor
{
	spriteIndex = null;
	
	character = kCharacterNobody;
	expression = kExpressionNeutral;
	
	taskId = null;	// Id of the task. If it's the main task ID, it should be null or 0.
					// Otherwise, it should not take input.
}