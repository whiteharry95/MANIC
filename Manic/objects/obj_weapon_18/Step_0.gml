if (global.game_pause) || (global.cutscene_current != -1){
	image_speed = 0;
	return;
}

image_speed = 1;

var mdir = point_direction(x, y, mouse_x, mouse_y);

if (instance_exists(obj_player)) && (global.player_stamina_active){
    if (mouse_check_button_pressed(obj_controller_all.key_attack)) || (mouse_check_button_pressed(obj_controller_all.key_throw)){
		if (!collision_line(obj_player.x, obj_player.y, x + lengthdir_x(3, mdir), y + lengthdir_y(3, mdir), obj_p_solid, false, true)){
	        scr_player_stamina_drain(20);
			
			scr_effect_screenshake(1);
	        scr_sound_play(snd_weapon_swing_0, false, 0.8, 1.2);
			global.weapon_quantity[index]--;
			
	        throw = instance_create(x, y, obj_throwobject_0);
	        throw.spd = 6;
	        throw.damage = damage;
	        throw.dir = mdir;
			throw.damage_enemy = true;
			throw.damage_player = true;
			throw.damage_companion = false;
				
			if (global.weapon_quantity[index] <= 0){
				instance_destroy();
				global.weapon_slot[global.weapon_slotcurrent] = -1;
			}
        }
    }
}