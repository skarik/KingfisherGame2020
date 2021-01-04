/// @function fioWatchFile(localPath, interval)
/// @param localPath : path to the local file
/// @param interval : interval in which to check the file
/// @return Watch handle
/// @description Creates a watch structure.
function fioWatchFile(localPath, interval)
{
	var watch_state = {};
	watch_state.valid = false;
	if (global.fio_development)
	{
		var filename = fioLocalFileFindAbsoluteFilepath(localPath);
		if (is_string(filename))
		{
			watch_state.age = 0;
			watch_state.filename = filename;
			watch_state.valid = true;
		}
	}
	
	return watch_state;
}

/// @function fioWatchHasChange(watchHandle)
/// @param watchHandle
/// @description Checks if the file has been changed since the last check.
function fioWatchHasChanged(watchHandle)
{
	var watch_state = watchHandle;
	if (watch_state.valid == false)
	{
		return false;
	}
	return false;
}