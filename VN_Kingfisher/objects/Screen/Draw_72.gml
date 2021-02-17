/// @description Set up screen surface

var real_width = window_get_width();
var real_height = window_get_height();
var real_fullscreen = window_get_fullscreen();

if (width != real_width || height != real_height
	|| fullscreen != real_fullscreen)
{
	width = real_width;
	height = real_height;
	fullscreen = real_fullscreen;
	bResizeRequested = true;
}

if (bResizeRequested)
{
	bResizeRequested = true;
	
	surface_resize(application_surface, width, height);
	
	effectiveXscale = referenceWidth / width;
	effectiveYscale = referenceHeight / height;
	
	var default_camera = camera_get_default();
	camera_set_view_size(default_camera, width, height);
	camera_apply(default_camera);
}