/// @function inew(object_to_create)
/// @param object_to_create
function inew(obj_ind)
{
	return instance_create_depth(0, 0, 0, obj_ind);
}

/// @function inew_unique(object_to_create)
/// @param object_to_create
function inew_unique(obj_ind)
{
	if (!iexists(obj_ind))
	{
		return instance_create_depth(0, 0, 0, obj_ind);
	}
	return null;
}

/// @function  idelete(object_to_delete)
/// @param object_to_delete
function idelete(obj)
{
	if (obj == noone)
		return 0;
	with (obj)
	{
	    instance_destroy();
	}  
	return 0;
}

/// @function  iexists(object_to_check)
/// @param object_to_check
function iexists(obj)
{
	return instance_exists(obj);
}

/// @function place_unique(x, y, object_to_create)
/// @param x
/// @param y
/// @param object_to_create
function place_unique(x, y, obj_ind)
{
	if ( !position_meeting(x, y, obj_ind) )
	{
	    return instance_create_layer(x, y, layer, obj_ind);
	}
	return null;
}
