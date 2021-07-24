function AGameplayState() constructor
{
	startingScript = "seq/demo_v1.txt";
}

function GameInit()
{
	EngineInit();
	// Add game-specific node types to the sequence system
	SequenceBackendGameInit();
	
	global.InitialGameplayState = null;
}

#macro kDepthDebugBase		-1000
#macro kDepthUiBase			-100
#macro kDepthCharacter		0
#macro kDepthBackground		100