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
	next = 0x00000000;
	
	/// @function virtual Run()
	static Run = function()
	{
		// Nothing.
	};
	/// @function virtual IsDone()
	static IsDone = function()
	{
		return true; // Continue onto the next node.
	};
	
	
	// System properties. These should never need to be overridden:
	
	static IsTaskStart = function()
	{
		return false;
	}
}