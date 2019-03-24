///scr_cutscene_37();
var index = 37, xTo = 0, yTo = 0;
var to = noone;
var eobj = noone;
var levelobject = scr_get_level_object();

obj_controller_camera.camera_screenshake = false;
obj_controller_camera.camera_screenshake_amount = 0;

if (instance_exists(obj_player)){
	var maxtime = 45;
	eobj = levelobject.trainboss_leader;
	
	/*if (eobj == noone){
		eobj = levelobject.trainboss_trainhead;
		maxtime = 100;
		xTo += 20;
	}*/
	
	if (instance_exists(eobj)){
		xTo = xTo + eobj.x;
		yTo = yTo + eobj.y;
	
		obj_player.flashlight_move = false;
		obj_player.flashlight_direction = point_direction(obj_player.x, obj_player.y, xTo, yTo);
		
		if (global.cutscene_time[index] < maxtime){
			global.cutscene_time[index] ++;
		}else{
			global.cutscene_time[index] = 0;
			global.cutscene_current = -1;
			obj_player.move_xTo = -1;
			obj_player.move_yTo = -1;
		}
	}
	
	global.cutscene_camera_x[index] = xTo;
	global.cutscene_camera_y[index] = yTo;
}else{
	global.cutscene_current = -1;
	global.cutscene_time[index] = 0;
}