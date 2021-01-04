/// @function string_fix_whitespace(string)
/// @param string
/// @description Replaces all whitespace in the string with spaces.
function string_fix_whitespace(str)
{
	var result,l,r,o;
	result = "";
	l = 1;
	r = string_length(str);
	repeat (r)
	{
		o = string_char_at(str,l);
		if (is_space(o)) {
			result += " ";
		}
		else {
			result += o;
		}
		l++;
	}
	return result;
}

/// @function  string_ltrim(str)
/// @param str " string of text, string
/// @description Returns the given string with whitespace stripped from its start.
///              Whitespace is defined as SPACE, TAB, NL, VT, FF, CR.
/// GMLscripts.com/license
function string_ltrim(str)
{
	var l,r,o;
	l = 1;
	r = string_length(str);
	repeat (r) {
		o = ord(string_char_at(str, l));
		if ((o > 8) && (o < 14) || (o == 32)) l += 1;
		else break;
	}
	return string_copy(str, l, r-l+1);
}

/// @function  string_rtrim(str)
/// @param str : string of text, string
/// @description Returns the given string with whitespace stripped from its end.
///              Whitespace is defined as SPACE, TAB, NL, VT, FF, CR.
/// GMLscripts.com/license
function string_rtrim(str)
{
	var r,o;
	r = string_length(str);
	repeat (r) {
		o = ord(string_char_at(str, r));
		if ((o > 8) && (o < 14) || (o == 32)) r -= 1;
		else break;
	}
	return string_copy(str,1,r);
}

