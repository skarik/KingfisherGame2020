function SequenceBackendGameInit()
{
	array_push(global.sequenceTypes,
		["vn_lines", ANodeLines],
		["vn_linesupdate", ANodeLinesUpdate],
		["vn_portrait", ANodePortrait],
	);
}

// Following defined in Kingfisher.sel

#macro kGabberStyleNormal 0
#macro kGabberStyleNarration 1
#macro kGabberStyleIncidental 2
#macro kGabberStylePortrait 3
#macro kGabberStyleDiegetic 4
#macro kGabberStyleTutorial 5
#macro kGabberStyleThinking 6
#macro kGabberStyleReward 7
#macro kGabberStyleMumbled 8

function EnumFromGabberStyle (str)
{
	str = string_lower(str);
	if (str == "gabber")		return kGabberStyleNormal;
	if (str == "default")		return kGabberStyleNormal;
	if (str == "narration")		return kGabberStyleNarration;
	if (str == "incidental")	return kGabberStyleIncidental;
	if (str == "portrait")		return kGabberStylePortrait;
	if (str == "diegetic")		return kGabberStyleDiegetic;
	if (str == "tutorial")		return kGabberStyleTutorial;
	if (str == "thinking")		return kGabberStyleThinking;
	if (str == "reward")		return kGabberStyleReward;
	if (str == "mumbled")		return kGabberStyleMumbled;
	show_error("Invalid gabber type \"" + str + "\"", false);
}

#macro kCharacterNobody 0
#macro kCharacterKillian 1
#macro kCharacterYuuto 2
#macro kCharacterMicolash 3
#macro kCharacterVincent 4
#macro kCharacterOsric 5
#macro kCharacterJuliet 6
#macro kCharacterSummer 7
#macro kCharacterLydia 8
#macro kCharacterFrank 9
#macro kCharacterOkinobu 10
#macro kCharacterLibrarian 128

function EnumFromCharacter (str)
{
	str = string_lower(str);
	if (str == "nobody")		return kCharacterNobody;
	if (str == "killian")		return kCharacterKillian;
	if (str == "yuuto")			return kCharacterYuuto;
	if (str == "micolash")		return kCharacterMicolash;
	if (str == "vincent")		return kCharacterVincent;
	if (str == "osric")			return kCharacterOsric;
	if (str == "juliet")		return kCharacterJuliet;
	if (str == "summer")		return kCharacterSummer;
	if (str == "lydia")			return kCharacterLydia;
	if (str == "frank")			return kCharacterFrank;
	if (str == "okinobu")		return kCharacterOkinobu;
	
	if (str == "librarian")		return kCharacterLibrarian;
	if (str == "libby")			return kCharacterLibrarian;
	show_error("Invalid character type \"" + str + "\"", false);
}

#macro kExpressionNeutral 0

function EnumFromExpression (str)
{
	str = string_lower(str);
	if (str == "neutral")		return kExpressionNeutral;
	
	show_error("Invalid expression type \"" + str + "\"", false);
}