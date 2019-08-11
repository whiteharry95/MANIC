if (!instance_exists(obj_player)) || (instance_number(object_index) > 1){
    instance_destroy();
}else{
    if (obj_player.image_xscale == 1){
        image_yscale = 1;
    }else{
        image_yscale = -1;
    }
}

if (instance_exists(obj_player)){
    
    // Position
	if (!global.game_pause){
	    var mdir = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y);
    
	    if (instance_exists(obj_player_arm)){
	        x = obj_player_arm.x + lengthdir_x(7 + shoot_bounceback, image_angle);
	        y = obj_player_arm.y + lengthdir_y(7 + shoot_bounceback, image_angle);
			image_alpha = obj_player_arm.image_alpha;
		}
    
	    if (angle_offset > 0){
	        angle_offset --;
	    }else if (angle_offset < 0){
	        angle_offset ++;
	    }
		
		if (start_offset > 0){
			start_offset = approach(start_offset, 0, 40);
		}
    
	    shoot_bounceback = approach(shoot_bounceback, 0, 20);
    
	    // Direction
	    if (image_yscale == 1){
	        image_angle = mdir + angle_offset + start_offset;
	    }else{
	        image_angle = mdir - angle_offset - start_offset;
	    }
        
	    if (mouse_x > x){
	        image_yscale = 1;
	    }else{
	        image_yscale = -1;
	    }
	}
}

