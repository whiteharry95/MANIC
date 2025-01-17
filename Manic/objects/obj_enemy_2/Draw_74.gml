if (!obj_controller_all.show_ui){
	return;
}

// Health
var hp = health_current;
var scale = 0.9;
health_scale = approach(health_scale, 1, 40);

scr_pawn_health_alpha();

if (health_flash > 0.01){
	health_flash *= 0.85;
}else{
	health_flash = 0;
}

draw_sprite_ext(spr_ui_hearts_1, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha);

gpu_set_fog(true, c_white, 0, 0);
draw_sprite_ext(spr_ui_hearts_1, clamp(hp, 0, health_max), (x - camera_get_view_x(view_camera[0])) * gui_scale_x, ((y - camera_get_view_y(view_camera[0])) + (33 * scale)) * gui_scale_y, health_scale * scale, health_scale * scale, 0, c_white, health_alpha * (health_flash * 0.5));
gpu_set_fog(false, c_white, 0, 0);