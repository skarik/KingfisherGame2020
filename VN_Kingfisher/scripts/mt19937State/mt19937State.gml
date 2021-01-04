/// @function mt19937_get_state()
/// @description Copies the internal randomizer state and returns the copy.
function mt19937_get_state()
{
	var state = array_create(STATE_VECTOR_LENGTH + 1);
	array_copy(state, 0, global.rand_mt, 0, STATE_VECTOR_LENGTH);
	state[STATE_VECTOR_LENGTH] = global.rand_index;
	return state;
}

/// @function mt19937_set_state(state)
/// @param state : State structure.
/// @description Restores randomizer state from given structure.
function mt19937_set_state(state) 
{
	array_copy(global.rand_mt, 0, state, 0, STATE_VECTOR_LENGTH);
	global.rand_index = state[STATE_VECTOR_LENGTH];
}
