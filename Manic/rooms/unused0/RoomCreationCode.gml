if (!instance_exists(obj_player)){
    instance_create(540, -3, obj_player);
}

global.player_footstep_default = snd_character_footstep_wood;

if (global.player_companion != -1){
	var comp = instance_create(obj_player.x - 20, obj_player.y - 20, global.companion[global.player_companion]);
	if (global.player_companion_health != -1){
		comp.health_current = global.player_companion_health;
	}
}

while(!instance_exists(obj_controller_mouse)){
    instance_create(mouse_x, mouse_y, obj_controller_mouse);
}

instance_activate_all();