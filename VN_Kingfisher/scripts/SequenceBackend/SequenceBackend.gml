function SequenceBackendInit()
{
	global.sequenceTypes = [
		["maintask", ATaskNodeStart],
		["sidetask", ITaskNode],
		["generic", ANodeGeneric],
	];
}

function INode() constructor
{
	// The type of the node
	type = ""; 
	// The GUID of the given node.
	guid = 0x00000000;
	// If nonzero, refers to the node to jump to after this one.
	// If zero, the node will continue onto the next node.
	// If 0xFFFFFFFF, the execution will jump past the end and stop.
	next = 0x00000000;
	
	// Refers to the current task index that is running this node.
	// This will be set before OnFrame is called.
	taskIndex = null;
	
	/// @function virtual OnLoad()
	static OnLoad = function()
	{
		// Nothing.
	};
	/// @function virtual OnFrame()
	static OnFrame = function()
	{
		// Nothing.
	};
	/// @function virtual IsDone()
	static IsDone = function()
	{
		return true; // Continue onto the next node.
	};
	
	/// @function virtual OnCleanup()
	static OnCleanup = function()
	{
		// Nothing.
	};
	
	// System properties. These should never need to be overridden:
	
	static IsTaskStart = function()
	{
		return false;
	}
}