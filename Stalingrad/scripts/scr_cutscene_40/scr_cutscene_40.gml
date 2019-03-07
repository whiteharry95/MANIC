///scr_cutscene_40();
var index = 40, xTo = cutscene_look_x, yTo = cutscene_look_y;
var to = noone;

if (instance_exists(obj_controller_camera)){
	obj_controller_camera.camera_screenshake = false;
	obj_controller_camera.camera_screenshake_amount = 0;
}

if (instance_exists(global.player)){
	var has_look_object = (cutscene_look_object != noone) && (instance_exists(cutscene_look_object));
	
	if (has_look_object){
		xTo = cutscene_look_object.x;
		yTo = cutscene_look_object.y;
	}
	
	global.player.flashlight_move = false;
	global.player.flashlight_direction = point_direction(global.player.x, global.player.y, xTo, yTo);
	
	if (cutscene_look_boss != -1){
		global.boss_current = cutscene_look_boss;
	}
	
	if (global.cutscene_time[index] < cutscene_look_time){
		global.cutscene_time[index] ++;
		if (has_look_object) && (cutscene_look_prop){
			cutscene_look_object.in_cutscene = true;
			cutscene_look_object.cutscene_prop = true;
		}
	}else{
		global.cutscene_time[index] = 0;
		global.cutscene_current = -1;
		global.player.move_xTo = -1;
		global.player.move_yTo = -1;
		if (has_look_object) && (cutscene_look_prop){
			cutscene_look_object.in_cutscene = false;
			cutscene_look_object.cutscene_prop = false;
		}
		cutscene_look_object = noone;
		cutscene_look_boss = -1;
		cutscene_look_prop = false;
	}
	
	global.cutscene_camera_x[index] = xTo;
	global.cutscene_camera_y[index] = yTo;
}else{
	global.cutscene_current = -1;
	global.cutscene_time[index] = 0;
}