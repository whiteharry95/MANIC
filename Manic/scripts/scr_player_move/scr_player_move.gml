// Variables
var levelcur = scr_level_get_index(room);
var spd_multiplier = spd_offset;
var weapon_index = global.weapon_slot_standalone != -1 ? global.weapon_slot_standalone : global.weapon_slot[global.weapon_slotcurrent];
var real_weapon_index = weapon_index == -1 ? global.weapon_default : weapon_index;
var has_weapon = real_weapon_index != -1;
var footstep_wood, footstep_road, footstep_tile;
footstep_sound = global.player_footstep_default;

if (spd_offset > 1){
	spd_offset -= spd_offset_change;
}else if (spd_offset < 1){
	spd_offset += spd_offset_change;
}

// Minecart State
if (in_minecart){
	state = scr_player_minecart;
	return;
}

// Main
if (global.weapon_slot_standalone == -1){
	
	// Axis
	var inp_check_right, inp_check_left, inp_check_up, inp_check_down, inp_check_dash;
	var hor_mult = 1;
	var ver_mult = 1;
	
	inp_check_right = scr_input_is_down(InputBinding.Right);
	inp_check_left = scr_input_is_down(InputBinding.Left);
	inp_check_up = scr_input_is_down(InputBinding.Up);
	inp_check_down = scr_input_is_down(InputBinding.Down);
	inp_check_dash = scr_input_is_pressed(InputBinding.Dash);
	
	if (global.game_input_type == InputType.Gamepad) && (!steam_is_overlay_activated()) && (obj_controller_all.input_break <= 0){
		hor_mult = abs(gamepad_axis_value(global.game_input_gamepad_current, gp_axislh));
		ver_mult = abs(gamepad_axis_value(global.game_input_gamepad_current, gp_axislv));
	}
	
	xaxis = inp_check_right - inp_check_left;
	yaxis = inp_check_down - inp_check_up;
	
	xaxis *= hor_mult;
	yaxis *= ver_mult;
	
	if (!window_has_focus()){
		xaxis = 0;
		yaxis = 0;
	}
	
	if (!inp_check_right) && (!inp_check_left){
		xaxis = 0;
	}
	
	if (!inp_check_down) && (!inp_check_up){
		yaxis = 0;
	}
	
	dir = point_direction(0, 0, xaxis, yaxis);
	image_angle = 0;
	
	// Surrounding enemies
	var slist = ds_list_create();
	var surrounding_enemy_count = collision_circle_list(x, y, 120, obj_p_enemy, false, true, slist, false);
	
	ds_list_destroy(slist);
	
	// Speed
	if (surrounding_enemy_count > 2){
		spd_multiplier += 0.05;
	}
	
	if (surrounding_enemy_count > 3){
		spd_multiplier += 0.05;
	}
	
	if (surrounding_enemy_count > 4){
		spd_multiplier += 0.05;
	}
	
	if (i_time > 0){
		spd_multiplier += 0.1;
	}
	
	if (has_weapon){
		if (global.weapon_heavy[real_weapon_index]){
		    spd_multiplier -= 0.1;
		}
	}

	if (global.player_health_current <= 2){
	    spd_multiplier += 0.075;
	}
	
	if (global.player_health_current <= 4){
		spd_multiplier += 0.075;
	}

	if (!global.player_stamina_active){
	    spd_multiplier -= 0.1;
	}
	
	if (burn_time > 0){
		spd_multiplier += 0.075;
	}

	// Footstep Sound
	if (levelcur != Level.UndergroundBunker) && (levelcur != Level.HumanPrison) && (levelcur != Level.CityHeadquarters){
		if (layer_exists("InteriorFloorWood")){
			footstep_wood = layer_tilemap_get_id("InteriorFloorWood");
			if (tilemap_get_at_pixel(footstep_wood, x, y + 16)){
				footstep_sound = snd_character_footstep_wood;
			}
		}
		
		if (layer_exists("InteriorFloorTile")){
			footstep_tile = layer_tilemap_get_id("InteriorFloorTile");
			if (tilemap_get_at_pixel(footstep_tile, x, y + 16)){
				footstep_sound = snd_character_footstep_wood;
			}
		}
		
		if (room == rm_level_8_01) || (room == rm_level_8_02) || (room == rm_level_9_00) || (room == rm_level_9_01) || (room == rm_level_9_02){
			if (layer_exists("Road")){
				footstep_road = layer_tilemap_get_id("Road");
				if (layer_tilemap_exists(layer_get_id("Road"), footstep_road)){
					if (tilemap_get_at_pixel(footstep_road, x, y + 16)){
						footstep_sound = snd_character_footstep_wood;
					}
				}
			}
		}
	}
	
	// Player Sprite
	if (abs(len) > 0){
		if (footstep_time > 0){
			footstep_time -= len / spd_max;
		}else{
			footstep_time = 20;
			
			if (footstep_sound != -1){
				scr_sound_play(footstep_sound, false, 0.8, 1.2);
			}
		}
		
		if (walk_smoke_time > 0){
			walk_smoke_time --;
		}else{
			part_particles_create(global.ps_front, x - image_xscale, y + 4 + random_range(-8, 8), global.pt_walk_smoke_0, 1);
			
			walk_smoke_time = walk_smoke_time_max;
		}
	}else{
		footstep_time = 10;
	}

	if (len == 0) && (xaxis == 0) && (yaxis == 0){
	    if (has_weapon){
	        if (!global.weapon_heavy[real_weapon_index]){
	            sprite_index = spr_player_idle_0;
	        }else{
	            sprite_index = spr_player_idle_2;
	        }
	    }else{
	        sprite_index = spr_player_idle_1;
	    }
	}else{
		// Movement
	    if (has_weapon){
			if (!global.weapon_heavy[real_weapon_index]){
				sprite_index = spr_player_walk_0;
			}else{
				sprite_index = spr_player_walk_2;
			}
		}else{
			sprite_index = spr_player_walk_1;
	    }
	}

	// Knockback
	if (knockback) && (move_x_to == -1) && (move_y_to == -1) && (global.cutscene_current == -1){
		for(var i = knockback_speed + 3; i > -1; i--){
		    if (place_meeting(x + lengthdir_x(i, knockback_direction), y + lengthdir_y(i, knockback_direction), obj_p_solid)) || (knockback_speed <= 0.2){
				knockback_speed = 0;
		        knockback = false;
				return;
		    }
		}
		
		x += lengthdir_x(knockback_speed, knockback_direction);
		y += lengthdir_y(knockback_speed, knockback_direction);
    
	    knockback_speed *= 0.9;
	}else{
		knockback = false;
		knockback_speed = 0;
	}
	
	if (inp_check_dash) && (dash_time <= 0) && (global.cutscene_current == -1) && (move_x_to == -1) && (move_y_to == -1){
		dash_length = 55;
		dash_speed = spd_max * 3.65;
		dash_time = 18;
		
		if (upgrade_has[PlayerUpgrade.DashBoots]){
			dash_speed *= 1.35;
			
			if (dash_count < 1){
				dash_count ++;
				dash_time = 2;
				dash_time_short = 13;
				scr_sound_play(snd_character_dash_0, false, 0.9, 1);
			}else{
				dash_count = 0;
				dash_time = 21;
				scr_sound_play(snd_character_dash_0, false, 1.15, 1.25);
			}
		}else{
			scr_sound_play(snd_character_dash_0, false, 0.8, 1.2);
		}
		
		dash_length_current = 0;
	    dash_direction = point_direction(0, 0, xaxis, yaxis);
		
		if (xaxis == 0) && (yaxis == 0){
			if (sign(image_xscale) == 1){
				dash_direction = 360;
			}else{
				dash_direction = 180;
			}
		}
		
	    state = scr_player_dash;
	    return;
	}
	
	if (dash_time_short > 0){
		dash_time_short --;
	}else{
		if (dash_count != 0){
			dash_time = 37 - 16;
			dash_count = 0;
		}
	}
	
	if (dash_time > 0){
		dash_time --;
	}
	
	// Movement
	if (move_x_to == -1) && (move_y_to == -1){
		if (global.cutscene_current == -1){
			if ((xaxis == 0) && (yaxis == 0)){
			    len = 0;
			}else{
			    if (len < (spd_max * spd_multiplier)){
			        len += (spd_build * spd_multiplier);
			    }else if (len > (spd_max * spd_multiplier)){
			        len -= 0.1;
			    }
			}
			
			img_speed = (len * 0.165) * spd_multiplier;
		}else{
			len = 0;
			sprite_index = spr_player_idle_1;
			img_speed = 0.03;
		}
	}else{
		var idlesprite = spr_player_idle_1;
		var walksprite = spr_player_walk_1;
		
		if (global.cutscene_current == 57) && (global.weapon_slot[0] == PlayerWeapon.Revolver){
			idlesprite = spr_player_idle_0;
			walksprite = spr_player_walk_0;
		}
		
		dir = point_direction(x, y, move_x_to, move_y_to);
		sprite_index = walksprite;
		
		if (distance_to_point(move_x_to, move_y_to) < 7){
		    len = 0;
			sprite_index = idlesprite;
			img_speed = 0.03;
		}else{
			var spd = move_ext_spd;
			
			if (spd == -1){
				spd = spd_max;
			}
			
		    if (len < (spd * spd_multiplier)){
		        len += (spd_build * spd_multiplier);
		    }else if (len > (spd * spd_multiplier)){
		        len -= 0.05;
		    }
		}
		
		img_speed = (len * 0.165) * spd_multiplier;
	}
	
	if (len == 0) && (xaxis == 0) && (yaxis == 0){
		img_speed = 0.05;
	}else if (move_x_to == -1) && (move_y_to == -1){
		if (xaxis != 0){
			if (sign(xaxis) != sign(image_xscale)){
				img_speed *= -1;
			}
		}
	}else{
		if (sign(move_x_to - x) != sign(image_xscale)){
			img_speed *= -1;
		}
	}
	
	if (len > 0){
		with(obj_controller_ui){
			if (tutourial){
				if (tutourial_stage == TutourialStage.Movement){
					if (tutourial_stage_moving_time < 60 * 3){
						tutourial_stage_moving_time ++;
					}else{
						scr_tutourial_next_stage();
						tutourial_stage_timer = -1;
						tutourial_stage_moving_time = 0;
					}
				}
			}
		}
	}
	
	hspd = lengthdir_x(len, dir);
	vspd = lengthdir_y(len, dir);
}else{
	sprite_index = spr_player_idle_2;
	img_speed = 0.05;
	
	hspd = 0;
	vspd = 0;
}

