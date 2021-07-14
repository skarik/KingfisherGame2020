var scale = 1.5 * Screen.height / 720.0;

draw_set_color(c_black);
draw_set_alpha(alpha * 0.3);
draw_roundrect(
	scale * x, scale * y,
	scale * (x + width), scale * (y + height),
	false);

var kMargins = 10;

draw_set_color(c_white);
draw_set_alpha(alpha * 1.0);
draw_set_font(f_sysDebug40);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext_transformed(
	scale * (x + kMargins), scale * (y + kMargins),
	text,
	-1, scale * (width - kMargins * 2.0) * 4.0,
	scale * 0.25, scale * 0.25, 0.0);

draw_set_alpha(1.0);