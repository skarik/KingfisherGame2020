/// @description Insert description here
// You can write your code in this editor

var charaSprite = sprCharaYuuto;
var charaScale = (2048.0 / sprite_get_height(charaSprite)) * (Screen.height * 0.8 / 2048.0);

gpu_set_tex_filter(true);
gpu_set_tex_mip_filter(tf_anisotropic);
gpu_set_tex_mip_bias(-0.5);

draw_sprite_ext(charaSprite, 0, Screen.width / 2, Screen.height,
				charaScale, charaScale,
				0.0,
				c_white,
				1.0);