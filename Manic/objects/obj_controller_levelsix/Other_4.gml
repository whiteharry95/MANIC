if (global.pers_runthrough){
	instance_deactivate_object(object_index);
	return;
}

// Variables
background_01 = -1;
background_02 = -1;

sound_break_0 = 0;
lighting = 1;

spawn = false;

if (!instance_exists(obj_player)){
	instance_create(0, 0, obj_player);
}

global.player_footstep_default = snd_character_footstep_grass;

// Spawn System
scr_spawn_setup("main");
spawn_pause_update = false;
spawn_rate_real = 1;
spawn_cleared = false;

switch(room){
	case rm_level_6_pre_00:
		obj_player.x = 702;
		obj_player.y = 2106;
		
		if (global.game_level_opening_type == 0){
			spawn_x = 702;
			spawn_y = obj_player.y + 6 + walkindist;
		}else{
			obj_player.x = 526;
			obj_player.y = -6;
			
			spawn_x = 526;
			spawn_y = walkindist;
		}
		break;
	
	case rm_level_6_00:
		obj_player.x = 656;
		obj_player.y = room_height + 6;
		
		spawn_x = 656;
		spawn_y = room_height - walkindist;
		
		if (global.worldtrain_room == room) && (global.game_level_opening_type != 1) && (global.game_boss_trainhorde_killed){
			var trainidle = instance_create(832, 224, obj_pawn_other_train_1);
			trainidle.component_spawn = true;
			trainidle.spd = 0;
		}
		break;

	case rm_level_6_01:
		obj_player.x = -100;
		obj_player.y = -100;
		
		if (global.game_level_opening_type == 0){
			spawn_x = -1;
			spawn_y = -1;
			
			var train = instance_create(-170, 224, obj_pawn_other_train_1);
			train.component_spawn = true;
			train.sound_stop_played = false;
			
			obj_player.x = -100;
			obj_player.y = -100;
		}else{
			obj_player.x = room_width + 6;
			obj_player.y = 232;
			
			spawn_x = room_width - walkindist;
			spawn_y = 232;
			
			if (global.worldtrain_room == room){
				var trainidle = instance_create(816, 224, obj_pawn_other_train_1);
				trainidle.component_spawn = true;
				trainidle.spd = 0;
			}
		}
		break;
	
	case rm_level_6_02:
		obj_player.x = -6;
		obj_player.y = 232;
		
		if (global.game_level_opening_type == 0){
			spawn_x = walkindist;
			spawn_y = 232;
		}else{
			obj_player.x = room_width + 6;
			obj_player.y = 232;
			
			spawn_x = room_width - walkindist;
			spawn_y = 232;
		}
		break;
}

if (global.game_level_opening_type == 1) && (room == rm_level_6_00){
	global.cutscene_current = 47;
	
	var train = instance_create_layer(-247, 224, "Trains", obj_pawn_other_train_1);
	train.component_spawn = true;
	train.sound_stop_played = false;
	
	obj_player.x = -100;
	obj_player.y = -100;
}else{
	if (global.game_level_opening_type == 0) && (room == rm_level_6_01){
		global.cutscene_current = 47;
	}else{
		global.cutscene_current = 2;
	}
}

// Camera
if (instance_exists(obj_controller_camera)){
	obj_controller_camera.x = obj_player.x;
	obj_controller_camera.y = obj_player.y;
}

// Other
companions_spawned = false;
room_music_transition = false;

sprite_index = noone;
depth = -5;

if (room == rm_level_6_01) || (room == rm_level_6_02){
	global.game_objective_complete = true;
}

train_time = 0;
train_timemax = 20 * 60;

trainboss_trainhead = noone;
trainboss_leader = noone;
trainboss_timemax = 60 * 78;
trainboss_spawned = false;

healer_can_spawn = global.game_firsthealer_killed;