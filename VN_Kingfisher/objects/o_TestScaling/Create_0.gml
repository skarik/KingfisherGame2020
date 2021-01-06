width = 0;//window_get_width();
height = 0;//window_get_height();
fullscreen = false;
bResizeRequested = true;

referenceWidth = window_get_width();
referenceHeight = window_get_height();
referenceFullscreen = window_get_fullscreen();

effectiveXscale = 1.0;
effectiveYscale = 1.0;

/*view_visible[0] = true;
view_enabled = true;
view_wport[0] = referenceWidth;
view_hport[0] = referenceHeight;*/

application_surface_draw_enable(false);