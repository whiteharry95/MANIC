if (instance_exists(owner)){
	if (scr_pawn_weapon_endstepcan()){
	    x = owner.arm.x + lengthdir_x(14 * owner.scale, dir);
	    y = owner.arm.y + lengthdir_y(14 * owner.scale, dir);
		
		image_angle = dir;
		
		if (image_angle > 270 || image_angle <= 90){
			image_yscale = 1;
		}else{
			image_yscale = -1;
		}
		
	    if (angle_offset > 0){
	        angle_offset -= 0.2;
	    }else{
	        angle_offset = 0;
	    }
	}
}