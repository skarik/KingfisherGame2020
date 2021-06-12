/// @function fioWatchFile(localPath, interval)
/// @param localPath : path to the local file
/// @param interval : interval in seconds in which to check the file
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
			watch_state.checkInterval = interval;
			watch_state.lastChecked = current_time;
			watch_state.filename = filename;
			watch_state.valid = true;
			watch_state.editData = oneCoreFileGetLastWriteTime(filename);
		}
	}
	
	return watch_state;
}

/// @function fioWatchHasChange(watchHandle)
/// @param watchHandle
/// @description Checks if the file has been changed since the last check.
function fioWatchHasChange(watchHandle)
{
	var watch_state = watchHandle;
	if (watch_state.valid == false)
	{
		return false;
	}
	
	if (current_time - watch_state.lastChecked > watch_state.checkInterval * 1000)
	{
		watch_state.lastChecked = current_time;
		
		var lastWriteTime = oneCoreFileGetLastWriteTime(watch_state.filename);
		if (lastWriteTime != watch_state.editData)
		{
			watch_state.editData = lastWriteTime;
			return true;
		}
	}
	return false;
}