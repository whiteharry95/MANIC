var wv = wave(0.15, 0.25, 2, 0);

shader_set(sh_pawntint);
var shader_alpha = shader_get_uniform(sh_pawntint, "_alpha");
var shader_red = shader_get_uniform(sh_pawntint, "_red");
var shader_green = shader_get_uniform(sh_pawntint, "_green");
var shader_blue = shader_get_uniform(sh_pawntint, "_blue");
var r = 0, g = 0, b = 0, a = 0;

if (global.player_healthCurrent <= 2){
	if (!global.game_pause){
	    if (random(3) < 1){
	        part_particles_create(global.ps_front, x + random_range(-6, 6), y + random_range(-14, 14), global.pt_blood_2, 1);
	    }
	}
    
    a = wv;
	r = color_get_red(make_color_rgb(76, 53, 53));
	g = color_get_green(make_color_rgb(76, 53, 53));
	b = color_get_blue(make_color_rgb(76, 53, 53));
}

if (burn){
	a = wv;
	r = 255;
	g = 255;
	b = 255;
	
	if (!global.game_pause){
		if (random(3) < 1){
			part_particles_create(global.ps_front, x + random_range(-6, 6), y + random_range(-18, 18), global.pt_fire_0, 1);
		}
		
		if (random(5) < 1){
			part_particles_create(global.ps_front, x + random_range(-6, 6), y + 3 + random_range(-18, 18), global.pt_fire_2, 1);
		}
	}
}

if (poison){
	a = wv;
	r = 255;
	g = 255;
	b = 255;
	
	draw_self();
	
	if (!global.game_pause){
		if (random(2.5) < 1){
			part_particles_create(global.ps_front, px + random_range(-wradius, wradius), py + random_range(-hradius, hradius), global.pt_poison_0, 1);
		}

		if (random(3.5) < 1){
			part_particles_create(global.ps_front, px + random_range(-wradius, wradius), py + random_range(-hradius, hradius), global.pt_poison_1, 1);
		}
	}
}

if (i_blendTime > 0){
	var alpha = 1 - (1 / i_blendTime);
	a = alpha;
	r = color_get_red(make_color_rgb(76, 53, 53));
	g = color_get_green(make_color_rgb(76, 53, 53));
	b = color_get_blue(make_color_rgb(76, 53, 53));
}

if (whiteflash_alpha > 0){
	a = whiteflash_alpha;
	r = 255;
	g = 255;
	b = 255;
}

if (r > 0) || (g > 0) || (b > 0) || (a > 0){
	shader_set_uniform_f(shader_alpha, a);
	shader_set_uniform_f(shader_red, r);
	shader_set_uniform_f(shader_green, g);
	shader_set_uniform_f(shader_blue, b);
	draw_self();
}

shader_reset();