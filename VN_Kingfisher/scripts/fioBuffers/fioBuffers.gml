/// @function fioReadToBuffer(localPath)
/// @param localPath : path to the local file
function fioReadToBuffer(localPath)
{
	var filename = fioLocalFileFindAbsoluteFilepath(localPath);
	if (is_string(filename))
	{
		var buf = buffer_load(filename);
		return buf;
	}
	return null;
}

/// @function fioReadToString(localPath)
/// @param localPath : path to the local file
function fioReadToString(localPath)
{
	var buf = fioReadToBuffer(localPath);
	if (buf != null)
	{
		var buf_size = buffer_get_size(buf);
		var str = "";
		for (var byteIndex = 0; byteIndex < buf_size; ++byteIndex)
		{
			str += chr(buffer_read(buf, buffer_u8));
		}
		buffer_delete(buf);
		
		return str;
	}
	return null;
}