// Health
var hp = health_current;
var scale = 0.9;
health_scale = approach(health_scale, 1, 40);

if (hp < health_max){
	if (health_alpha < 1){
		health_alpha += 0.02;
	}
	
	if (instance_exists(obj_player)){
		if (distance_to_object(obj_player) > 260){
			if (health_alpha > 0.4){
				health_alpha -= 0.1;
			}else if (health_alpha < 0.4){
				health_alpha += 0.1;
			}
		}
	}else{
		if (health_alpha > 0){
			health_alpha -= 0.1;
		}
	}
}else{
	if (health_alpha > 0){
		health_alpha -= 0.1;
	}
}

if (health_flash > 0.01){
	health_flash *= 0.85;
}else{
	health_flash = 0;
}

if (type != Enemy0_Type.Mother) && (type != Enemy0_Type.Sniper) && (type != Enemy0_Type.TrainBoss) && (type != Enemy0_Type.Healer){
	draw_sprite_ext(spr_ui_hearts_0, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha * 0.7);
	
	gpu_set_fog(true, c_white, 0, 0);
	draw_sprite_ext(spr_ui_hearts_0, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha * 0.7 * (health_flash * 0.5));
	gpu_set_fog(false, c_white, 0, 0);
}else if (type == Enemy0_Type.Healer){
	draw_sprite_ext(spr_ui_hearts_1, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha * 0.7);
	
	gpu_set_fog(true, c_white, 0, 0);
	draw_sprite_ext(spr_ui_hearts_1, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha * 0.7 * (health_flash * 0.5));
	gpu_set_fog(false, c_white, 0, 0);
}else if (type != Enemy0_Type.TrainBoss){
	var width = 56;
	var height = 6;
	var xx = x;
	var yy = y + 36;
	
	var x1 = ((xx - camera_get_view_x(view_camera[0])) * gui_scale_x) - (width / 2);
	var y1 = ((yy - camera_get_view_y(view_camera[0])) * gui_scale_y) - (height / 2);
	var x2 = ((xx - camera_get_view_x(view_camera[0])) * gui_scale_x) + (width / 2);
	var y2 = ((yy - camera_get_view_y(view_camera[0])) * gui_scale_y) + (height / 2);
	
	draw_set_alpha(health_alpha * 0.7);
	draw_healthbar(x1, y1, x2, y2, (hp / health_max) * 100, c_dkgray, c_ltgray, c_ltgray, 0, true, false);
	draw_set_alpha(health_alpha * 0.7 * (health_flash * 0.5));
	draw_healthbar(x1, y1, x2, y2, 100, c_dkgray, c_ltgray, c_ltgray, 0, true, false);
	draw_set_alpha(1);
}