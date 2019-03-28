if (global.game_pause){
	image_speed = 0;
	exit;
}

alpha = approach(alpha, alphaTo, 40);
image_alpha = alpha;

// Attacking
if (instance_exists(owner)){
    alphaTo = 1;
    
    if (attack_time > 0){
        attack_time--;
    }

    if (attack) && (attack_time <= 0){
        scr_effect_screenshake(1);
        scr_sound_play_distance(snd_weapon_swing_0, false, 450);
        
	    var xpos = x + lengthdir_x(37 * owner.scale, dir);
		var ypos = y + lengthdir_y(37 * owner.scale, dir);
		var isEnemy = true;
		
	    proj = instance_create(xpos, ypos, obj_proj_2);
	    proj.image_angle = dir;
	    proj.depth = depth + 1;
		
		if (owner.pawn == PawnType.Companion){
			isEnemy = false;
		}
	    
		scr_weapon_melee_detect(isEnemy, x, y, dir, scr_pawn_weapon_damage(0), 0.05, 37 + 10, obj_proj_2);
        
        owner.knockback_speed = -1;
        owner.knockback_direction = dir;
		
        attack = false;
        attack_time = attack_time_max;
		
        angle_offset = -angle_offset;
    }
}
