/// @function string_rpos(substr,str)
/// @param substr : substring of text, string
/// @param str : string of text, string
/// @description Returns the right-most position of a substring within a string.
/// GMLscripts.com/license
function string_rpos(sub, str)
{
	var pos, ind;
	pos = 0;
	ind = 0;
	do {
		pos += ind;
		ind = string_pos(sub, str);
		str = string_delete(str, 1, ind);
	} until (ind == 0);
	return pos;
}

/// @function  string_rtrim_comment(str)
/// @param str : string of text, string
/// @description Returns the given string with a comment ("//") stripped from its end.
/// GMLscripts.com/license
function string_rtrim_comment(str)
{
	var l,r,o0,o1;
	//r = string_length(str);
	/*repeat (r - 1)
	{
	    o0 = ord(string_char_at(str,r));
	    o1 = ord(string_char_at(str,r));
	    if (o0 == ord('/') && o0 == o1) 
	    else r -= 1;
	}
	return string_copy(str,1,r);*/
	r = string_length(str);
	l = 0;
	repeat (r)
	{
	    o0 = ord(string_char_at(str,l));
	    o1 = ord(string_char_at(str,l+1));
	    if (o0 == ord("/") && o0 == o1) break;
	    l += 1;
	}
	return string_copy(str,1,l);
}

/// @function  string_split(str, delim, ignoreEmpty)
/// @param str : elements, string
/// @param delim : element separator,  string
/// @param ignoreEmpty : ignore empty substrings, bool
/// @description Returns an array containing all substring elements within
///              a given string which are separated by a given token.
///              eg. string_parse("cat|dog|house|bee", "|", true)
///                  returns an array [ "cat", "dog", "house", "bee" ]
/// GMLscripts.com/license
function string_split(str, token, ignore)
{
	var list,tlen,temp;
	list = array_create(0);
	tlen = string_length(token);
	while (string_length(str) != 0)
	{
		temp = 0;
		
		// Find position of any of the tokens
		for (var i = 0; i < tlen; ++i)
		{
			var l_token = string_char_at(token, i + 1);
			var l_temp = string_pos(l_token, str);
			if (temp == 0 || (l_temp != 0 && l_temp < temp))
				temp = l_temp;
		}
		
		// If any tokens, split on it
		if (temp)
		{
		    if (temp != 1 || !ignore)
				list[array_length(list)] = string_copy(str, 1, temp-1);
		    str = string_copy(str, temp + 1, string_length(str));
		}
		else
		{
			list[array_length(list)] = str;
		    str = "";
		}
	}
	return list;
}

/// @function  string_hex_to_integer(str)
/// @param str : elements, string
/// @descriptions Converts a string GUID to a integer. Ported from 1Engine/core-ext
function string_hex_to_integer(str)
{
	str = string_upper(str);
	var len = string_length(str);
	var identifier = 0x0;
	for (var offset = 0; offset < len; ++offset)
	{
		switch (string_char_at(str, offset + 1))
		{
		case "0":	break;
		case "1":	identifier |= 0x1 << (offset * 4); break;
		case "2":	identifier |= 0x2 << (offset * 4); break;
		case "3":	identifier |= 0x3 << (offset * 4); break;
		case "4":	identifier |= 0x4 << (offset * 4); break;
		case "5":	identifier |= 0x5 << (offset * 4); break;
		case "6":	identifier |= 0x6 << (offset * 4); break;
		case "7":	identifier |= 0x7 << (offset * 4); break;
		case "8":	identifier |= 0x8 << (offset * 4); break;
		case "9":	identifier |= 0x9 << (offset * 4); break;
		case "A":	identifier |= 0xA << (offset * 4); break;
		case "B":	identifier |= 0xB << (offset * 4); break;
		case "C":	identifier |= 0xC << (offset * 4); break;
		case "D":	identifier |= 0xD << (offset * 4); break;
		case "E":	identifier |= 0xE << (offset * 4); break;
		case "F":	identifier |= 0xF << (offset * 4); break;
		default:	show_error("Invalid character in GUID sequence.", true);
		}
	}
	return identifier;
}