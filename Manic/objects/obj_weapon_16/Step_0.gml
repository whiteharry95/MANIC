if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	image_index = 0;
	return;
}

var mdir = point_direction(x, y, mouse_x, mouse_y);
var xpos = x + lengthdir_x(35, mdir);
var ypos = y + lengthdir_y(35, mdir);

if (mouse_check_button_pressed(obj_controller_all.key_attack)) && (global.player_stamina_active) && (!global.game_pause){
    if (attack_can){
		scr_camera_to_player();
        scr_effect_screenshake(3);
		
        scr_mouse_control(MouseType.SmallCircle, 2.5, 25);
        scr_sound_play(snd_weapon_swing_0, false, 0.8, 1.2);
        scr_player_knockback_initiate(0.8, mdir);
        scr_player_stamina_drain(15);
        angle_offset = -angle_offset;
		
	    s = instance_create(xpos, ypos, obj_proj_1);
	    s.image_angle = mdir;
	    s.depth = depth + 1;
		scr_weapon_melee_detect(false, x, y, s.image_angle, attack_damage, attack_strength, 35, obj_proj_2, obj_player.x, obj_player.y);
        
        attack_time = 28;
        attack_can = false;
    }
}

if (global.player_stamina_active){
    if (mouse_check_button_pressed(obj_controller_all.key_throw)){
		
		if (!collision_line(x, y, x + lengthdir_x(10, mdir), y + lengthdir_y(10, mdir), obj_p_solid, false, true)){
		    scr_effect_screenshake(1);
			scr_player_stamina_drain(15);
			scr_sound_play(snd_weapon_swing_0, false, 0.8, 1.2);
		
		    throw = instance_create(x, y, obj_weapondrop);
		    throw.index = index;
		    throw.spd = 9;
		    throw.damage = throw_damage;
		    throw.dir = mdir;
		    throw.image_angle = throw.dir;
		    throw.ammo = global.weapon_slotammo[global.weapon_slotcurrent];

		    instance_destroy();
		    global.weapon_slot[global.weapon_slotcurrent] = -1;
		}
    }
}

if (!attack_can){
	attack_time = max(attack_time, 0.1);
}

if (attack_time > 0){
    attack_time--;
	
	if (attack_time < 1){
		attack_can = true;
		attack_time = 0;
	}
}