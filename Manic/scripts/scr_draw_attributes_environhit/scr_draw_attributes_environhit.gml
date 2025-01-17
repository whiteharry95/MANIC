if (flash > 0){
	gpu_set_fog(true, make_colour_rgb(227, 227, 227), 0, 0);
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, flash * 0.9);
	
	if (object_index == obj_barrel_2) || (object_index == obj_barrel_3){
		if (explode){
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, ((scale / 1.2) + 0.4) * 0.7);
		}
	}
	
	if (object_index == obj_prisonbar_3){
		var glow = wave(0.05, 0.15, 2.25, 0, false);
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, glow);
	}
	
	gpu_set_fog(false, c_black, 0, 0);
}