/// @description Set up initial state

// based on initial state load up script?

// Create initial state
state = new AGameplayState();
// Create a struct
if (is_struct(global.InitialGameplayState))
{
	state = global.InitialGameplayState;
}

inew(o_TestRenderChara);
inew(o_TestSequence12);