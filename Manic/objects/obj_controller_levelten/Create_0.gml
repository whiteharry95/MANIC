// Variables
background_01 = -1;
background_02 = -1;

sound_break_0 = 0;
lighting = 1;

// Spawn
spawn_pause_update = false;

switch(room){
	case rm_level_10_00:
		if (global.game_level_opening_type == 0){
			spawn_x = 502;
			spawn_y = 1528;
		}else{
			spawn_x = 502;
			spawn_y = 188;
		}
		break;
	
	case rm_level_10_01:
		spawn_x = 502;
		spawn_y = 932;
		break;
}

// Other
room_music_transition = false;

boss_music_active = false;

boss_music_state = "opening";
boss_music_state_started = false;

boss_music_opening_instance = noone;
boss_music_stage1_layer1_instance = noone;
boss_music_stage1_layer2_instance = noone;
boss_music_stage2_layer1_instance = noone;
boss_music_stage2_layer2_instance = noone;
boss_music_outro_instance = noone;

global.cutscene_current = 2;
global.game_objective_current = 0;

sprite_index = noone;
depth = -5;