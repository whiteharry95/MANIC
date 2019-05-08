var player = obj_player;
var player_exists = instance_exists(player);
scr_position_view();
crazy_can_spawn = global.game_firstcrazy_killed;

var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);
var camw = camera_get_view_width(view_camera[0]);
var camh = camera_get_view_height(view_camera[0]);

if (!global.game_pause){
	
	// Dust
	if (random(6) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_0, 1);
	if (random(8) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_1, 1);
	
	// Tumbleweed
	if (random(200) < 1){
		if (player_exists){
			if (instance_number(obj_environment_tumbleweed) < 5){
				var xx = random_range(camx, camx + camw);
				var yy = random_range(camy, camy + camh);
				var safe = 0;
		
				while(point_distance(xx, yy, player.x, player.y) < 200) || (place_meeting(xx, yy, obj_p_solid)) || (scr_ceiling_at(xx, yy)){
					xx = random_range(camx, camx + camw);
					yy = random_range(camy, camy + camh);
		
					if (safe < 100){
						safe ++;
					}else{
						break;
					}
				}
			
				if (safe < 100){
					instance_create(xx, yy, obj_environment_tumbleweed);
				}
			}
		}
	}
	
	// Fog
	if (random(2.5) < 1){
		if (part_particles_count(global.pt_smoke_3) < 40){
			part_particles_create(global.ps_front, camx + random_range(0, camw), camy + random_range(0, camh), global.pt_smoke_3, 1);
		}
	}

	// Snow
	repeat(4){
	    part_particles_create(global.ps_front, camx + random_range(-350, camw), camy - 10, global.pt_snow_0, 1);
	}

	if (random(2) < 1){
	    part_particles_create(global.ps_bottom, camx + random_range(0, camw), camy + random_range(0, camh), global.pt_snow_1, 1);
	}
}

// Music
if (!global.game_pause){
	if (!audio_is_playing(wind)){
		wind = audio_play_sound(m_ambience_wind_0, 3, true);
		audio_sound_gain(wind, 0, 0);
		audio_sound_gain(wind, 1 * obj_controller_all.real_ambience_volume, 4000);
	}
}

// Spawning
var lighting_level; 
lighting_level[CombatState.Climax] = 1;
lighting_level[CombatState.Buildup] = 0.925;
lighting_level[CombatState.Idle] = 0.85;

var lighting_to = lighting_level[global.game_combat_state];
if (global.game_combat_in_hordechallenge){
	lighting_to = 1;
}

if (lighting < lighting_to){
	lighting += 0.004;
}else if (lighting > lighting_to){
	lighting -= 0.004;
}

global.ambientShadowIntensity = lighting;

if (player_exists){
	var spawn_rate = spawn_rate_real;
	if (global.game_combat_active) && (!global.game_pause) && (global.boss_current == -1) && (global.cutscene_current == -1) && ((!global.level_cleared[global.level_current]) || (global.game_combat_in_hordechallenge)){
		if ((global.weapon_slot_standalone == PlayerWeapon.MountedMachineGun) || (global.weapon_slot_standalone == PlayerWeapon.MountedMachineGunCart)){
			spawn_rate ++;
		}
		
		if (global.game_combat_in_hordechallenge){
			spawn_rate += 5;
		}
		
		if (spawn_time > 0){
			spawn_time -= spawn_rate;
		}else{
			spawn = true;
			spawn_time = 60 * spawn_interval[global.game_combat_state];
			spawn_time /= spawn_rate;
		}
		
		if (!global.game_combat_in_hordechallenge){
			global.game_combat_state_time_real ++;
		}
		
		if (spawn){
			if (scr_enemy_count(false) < spawn_max[global.game_combat_state]){
				var xpos = random_range(camx - 10, camx + camw + 10);
				var ypos = random_range(camy - 10, camy + camh + 10);
				var spawn_trial = 0;
				
				while(collision_rectangle(xpos - 20, ypos - 20, xpos + 20, ypos + 30, obj_p_solid, false, false)) || (collision_line(xpos, ypos, player.x, player.y, obj_p_solid, false, true)) || (point_distance(xpos, ypos, player.x, player.y) < 80) || (place_meeting(xpos, ypos, obj_campfire_0)){
					xpos = random_range(camx - 10, camx + camw + 10);
					ypos = random_range(camy - 10, camy + camh + 10);
					spawn_trial ++;
				
					if (spawn_trial > 1000){
						spawn_trial = 0;
						return;
					}
				}
		
				var weapon;
				
				if (chance(70)){
					weapon = choose(PawnWeapon.Crowbar, PawnWeapon.Axe, PawnWeapon.Machete);
				}else{
					weapon = choose(PawnWeapon.Grenade, PawnWeapon.Rake, PawnWeapon.Sledgehammer);
				}
				
				var enemy;
				
				if (chance(75)){
					enemy = instance_create(xpos, ypos, obj_enemy_0);
				
					if (spawn_rate > 1.4){
						if (global.boss_current == -1){
							if (chance(5)){
								enemy.type = Enemy0_Type.Mother;
							}
						}
					}
					
					if (crazy_can_spawn){
						if (chance(10)){
							enemy.type = Enemy0_Type.Crazy;
						}
					}
					
					if (weapon == PawnWeapon.Grenade){
						enemy.type = Enemy0_Type.Grenadier;
					}
				
					if (enemy.type == Enemy0_Type.Sniper){
						weapon = PawnWeapon.SniperRifle;
					}
				
					enemy.weapon_index = weapon;
				}else{
					enemy = instance_create(xpos, ypos, obj_enemy_2);
				}

				repeat(9){
					part_particles_create(global.ps_front, xpos + random_range(-7, 7), ypos + random_range(-18, 18), global.pt_spawn_0, 1);
				}
			}
			
			spawn = false;
		}
		
	}else if (global.game_pause){
		
		if (audio_is_playing(spawn_music_main[CombatState.Idle])){
			audio_pause_sound(spawn_music_main[CombatState.Idle]);
		}
		
		if (audio_is_playing(spawn_music_main[CombatState.Buildup])){
			audio_pause_sound(spawn_music_main[CombatState.Buildup]);
		}
		
		if (audio_is_playing(spawn_music_main[CombatState.Climax])){
			audio_pause_sound(spawn_music_main[CombatState.Climax]);
		}
		
		if (global.boss_current != -1){
			var bossmusic = global.boss_music[global.boss_current];
			
			if (bossmusic != noone){
				if (audio_is_playing(bossmusic)){
					audio_pause_sound(bossmusic);
				}
			}
		}
		
		if (audio_is_playing(wind)){
			audio_pause_sound(wind);
		}
		
		spawn_pause_update = false;
	}
	
}else{
	global.game_combat_state_time_real = 0;
	spawn_rate_real = 0.75;
	global.game_combat_state = CombatState.Idle;
	
	if (global.cutscene_current == -1){
		audio_sound_gain(spawn_music_main[CombatState.Idle], 0, 1000);
		audio_sound_gain(spawn_music_main[CombatState.Buildup], 0, 1000);
		audio_sound_gain(spawn_music_main[CombatState.Climax], 0, 1000);
	}
}

global.game_combat_active = true;
scr_level_combatstate_control();