// Sprite Flip
if (move_x_to == -1) && (move_y_to == -1) && (global.cutscene_current == -1){
	if (scr_input_get_mouse_x() > global.player_position_x){
		image_xscale = 1;
	}else{
		image_xscale = -1;
	}
}else{
	if (move_x_to > x){
		image_xscale = 1;
	}else{
		image_xscale = -1;
	}
	
	// Open doors
	if (global.cutscene_current == 53 || global.cutscene_current == 57){
		var nearest_door = instance_nearest(x, y, obj_p_depth_door);
	
		if (nearest_door != noone){
			if (room != rm_level_6_pre_00 || nearest_door.object_index != obj_prisonbuilding_door_0){
				if (point_distance(x, y, nearest_door.x + (nearest_door.sprite_width / 2), nearest_door.y + (nearest_door.sprite_height / 2)) < 50){
					if (!nearest_door.open){
						nearest_door.auto_interact = true;
					}
				}
			}
		}
	}
}

if (global.cutscene_current != -1){
	if (flashlight_direction < 90) || (flashlight_direction > 270){
		image_xscale = 1;
	}else if (flashlight_direction > 90) || (flashlight_direction < 270){
		image_xscale = -1;
	}
}

if (!window_has_focus()){
	hspd = 0;
	vspd = 0;
}

scr_player_collision();

// Hspd and Vspd
if (move_x_to == -1) && (move_y_to == -1){
	x += hspd;
	y += vspd;
}else{
	mp_potential_step_object(move_x_to, move_y_to, len, obj_p_solid);
}

// Dash After Speed
if (dash_after_speed > 0.01){
	if (!place_meeting(x + lengthdir_x((dash_after_speed * spd_multiplier) + 2, dash_after_dir), y + lengthdir_y((dash_after_speed * spd_multiplier) + 2, dash_after_dir), obj_p_solid)){
		x += lengthdir_x(dash_after_speed * spd_multiplier, dash_after_dir);
		y += lengthdir_y(dash_after_speed * spd_multiplier, dash_after_dir);
		dash_after_speed *= 0.5 * spd_multiplier;
	}else{
		dash_after_speed = 0;
		dash_after_dir = 0;
	}
	
	img_speed += dash_after_speed * 0.165;
}