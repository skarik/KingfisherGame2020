/// @func array_any_not(array, value)
/// @param array {Array 1d}
/// @param value
function array_any_not(array, value)
{
	var len = array_length(array);
	for (var i = 0; i < len; ++i)
	{
		if (array[i] != value)
		{
			return true;
		}
	}
	return false;
}

/// @function array_concat(array0, array1)
/// @param array0
/// @param array1
function array_concat(array0, array1)
{
	var result = array_create(0);
	var len0 = array_length(array0);
	array_copy(result, 0, array0, 0, len0);
	array_copy(result, len0, array1, 0, array_length(array1));
	return result;
}

/// @func array_contains(array, value)
/// @param array {Array 1d}
/// @param value
function array_contains(array, value)
{
	var len = array_length(array);
	for (var i = 0; i < len; ++i)
	{
		if (array[i] == value)
		{
			return true;
		}
	}

	return false;
}

/// @function array_get_index(array, value)
/// @param array
/// @param value
function array_get_index(array, value)
{
	var array_len = array_length(array);
	for (var i = 0; i < array_len; ++i)
	{
		if (array[i] == value)
		{
			return i;
		}
	}
	return null;
}

///@function array_resize(array, length)
///@param array
///@param length
function array_resize(array, length)
{
	var current_length = array_length(array);

	if (length != current_length)
	{
		var new_array = array_create(length);
		array_copy(new_array, 0, array, 0, min(length, current_length));
		return new_array;
	}

	return array;
}
