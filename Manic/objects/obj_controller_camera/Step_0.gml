var x_to, y_to;
var xx, yy;
var mdist = distance_to_point(mouse_x, mouse_y);

if (global.weapon_slot_standalone == -1){
	if (global.weapon_slot[global.weapon_slotcurrent]!= -1){
	    camera_radius = global.weapon_camerarange[global.weapon_slot[global.weapon_slotcurrent]];
	}else{
	    camera_radius = -1;
	}
}

// Camera
if (instance_exists(obj_player)) && (!global.game_pause){
	if (autocontrol){
		camera_speed = 0.085;
	    if (global.cutscene_current == -1){
	        if (camera_radius != -1) && (!camera_move_to_player){
	            xx = obj_player.x + lengthdir_x(min(camera_radius * 1.25, mdist), dir);
	            yy = obj_player.y + lengthdir_y(min(camera_radius * 1.25, mdist), dir);
	        }else{
	            xx = obj_player.x;
	            yy = obj_player.y;
	        }
	    }else{
	        xx = global.cutscene_camera_x[global.cutscene_current];
	        yy = global.cutscene_camera_y[global.cutscene_current];
	    }
	
		dir = point_direction(x, y, mouse_x, mouse_y);
		x_to = clamp(xx, 0, room_width);
		y_to = clamp(yy, 0, room_height);
	
		var xspd = (x_to - x) * camera_speed;
		var yspd = (y_to - y) * camera_speed;
	
		x += xspd;
		y += yspd;
	}
	
	camera_set_view_pos(view_camera[0],
	-(camera_get_view_width(view_camera[0]) / 2) + x,
	-(camera_get_view_height(view_camera[0]) / 2) + y);
	
	camera_set_view_pos(view_camera[0],
	clamp(camera_get_view_x(view_camera[0]), 0, room_width - camera_get_view_width(view_camera[0])),
	clamp(camera_get_view_y(view_camera[0]), 0, room_height - camera_get_view_height(view_camera[0])));
	
	if (camera_screenshake){
	    camera_set_view_pos(view_camera[0],
		camera_get_view_x(view_camera[0]) + wave(-camera_screenshake_amount, camera_screenshake_amount, 0.2, 0, true), 
		camera_get_view_y(view_camera[0]) + wave(-camera_screenshake_amount, camera_screenshake_amount, 0.2, 0, true)
		);
		
	    if (camera_screenshake_amount > 0.01){
	        camera_screenshake_amount *= 0.9;
	    }else{
	        camera_screenshake_amount = 0;
	        camera_screenshake = false;
	        return;
	    }
	}
	
	if (camera_move_to_player_time > 0){
		camera_move_to_player_time--;
	}else{
		camera_move_to_player = false;
	}
}else{
    camera_speed = 0;
	camera_screenshake = false;
	camera_screenshake_amount = 0;
	camera_radius = -1;
}