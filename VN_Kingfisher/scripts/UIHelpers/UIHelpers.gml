/// @function UIShowPopup(text)
/// @param text		Text to show in the popup
function UIShowPopup ( text )
{
	var popup = inew(ui_SystemNotifier);
	popup.text = text;
	return popup;
}