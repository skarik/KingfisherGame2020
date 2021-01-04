/// @description  is_displayable(char)
/// @param char
function is_displayable(char)
{
	var ch = ord(char);
	if (ch >= 32 && ch <= 126)
	{
		return true;
	}
	return false;
}

/// @description  is_numeral(char)
/// @param char
function is_numeral(char)
{
	var o = ord(char);
	return (o >= 48) && (o < 58);
}

/// @description  is_space(char)
/// @param char
function is_space(char)
{
	var o = ord(char);
	return (o > 8) && (o < 14) || (o == 32);
}
