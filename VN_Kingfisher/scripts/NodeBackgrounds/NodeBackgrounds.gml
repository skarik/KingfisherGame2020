function ANodeWait() : INode() constructor
{
	// Loaded from outside
	time = 0.2;
	
	// Internal state
	m_timing = 0.0;
	
	static OnFrame = function()
	{
		m_timing += Time.deltaTime;
	};
	
	static IsDone = function()
	{
		return m_timing >= time;
	};
}