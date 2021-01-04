/// @function mt19937_random_range(min, max)
/// @param min : Min value to get (inclusive)
/// @param max : Max value to get (exclusive)
/// @description Returns a random double value in the given range.
function mt19937_random_range(minimum, maximum)
{
	var random_value = mt19937_rand();

	var delta = maximum - minimum;
	var random_value_rescaled = (random_value / (0xffffffff + 1.0)) * delta;

	return random_value_rescaled + minimum;
}


/// @function mt19937_choose(...)
/// @param ... : Values to choose from
/// @description Selects a random value from the inputs
function mt19937_choose()
{
	var value = floor(mt19937_random_range(0, argument_count));
	return argument[value];
}
