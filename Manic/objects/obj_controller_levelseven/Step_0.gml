var player = obj_player;
var player_exists = instance_exists(player);
scr_position_view();
fly_can_spawn = global.game_firstflyhead_killed;

var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);
var camw = camera_get_view_width(view_camera[0]);
var camh = camera_get_view_height(view_camera[0]);

if (!global.game_pause){
	
	// Dust
	if (random(2) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_0, 1);
	if (random(4) < 1) part_particles_create(global.ps_front, random_range(camx, camx + camw), random_range(camy, camy + camh), global.pt_dust_1, 1);
	
	// Tumbleweed
	if (random(180) < 1){
		if (player_exists){
			if (instance_number(obj_environment_tumbleweed) < 5){
				var xx = camx + random(camw);
				var yy = camy + random(camh);
				var safe = 0;
				
				var groundlayer = layer_get_id("InteriorFloorWood");
				var groundmap = layer_tilemap_get_id(groundlayer);
		
				while(point_distance(xx, yy, global.player_position_x, global.player_position_y) < 200) || (place_meeting(xx, yy, obj_p_solid)) || (tilemap_get_at_pixel(groundmap, xx, yy)){
					xx = camx + random(camw);
					yy = camy + random(camh);
		
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
	
	// Rain
	if (random(2) < 1){
		part_particles_create(global.ps_front, camx + random_range(-350, camw), camy - 10, global.pt_rain_0, 1);
	}
	
	if (random(5) < 1){
	    var dropx, dropy;
		
		do{
			dropx = camx + random_range(0, camw);
			dropy = camy + random_range(0, camh);
		}until(!scr_ceiling_at(dropx, dropy));
		
	    part_particles_create(global.ps_bottom, dropx, dropy, choose(global.pt_rain_1, global.pt_rain_2), 1);
	}
	
	// Fog
	if (random(2.5) < 1){
		if (part_particles_count(global.pt_fog_0) < 40){
			part_particles_create(global.ps_front, camx + random_range(0, camw), camy + random_range(0, camh), global.pt_fog_0, 1);
		}
	}
}

// Checkpoint
if (room == rm_level_7_02){
	if (global.cutscene_current == -1) && (!global.level_checkpoint_found[global.level_current, 0]){
		obj_controller_gameplay.checkpoint_create = true;
		global.level_checkpoint_found[global.level_current, 0] = true;
	}
}

// Spawning
var lighting_level; 
lighting_level[CombatState.Climax] = 1;
lighting_level[CombatState.Buildup] = 0.935;
lighting_level[CombatState.Idle] = 0.875;

var lighting = lighting_level[global.game_combat_state];

if (global.game_combat_in_hordechallenge){
	lighting = 1;
}

if (scr_level_is_peaceful(room)){
	lighting = 0.875 + (mean(camx / room_width, 1 - (camy / room_height)) * 0.025);
}

global.game_lighting = lighting + scr_brightness_offset();

if (player_exists) && (global.cutscene_current == -1){
	if (abs(obj_player.len) > 0.1){
		if (spawn_start_wait < spawn_start_wait_max){
			spawn_start_wait ++;
		}
	}
}

if (spawn_start_wait >= spawn_start_wait_max){
	if (player_exists) && (!scr_level_is_peaceful(room)){
		var spawn_rate = spawn_rate_real;
		if (!global.game_pause) && ((global.boss_current == -1) || (global.boss_current == Boss.MotherRobot) || (global.boss_current == Boss.SniperRobot)) && (global.cutscene_current == -1){
			if ((global.weapon_slot_standalone == PlayerWeapon.MountedMachineGun) || (global.weapon_slot_standalone == PlayerWeapon.MountedMachineGunCart)){
				spawn_rate += 0.5;
			}
		
			if (global.game_combat_in_hordechallenge){
				spawn_rate += horde_spawn_rate;
			}else{
				global.game_combat_state_time_real ++;
			}
		
			spawn_rate += global.game_combat_playerskill - 1;
			
			if (global.game_combat_state_time_real < (60 * spawn_state_time[global.game_combat_state])){
				if (spawn_time > 0){
					spawn_time -= spawn_rate;
				}else{
					spawn = true;
					spawn_time = 60 * (global.game_combat_in_hordechallenge ? global.game_combat_in_hordechallenge_spawnbreak : spawn_interval[global.game_combat_state]);
				}
			}
		
			if (spawn){
				if (scr_enemy_count(false) < round(spawn_max[global.game_combat_state] * max(global.game_combat_in_hordechallenge * 2, 1))){
					var xpos = random_range(camx - 10, camx + camw + 10);
					var ypos = random_range(camy - 10, camy + camh + 10);
					var spawn_trial = 0;
				
					while(!scr_is_valid_enemyspawn(xpos, ypos)){
						xpos = random_range(camx - 10, camx + camw + 10);
						ypos = random_range(camy - 10, camy + camh + 10);
						spawn_trial ++;
				
						if (spawn_trial > 1000){
							spawn_trial = 0;
							return;
						}
					}
		
					var weapon;
				
					if (chance(90)){
						weapon = choose(PawnWeapon.Axe, PawnWeapon.Machete, PawnWeapon.Sledgehammer);
					}else{
						weapon = choose(PawnWeapon.Grenade);
					}
				
					var enemy;
				
					if (chance(80)){
						enemy = instance_create(xpos, ypos, obj_enemy_0);
					
						if (spawn_rate > 0.9){
							if (global.boss_current == -1){
								if (chance(3.5)){
									enemy.type = Enemy0_Type.Mother;
								}
						
								if (chance(3.5)){
									enemy.type = Enemy0_Type.Sniper;
								}
							}
						}
				
						if (spawn_rate > 1.4){
							if (global.boss_current == -1){
								if (chance(4)){
									enemy.type = Enemy0_Type.Mother;
								}
						
								if (chance(5)){
									enemy.type = Enemy0_Type.Sniper;
								}
							}
						}
				
						if (chance(5)){
							enemy.type = Enemy0_Type.Crazy;
						}
				
						if (fly_can_spawn){
							if (chance(4)){
								enemy.type = Enemy0_Type.Fly;
							}
						}
				
						if (chance(5)){
							enemy.type = Enemy0_Type.Healer;
						}
						
						if (global.game_combat_in_hordechallenge){
							enemy.type = Enemy0_Type.Normal;
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
		}
	}else{
		global.game_combat_state_time_real = 0;
		spawn_rate_real = 1;
		
		global.game_combat_state = CombatState.Idle;
		
		if (global.cutscene_current == -1){
			audio_sound_gain(spawn_music_main[CombatState.Idle], 0, 1000);
			audio_sound_gain(spawn_music_main[CombatState.Buildup], 0, 1000);
			audio_sound_gain(spawn_music_main[CombatState.Climax], 0, 1000);
		}
	}
}

if (!global.game_pause){
	if (!audio_is_playing(m_ambience_rain_0)) || (audio_sound_get_gain(m_ambience_rain_0) < 0.01){
		if (!audio_is_playing(m_ambience_rain_0)) audio_play_sound(m_ambience_rain_0, 3, true);
		audio_sound_gain(m_ambience_rain_0, 0.01, 0);
		audio_sound_gain(m_ambience_rain_0, 1 * obj_controller_all.real_ambience_volume, 7000);
	}
}

scr_level_combatstate_control();

scr_level_audio_pause_and_resume();