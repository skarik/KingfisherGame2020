function ITaskNode() : INode() constructor
{
	static OnLoad = function()
	{
		if (is_string(goto))
		{
			goto = string_hex_to_integer(goto);
		}
	};
	
	static IsTaskStart = function()
	{
		return true;
	};
}

function ATaskNodeStart() : ITaskNode() constructor
{
}