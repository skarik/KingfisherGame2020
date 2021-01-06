
// draw the surface
if (surface_exists(application_surface))
{
	//draw_surface_ext(application_surface, 0, 0, effectiveXscale, effectiveYscale, 0, c_white, 1);
	draw_surface_ext(application_surface, 0, 0, 1.0, 1.0, 0, c_white, 1);
	
	draw_set_halign(fa_right);
	draw_set_valign(fa_bottom);
	draw_set_color(c_white);
	draw_text(width - 10, height - 10, string(surface_get_width(application_surface)) + " x " + string(surface_get_height(application_surface)));

}
else
{
	draw_set_color(c_red);
	draw_rectangle(0, 0, 100000, 100000, false);
}