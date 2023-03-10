/// @description Insert description here
// You can write your code in this editor

var backgroundSprite = sprBackgroundTest;
/*var backgroundScale = max(
	Screen.width / sprite_get_width(backgroundSprite),
	Screen.height / sprite_get_height(backgroundSprite)
	);*/
var backgroundScale = (3840.0 / sprite_get_height(backgroundSprite)) * (Screen.height / 3840.0);

gpu_set_tex_filter(true);
gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_mip_bias(-0.5);

draw_sprite_ext(backgroundSprite, 0, Screen.width / 2, Screen.height / 2,
				backgroundScale, backgroundScale,
				0.0,
				c_white,
				1.0);