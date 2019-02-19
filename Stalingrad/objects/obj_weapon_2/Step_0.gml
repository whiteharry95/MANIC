if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	image_index = 0;
	exit;
}

var mdir = point_direction(x, y, mouse_x, mouse_y);

if (mouse_check_button_pressed(mb_left)) && (global.game_pause == false){
    if (shoot_can ) && (global.weapon_slotammo[global.weapon_slotcurrent] > 0){
        scr_player_knockback_initiate(0.5, mdir);
		scr_player_flash(4);
		scr_ui_alpha_reset();
		scr_camera_to_player();
        scr_effect_screenshake(2);
        scr_weapon_ammo_use(index, 1);
        scr_sound_play(snd_weapon_shoot_1, false, 0.8, 1.2);
		image_speed = 1;
		
        var xpos = x + lengthdir_x(14, mdir) + lengthdir_x(3, up(mdir));
        var ypos = y + lengthdir_y(14, mdir) + lengthdir_y(3, up(mdir));
		var dir = point_direction(xpos, ypos, mouse_x, mouse_y);
		
		part_type_direction(global.pt_flash_0, dir - 17, dir + 17, 0, 0);
		repeat(1) part_particles_create(global.ps_front, xpos + random_range(-3, 3), ypos + random_range(-3, 3), global.pt_flash_0, 2);
		part_type_direction(global.pt_smoke_5, dir - 17, dir + 17, 0, 0);
        repeat(1) part_particles_create(global.ps_front, xpos + lengthdir_x(3, dir) + random_range(-3, 3), ypos + lengthdir_y(3, dir) + random_range(-3, 3), global.pt_smoke_5, 2);
		scr_mouse_control(MouseType.Crosshair, 2, 20);
		
		if (!collision_line(x, y, xpos, ypos, obj_p_solid, false, true)){
	        shoot = instance_create(xpos, ypos, obj_proj_0);
			shoot.damage = shoot_damage;
			shoot.strength = shoot_strength;
	        shoot.dir = dir + random_range(-shoot_range, shoot_range);
			shoot.spd = 18;
			shoot.image_angle = shoot.dir;
		}
        
        shoot_can = false;
        shoot_time = 15;
        shoot_bounceback = -3;
        angle_offset = 8;
        flash_draw = true;
		flash_time = 0;
    }else if (shoot_can){
		scr_sound_play(snd_weapon_click_0, false, 0.8, 1);
	}
}

// Throwing Weapon
var mdir = point_direction(x, y, mouse_x, mouse_y);

if (global.player_stamina_active ){
    if (mouse_check_button_pressed(mb_right)){
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
		    throw.ammo = global.weapon_slotammo[global.weapon_slotcurrent]; // Set the ammo of the weapon drop to the ammo of this weapon. That way, when picked up again, it will have the same ammo reading.
			throw.ammodetermined = true;

		    instance_destroy();
		    global.weapon_slot[global.weapon_slotcurrent]=-1;
		}
    }
}

// Time
if (shoot_time > 0){
    shoot_time--;
}else{
    shoot_can = true;
}

