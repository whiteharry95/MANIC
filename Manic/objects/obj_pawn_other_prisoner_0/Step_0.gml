if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	return;
}

if (talk) && (obj_controller_ui.dialogue_time <= 0){
	with(object_index){
		talking = false;
	}
		
	obj_controller_ui.dialogue = random(100) < 30 ? "Thank you..." : "...";
	obj_controller_ui.dialogue_voice = snd_character_dialogue_generic_in;
	obj_controller_ui.dialogue_time = 60 * 2;
	obj_controller_ui.dialogue_pause = false;
	obj_controller_ui.dialogue_length = string_length(obj_controller_ui.dialogue);
	obj_controller_ui.dialogue_char_count = 0;
	obj_controller_ui.dialogue_x = x;
	obj_controller_ui.dialogue_y = y - 24;
	obj_controller_ui.dialogue_voice_opened = false;
	obj_controller_ui.dialogue_voice_closed = true;
	
	with(obj_sign_0){
		talking = false;
	}
	
	with(obj_sign_wall_0){
		talking = false;
	}
	
	talk = false;
	talking = true;
}

if (talking){
	if (global.cutscene_current == -1){
		obj_controller_ui.dialogue_x = x;
		obj_controller_ui.dialogue_y = y - 24;
		
		if (obj_controller_ui.dialogue_time <= 0){
			talking = false;
		}
	}else{
		obj_controller_ui.dialogue_time = 0;
		talking = false;
	}
}

if (domove){
	var dirblock = instance_place(x, y, obj_block_direction);
	if (dirblock != noone){
		dir_to = dirblock.image_angle;
	}
	
	var dirdiff = angle_difference(dir, dir_to);
	dir += min(abs(dirdiff), 6) * -sign(dirdiff);
	
	if (dir_to < 90) || (dir_to > 270){
		facing = 1;
	}else{
		facing = -1;
	}
	
	image_speed = 0.25 * spd;
	sprite_index = spr_prisoner_walk_0;
	x += lengthdir_x(spd, dir);
	y += lengthdir_y(spd, dir);
}else{
	image_speed = 0.05;
	sprite_index = spr_prisoner_idle_0;
}

image_xscale = facing * scale;