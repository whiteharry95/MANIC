// Variables
background_01 = -1;
background_02 = -1;

sound_break_0 = 0;
lighting = 1;

spawn = false;

// Spawn System
scr_spawn_setup("city", 1.8);
global.game_combat_state_time_real = 0;
spawn_pause_update = false;
spawn_rate_real = 1;
spawn_cleared = false;

switch(room){
	case rm_level_9_00:
		if (global.game_level_opening_type == 0){
			spawn_x = 640;
			spawn_y = 704;
		}else{
			spawn_x = 136;
			spawn_y = 140;
		}
		break;
	
	case rm_level_9_01:
		if (global.game_level_opening_type == 0){
			spawn_x = 920;
			spawn_y = 1196;
		}else{
			spawn_x = 278;
			spawn_y = 126;
		}
		break;
	
	case rm_level_9_02:
		if (global.game_level_opening_type == 0){
			spawn_x = 694;
			spawn_y = 640;
		}else{
			spawn_x = 714;
			spawn_y = 202;
		}
		break;
}

if (!audio_is_playing(m_ambience_wind_0)){
	audio_play_sound(m_ambience_wind_0, 3, true);
	audio_sound_gain(m_ambience_wind_0, 0, 0);
}

audio_sound_gain(m_ambience_wind_0, 1 * obj_controller_all.real_ambience_volume, 7000);

// Other
room_music_transition = false;
global.cutscene_current = 2;
sprite_index = noone;
depth = -5;