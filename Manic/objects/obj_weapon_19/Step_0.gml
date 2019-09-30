if (!instance_exists(obj_player)){
	instance_destroy();
	return;
}

if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	image_index = 0;
	return;
}

var mdir = point_direction(x, y, scr_input_get_mouse_x(), scr_input_get_mouse_y());

if (scr_input_is_pressed(InputBinding.Attack)) && (!global.game_pause){
	
    if (shoot_can) && (global.weapon_slotammo[global.weapon_slotcurrent] > 0){
        var xpos = x + lengthdir_x(13, mdir) + lengthdir_x(2, up(mdir));
        var ypos = y + lengthdir_y(13, mdir) + lengthdir_y(2, up(mdir));
		
		var dir = point_direction(xpos, ypos, scr_input_get_mouse_x(), scr_input_get_mouse_y());
		
		scr_player_knockback_initiate(0.5, dir);
		scr_player_flash(3);
		scr_player_flashlight_flash(1.17);
		
		scr_camera_to_player(1);
        scr_effect_screenshake(3);
        scr_weapon_ammo_use(1);
        scr_sound_play(snd_weapon_flare_0, false, 0.8, 1.2);
		image_speed = 1;
		
		part_type_direction(global.pt_smoke_4, dir - 6, dir + 6, 0, 0);
		for(var l = 0; l < 20; l += 5){
			part_particles_create(global.ps_front, xpos + lengthdir_x(-10 + l, dir) + random_range(-3, 3), ypos + lengthdir_y(-10 + l, dir) + random_range(-3, 3), global.pt_smoke_4, 1);
		}
		
		part_type_direction(global.pt_shell_0, (dir - 180) - 15, (dir - 180) + 15, 0, 0);
        part_particles_create(global.ps_bottom, x + lengthdir_x(3, dir) + random_range(-3, 3), y + 4 + lengthdir_y(3, dir) + random_range(-3, 3), global.pt_shell_0, choose(1, 2));
		scr_mouse_control(MouseType.SmallCrosshair, 2, 20);
		
	    var shoot = instance_create(xpos, ypos, obj_proj_4);
	    shoot.dir = dir + random_range(-shoot_range, shoot_range);
		shoot.image_angle = shoot.dir;
		shoot.spd = shoot_speed;
		shoot.damage = shoot_damage;
		shoot.strength = shoot_strength;
        
        shoot_can = false;
        shoot_time = 20;
        shoot_bounceback = -5;
        angle_offset = 15;
        flash_draw = true;
		flash_time = 0;
    }else if (shoot_can){
		scr_sound_play(snd_weapon_click_0, false, 0.8, 1);
	}
}

// Throwing Weapon
var mdir = point_direction(x, y, scr_input_get_mouse_x(), scr_input_get_mouse_y());

if (global.player_stamina_active){
    if (scr_input_is_pressed(InputBinding.Throw)){
		if (!collision_line(x, y, x + lengthdir_x(10, mdir), y + lengthdir_y(10, mdir), obj_p_solid, false, true)){
		    scr_effect_screenshake(1);
			scr_player_stamina_drain(20);
			scr_sound_play(snd_weapon_swing_0, false, 0.8, 1.2);
		
		    throw = instance_create(x, y, obj_weapondrop);
		    throw.index = index;
		    throw.spd = 9;
		    throw.damage = throw_damage;
		    throw.dir = mdir;
		    throw.image_angle = throw.dir;
		    throw.ammo = global.weapon_slotammo[global.weapon_slotcurrent];
			throw.dataset = true;

		    instance_destroy();
		    global.weapon_slot[global.weapon_slotcurrent] = -1;
		}
    }
}

// Time
if (shoot_time > 0){
    shoot_time--;
}else{
    shoot_can = true;
}

