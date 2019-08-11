
if (!instance_exists(obj_player)){
    instance_create(518, 30, obj_player);
}

global.player_footstep_default = snd_character_footstep_grass;

if (global.game_level_opening_type == 1){
	obj_player.y = room_height + 6;
}

scr_room_spawn_companion();

while(!instance_exists(obj_controller_mouse)){
    instance_create(mouse_x, mouse_y, obj_controller_mouse);
}