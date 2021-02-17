function AGameplayState() constructor
{
	startingScript = "seq/test2_v1.txt";
}

function GameInit()
{
	EngineInit();
	
	global.InitialGameplayState = null;
}

#macro kDepthDebugBase		-1000
#macro kDepthUiBase			-100
#macro kDepthCharacter		0
#macro kDepthBackground		100