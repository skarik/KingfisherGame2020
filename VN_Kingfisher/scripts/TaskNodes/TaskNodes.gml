function ITaskNode() : INode() constructor
{
	static IsTaskStart = function()
	{
		return true;
	};
}

function ATaskNodeStart() : ITaskNode() constructor
{
}