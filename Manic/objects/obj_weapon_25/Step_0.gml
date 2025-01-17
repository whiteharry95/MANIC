if (!instance_exists(obj_player)){
	instance_destroy();
	return;
}

if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	image_index = 0;
	return;
}

var mdir = point_direction(global.player_position_x, global.player_position_y, scr_input_get_mouse_x(), scr_input_get_mouse_y());
var ammo = global.weapon_slotammo[global.weapon_slotcurrent];

if ((scr_input_is_pressed(InputBinding.Attack)) || (shoot_continue_time > 0)) && (!global.game_pause) && (global.player_stamina_active){
    if ((shoot_can) && (ammo > 0)) || (shoot_continue_time > 0){
        var xpos = x + lengthdir_x(21, mdir) + lengthdir_x(3, up(mdir));
	    var ypos = y + lengthdir_y(21, mdir) + lengthdir_y(3, up(mdir));
		
		if (scr_input_is_pressed(InputBinding.Attack) && shoot_continue_time <= 0){
			shoot_continue_time = 6;
			shoot_bounceback = -13;
			angle_offset = 20;
			
			scr_weapon_ammo_use(1);
			scr_player_flash(8);
			scr_player_flashlight_flash(1.225);
			scr_camera_to_player();
			scr_sound_play(snd_weapon_shotgun_0, false, 0.8, 1.2);

	        part_type_direction(global.pt_smoke_4, mdir - 6, mdir + 6, 0, 0);
			for(var l = 0; l < 24; l += 4){
				part_particles_create(global.ps_front, xpos + lengthdir_x(-10 + l, mdir) + random_range(-3, 3), ypos + lengthdir_y(-10 + l, mdir) + random_range(-3, 3), global.pt_smoke_4, 1);
			}
			
			part_type_direction(global.pt_shell_0, (mdir - 180) - 15, (mdir - 180) + 15, 0, 0);
			part_particles_create(global.ps_bottom, x + lengthdir_x(3, mdir) + random_range(-3, 3), y + 4 + lengthdir_y(3, mdir) + random_range(-3, 3), global.pt_shell_0, 4);
		}
		
		scr_player_knockback_initiate(0.5, mdir);
        scr_effect_screenshake(2);
        scr_mouse_control(MouseType.LargeCircle, 3, 12);
		
        image_speed = 1;
        
		repeat(3){
			var shoot = instance_create(xpos, ypos, obj_proj_0);
			shoot.damage = shoot_damage;
			shoot.damage_change = -0.2;
			shoot.strength = shoot_strength;
			shoot.dir = mdir + random_range(-shoot_range, shoot_range);
			shoot.spd = shoot_speed;
			shoot.image_angle = shoot.dir;
		}
        
        shoot_can = false;
        shoot_time = 35;
    }else{
		scr_sound_play(snd_weapon_click_0, false, 0.8, 1);
	}
}

// Throwing Weapon
var mdir = point_direction(global.player_position_x, global.player_position_y, scr_input_get_mouse_x(), scr_input_get_mouse_y());

if (global.player_stamina_active){
    if (scr_input_is_pressed(InputBinding.Throw)){
		
		if (!collision_line(x, y, x + lengthdir_x(16, mdir), y + lengthdir_y(16, mdir), obj_p_solid, false, true)){
		    scr_effect_screenshake(1);
			scr_player_stamina_drain(20);
			scr_sound_play(snd_weapon_swing_0, false, 0.8, 1.2);
		
		    throw = instance_create(x, y, obj_weapondrop);
		    throw.index = index;
		    throw.spd = 9;
		    throw.damage = throw_damage;
		    throw.dir = mdir;
		    throw.angle = image_angle;
		    throw.ammo = global.weapon_slotammo[global.weapon_slotcurrent];
			throw.dataset = true;
			
		    instance_destroy();
		    global.weapon_slot[global.weapon_slotcurrent] = -1;
		}
    }
}

// Timer
if (shoot_continue_time > 0){
	shoot_continue_time --;
}

if (shoot_time > 0){
    shoot_time --;
	
	if (within(shoot_time, 26, 28)){
		if (!audio_is_playing(snd_weapon_reload_0)){
			scr_sound_play(snd_weapon_reload_0, false, 0.9, 1.2);
		}
	}
}else{
    shoot_can = true;
}