if (global.game_pause){
	return;
}

var player = obj_player;
if (instance_exists(player)){
	if (point_distance(x, y, player.x, player.y) < 30){
		interact = true;
	}else{
		interact = false;
	}
}else{
	interact = false;
}

if (interact) && (obj_controller_ui.dialogue_time <= 0) && (global.cutscene_current == -1){
	sprite_index = spr_sign_wall_0_interact;
	scr_ui_control_indicate("Interact");
	
	if (interact_break <= 0){
		if (scr_input_is_pressed(InputBinding.Interact) && global.player_stamina_active){
			with(obj_sign_0){
				talking = false;
			}
			
			with(obj_sign_wall_0){
				talking = false;
			}
			
			interact_break = 15;
			talking = true;
			
			scr_player_stamina_drain(4);
		
			obj_controller_ui.dialogue = text;
			obj_controller_ui.dialogue_voice = snd_character_dialogue_generic_in;
			obj_controller_ui.dialogue_time = 60 * 4;
			obj_controller_ui.dialogue_pause = false;
			obj_controller_ui.dialogue_length = string_length(obj_controller_ui.dialogue);
			obj_controller_ui.dialogue_char_count = 0;
			obj_controller_ui.dialogue_x = x;
			obj_controller_ui.dialogue_y = y - 24;
			obj_controller_ui.dialogue_voice_opened = false;
			obj_controller_ui.dialogue_voice_closed = true;
		}
	}else{
		interact_break --;
	}
}else{
	sprite_index = spr_sign_wall_0;
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