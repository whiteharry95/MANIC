if (!instance_exists(obj_player)){
    instance_create(463, 13, obj_player);
}

global.player = obj_player;
global.player_footstep_default = snd_character_footstep_grass;

if (global.game_level_opening_type == 1){
	var train = instance_create(-353, 117, obj_pawn_other_train_1);
	train.component_spawn = true;
	global.player.x = -100;
	global.player.y = -100;
}

if (global.game_level_opening_type == 2){
	global.player.y = room_width + 4;
	obj_controller_camera.x = global.player.x;
	obj_controller_camera.y = global.player.y;
}

if (global.player_companion != -1){
	var comp = instance_create(global.player.x - 20, global.player.y - 20, global.companion[global.player_companion]);
	if (global.player_companion_health != -1){
		comp.health_current = global.player_companion_health;
	}
}

while(!instance_exists(obj_controller_mouse)){
    instance_create(mouse_x, mouse_y, obj_controller_mouse);
}

instance_activate_all();