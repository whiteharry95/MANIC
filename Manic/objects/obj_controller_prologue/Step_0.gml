scr_position_view();

var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);
var camw = camera_get_view_width(view_camera[0]);
var camh = camera_get_view_height(view_camera[0]);

if (!global.game_pause){
	
	// Dust
	if (random(6) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_3, 1);
	if (random(8) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_1, 1);
	
	// Fog
	if (random(6) < 1){
		if (part_particles_count(global.pt_smoke_3) < 30){
			part_particles_create(global.ps_front, camx + random_range(0, camw), camy + random_range(0, camh), global.pt_smoke_3, 1);
		}
	}
}

// Wind
if (!global.game_pause){
	if (!audio_is_playing(wind)){
		wind = audio_play_sound(m_ambience_wind_0, 3, true);
		audio_sound_gain(wind, 0, 0);
		audio_sound_gain(wind, 1 * obj_controller_all.real_ambience_volume, 20000);
	}
}else{
	spawn_pause_update = false;
	
	if (audio_is_playing(wind)){
		audio_pause_sound(wind);
	}
}

// Spawning
if (!global.level_cleared[global.level_current]){
	lighting = 0.7;
}else{
	var to = 0.95;
	
	if (lighting < to){
		lighting += 0.0002;
	}else if (lighting > to){
		lighting -= 0.0002;
	}
	
	if (!endscene_initiated){
		var child0 = inst_3992F7F2;
		var child1 = inst_1FCF6CFC;
		var wife = inst_6C02B40B;
		
		instance_activate_all();
		
		with(obj_bed_small_0){
			fire = true;
		}
		
		with(obj_bed_large_0){
			fire = true;
		}
		
		with(obj_table_0){
			fire = true;
		}
		
		with(obj_chair_0){
			fire = true;
		}
		
		var cratecount = instance_number(obj_crate_0);
		for(var i = 0; i < cratecount; i ++){
			var thiscrate = instance_find(obj_crate_0, i);
			
			if (thiscrate.x < 1038){
				with(thiscrate){
					var brk = instance_create(x, y, obj_break);
					brk.sprite_index = spr_crate_0_break;
				}
			}
		}
		
		var light = instance_create(466, 552, obj_block_light);
		light.size[0] = 360;
		light.time = -1;
		
		var firesound = instance_create(502, 544, obj_block_sound);
		firesound.sound = snd_character_burn_0;
		firesound.radius = 600;
		
		var child0corpse = instance_create(child0.x, child0.y, obj_enemy_corpse);
		child0corpse.sprite_index = spr_player_child_0_corpse_0;
		
		var child1corpse = instance_create(child1.x, child1.y, obj_enemy_corpse);
		child1corpse.sprite_index = spr_player_child_1_corpse_0;
		
		var wifecorpse = instance_create(wife.x, wife.y, obj_enemy_corpse);
		wifecorpse.sprite_index = spr_player_wife_corpse_0;
		
		instance_destroy(child0);
		instance_destroy(child1);
		instance_destroy(wife);
		
		instance_destroy(obj_farmbuilding_3);
		instance_destroy(obj_farmbuilding_4);
		
		endscene_initiated = true;
	}
}

if (!global.game_pause) && (instance_exists(obj_player)){
	deer_can_spawn = ((obj_controller_ui.tutourial_stage > 1) || (!obj_controller_ui.tutourial))
					&& (instance_number(obj_enemy_5) < 1)
					&& (point_distance(obj_player.x, obj_player.y, 530, 550) > 600)
					&& (!global.level_cleared[global.level_current]);

	if (deer_can_spawn){
		if (deer_spawn_time > 0){
			deer_spawn_time --;
		}else{
			var xx = random_range(camx - 200, camx + camw + 200);
			var yy = random_range(camy - 200, camy + camh + 200);
			var counter = 0;
			var dospawn = true;
			
			while (onscreen(xx, yy, -50) || !inroom(xx, yy) || collision_rectangle(xx - 30, yy - 20, xx + 30, yy + 20, obj_p_solid, false, true)){
				xx = random_range(camx - 200, camx + camw + 200);
				yy = random_range(camy - 200, camy + camh + 200);
				
				if (counter < 100){
					counter ++;
				}else{
					dospawn = false;
					break;
				}
			}
			
			if (dospawn){
				instance_create(xx, yy, obj_enemy_5);
			
				repeat(15){
					part_particles_create(global.ps_front, xx + random_range(-7, 7), yy + random_range(-18, 18), global.pt_spawn_0, 1);
				}
			}
			
			deer_spawn_time = 60 * random_range(4, 7);
		}
	}
}

global.ambientShadowIntensity = lighting;
global.game_combat_active = false;
scr_level_combatstate_control();