///scr_cutscene_51();
var index = 51;
var x_to = 0, y_to = 0;

obj_controller_camera.camera_screenshake = false;
obj_controller_camera.camera_screenshake_amount = 0;

if (instance_exists(obj_player)){
	x_to = cutscene_trainopening_inst.x;
	y_to = cutscene_trainopening_inst.y + 12;
	
	global.cutscene_camera_x[index] = x_to;
	global.cutscene_camera_y[index] = y_to;
	
	obj_player.flashlight_direction = 90;
	
	if (point_distance(obj_player.x, obj_player.y, x_to, y_to) < 40){
		obj_player.move_ext_spd = 0;
		obj_player.sprite_index = spr_player_idle_1;
		obj_player.image_speed = 0;
		obj_player.image_index = 0;
		
		if (global.cutscene_time[index] < 40){
			global.cutscene_time[index] ++;
		}else{
			if (!instance_exists(cutscene_trainopening_light)){
				cutscene_trainopening_light = instance_create(x_to, y_to, obj_player_light);
				cutscene_trainopening_light.skipdraw = false;
				
				scr_modify_player_surrounding_light(cutscene_trainopening_light, x_to, y_to);
			}
			
			instance_destroy(obj_player);
			
			global.player_position_x = -100;
			global.player_position_y = -100;
		}
	}else{
		obj_player.move_x_to = x_to;
		obj_player.move_y_to = y_to;
		obj_player.move_ext_spd = obj_player.spd_max;
	}
}else{
	x_to = cutscene_trainopening_inst.x;
	y_to = cutscene_trainopening_inst.y + 12;
	
	if (instance_exists(cutscene_trainopening_light)){
		cutscene_trainopening_light.x = x_to;
		cutscene_trainopening_light.y = y_to;
	}else{
		cutscene_trainopening_light = instance_create(x_to, y_to, obj_player_light);
		cutscene_trainopening_light.skipdraw = false;
		
		scr_modify_player_surrounding_light(cutscene_trainopening_light, x_to, y_to);
	}
	
	if (global.cutscene_time[index] < 100){
		global.cutscene_time[index] ++;
	}else{
		obj_controller_ui.area_next_fade = true;
		obj_pawn_other_train_1.leave = true;
		
		if (cutscene_trainstart_type == -1){
			global.game_level_opening_type = 1;
		}else{
			global.game_level_opening_type = cutscene_trainstart_type;
		}
		
		var level = scr_level_get_index(room);
		
		if (global.game_is_playthrough) || (level == cutscene_traingoto){
			if (cutscene_trainroom == -1){
				obj_controller_ui.area_next_room = global.level_room[cutscene_traingoto];
			}else{
				obj_controller_ui.area_next_room = cutscene_trainroom;
			}
			
			global.level_current = cutscene_traingoto;
		}else{
			obj_controller_ui.area_next_room = rm_title_0;
		}
	}
}