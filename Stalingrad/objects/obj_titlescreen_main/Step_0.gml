if (room != rm_title_0){
	instance_destroy();
}

#region Effects
var camx = camera_get_view_x(view_camera[0]);
var camy = camera_get_view_y(view_camera[0]);
var camw = camera_get_view_width(view_camera[0]);
var camh = camera_get_view_height(view_camera[0]);

// Dust
if (random(5) < 1) part_particles_create(global.ps_front, camx + random(camw), camy + random(camh), global.pt_dust_0, 1);
if (random(10) < 1) part_particles_create(global.ps_front, camx + random(camw), camy + random(camh), global.pt_dust_1, 1);

// Tumbleweed
if (random(170) < 1){
	if (instance_number(obj_environment_tumbleweed) < 5){
		var xx = camx + random(camw);
		var yy = camy + random(camh);
		var safe = 0;
	
		while(place_meeting(xx, yy, obj_p_solid)){
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

// Rain
repeat(2){
    part_particles_create(global.ps_front, camera_get_view_x(view_camera[0]) + random_range(-150, camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) - 10, global.pt_rain_0, 1);
}

if (random(2) < 1){
    part_particles_create(global.ps_bottom, camera_get_view_x(view_camera[0]) + random_range(0, camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + random_range(0, camera_get_view_height(view_camera[0])), choose(global.pt_rain_1, global.pt_rain_2), 1);
}

// Fog
if (random(2.5) < 1){
	if (part_particles_count(global.pt_smoke_3) < 40){
		part_particles_create(global.ps_front, camera_get_view_x(view_camera[0]) + random_range(0, camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + random_range(0, camera_get_view_height(view_camera[0])), global.pt_smoke_3, 1);
	}
}
#endregion

#region Text Scale Hander
if (in_settings) || (in_levelselect){
	for(var i = 0; i <= option_max; i ++){
		option_scale[i] = 1;
	}
	
	if (!in_settings_gameplay){
		for(var i = 0; i <= option_setting_gameplay_max; i ++){
			option_setting_gameplay_scale[i] = 1;
		}
	}
	
	if (!in_settings_display){
		for(var i = 0; i <= option_setting_display_max; i ++){
			option_setting_display_scale[i] = 1;
		}
	}
	
	if (!in_settings_audio){
		for(var i = 0; i <= option_setting_audio_max; i ++){
			option_setting_audio_scale[i] = 1;
		}
	}
	
	if (!in_settings_controls){
		for(var i = 0; i <= option_setting_controls_max; i ++){
			option_setting_controls_scale[i] = 1;
		}
	}
}

if (!in_settings){
	for(var i = 0; i <= option_setting_max; i ++){
		option_setting_scale[i] = 1;
	}
}

if (!in_levelselect){
	for(var i = 0; i <= option_levelselect_max; i ++){
		option_levelselect_scale[i] = 1;
	}
}

#endregion

if (fade){
	if (fade_alpha < 1){
		fade_alpha += fade_speed;
	}else{
		room_goto(fade_goto);
	}
}else{
	var omax = option_max;
	if (in_settings) && (!in_levelselect){
		var omax = option_setting_max;
		if (in_settings_gameplay){
			omax = option_setting_gameplay_max + 1;
		}else if (in_settings_display){
			omax = option_setting_display_max + 1;
		}else if (in_settings_audio){
			omax = option_setting_audio_max + 1;
		}else if (in_settings_controls){
			omax = option_setting_controls_max + 1;
		}
	}else if (in_levelselect){
		omax = option_levelselect_max;
	}
	
	selected = clamp(selected, 0, omax);
	
	if (fade_opening){
		if (fade_alpha > 0){
			fade_alpha -= 0.05;
		}else{
			fade_alpha = 0;
			fade_opening = false;
		}
		
		fade_alpha = clamp(fade_alpha, 0, 1);
		exit;
	}
	
	if (!searching_for_input){
		if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)){
			if (selected > 0){
				selected--;
			}else{
				selected = omax;
			}
		
			if (!in_settings) && (!in_levelselect){
				while(option_locked[selected]){
					if (selected > 0){
						selected--;
					}else{
						selected = omax;
					}
				}
			}else if (in_levelselect){
				while(!option_levelselect_unlocked[selected]){
					if (selected > 0){
						selected--;
					}else{
						selected = omax;
					}
				}
			}
		}

		if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)){
			if (selected < omax){
				selected ++;
			}else{
				selected = 0;
			}
		
			if (!in_settings) && (!in_levelselect){
				while(option_locked[selected]){
					if (selected < omax){
						selected ++;
					}else{
						selected = 0;
					}
				}
			}else if (in_levelselect){
				while(!option_levelselect_unlocked[selected]){
					if (selected < omax){
						selected ++;
					}else{
						selected = 0;
					}
				}
			}
		}
	
		if (press_break > 0){
			press_break --;
		}else{
			if (in_settings){
				if (in_settings_gameplay){
					if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
						if (option_setting_gameplay_value[selected] < option_setting_gameplay_value_max[selected]){
							option_setting_gameplay_value[selected] += option_setting_gameplay_value_interval[selected];
						}else{
							option_setting_gameplay_value[selected] = option_setting_gameplay_value_min[selected];
						}
				
						global.game_option[| option_setting_gameplay_edit[selected]] = option_setting_gameplay_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
			
					if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
						if (option_setting_gameplay_value[selected] > option_setting_gameplay_value_min[selected]){
							option_setting_gameplay_value[selected] -= option_setting_gameplay_value_interval[selected];
						}else{
							option_setting_gameplay_value[selected] = option_setting_gameplay_value_max[selected];
						}
				
						global.game_option[| option_setting_gameplay_edit[selected]] = option_setting_gameplay_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
				}else if (in_settings_display){
					if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
						if (option_setting_display_value[selected] < option_setting_display_value_max[selected]){
							option_setting_display_value[selected] += option_setting_display_value_interval[selected];
						}else{
							option_setting_display_value[selected] = option_setting_display_value_min[selected];
						}
				
						global.game_option[| option_setting_display_edit[selected]] = option_setting_display_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
			
					if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
						if (option_setting_display_value[selected] > option_setting_display_value_min[selected]){
							option_setting_display_value[selected] -= option_setting_display_value_interval[selected];
						}else{
							option_setting_display_value[selected] = option_setting_display_value_max[selected];
						}
				
						global.game_option[| option_setting_display_edit[selected]] = option_setting_display_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
				}else if (in_settings_audio){
					if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
						if (option_setting_audio_value[selected] < option_setting_audio_value_max[selected]){
							option_setting_audio_value[selected] += option_setting_audio_value_interval[selected];
						}else{
							option_setting_audio_value[selected] = option_setting_audio_value_min[selected];
						}
				
						global.game_option[| option_setting_audio_edit[selected]] = option_setting_audio_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
			
					if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
						if (option_setting_audio_value[selected] > option_setting_audio_value_min[selected]){
							option_setting_audio_value[selected] -= option_setting_audio_value_interval[selected];
						}else{
							option_setting_audio_value[selected] = option_setting_audio_value_max[selected];
						}
				
						global.game_option[| option_setting_audio_edit[selected]] = option_setting_audio_value[selected];
						scr_options_refresh();
						press_break = 5;
					}
				}
			}
		}
	
		if (keyboard_check_pressed(vk_enter)){
			var isvalid = false;
		
			if (!in_settings) && (!in_levelselect){
				isvalid = true;
				switch(selected){
					case 0:
						audio_sound_gain(rain, 0, 2000);
						
						fade = true;
						fade_goto = global.level_room[global.game_save_level];
						fade_speed = 0.01;
						global.game_playthrough = true;
						break;
					
					case 1:
						in_levelselect = true;
						break;
					
					case 2:
						in_settings = true;
						break;
				
					case 3:
						game_end();
						break;
				}
			}else if (in_settings) && (!in_levelselect){
				if (selected == omax) && ((in_settings_gameplay) || (in_settings_display) || (in_settings_audio) || (in_settings_controls)){
					if (indicate_text_alpha <= 0) || (indicate_text != "Options have been reset"){
						var otype = "";
						
						if (in_settings_gameplay){
							otype = "gameplay";
						}else if (in_settings_display){
							otype = "display";
						}else if (in_settings_audio){
							otype = "audio";
						}else if (in_settings_controls){
							otype = "controls";
						}
						
						scr_option_reset_defaults(otype);
						
						indicate_text = "Options have been reset";
						indicate_text_time = 135;
						indicate_text_alpha = 1;
					}
				}else{
					if (in_settings_controls){
						searching_for_input = true;
						searching_for_input_wait = 15;
						searching_for_input_mouse = option_setting_controls_ismouse[selected];
					}else if (!in_settings_gameplay) && (!in_settings_display) && (!in_settings_audio){
						isvalid = true;
						switch(selected){
							case 0:
								in_settings_gameplay = true;
								break;
				
							case 1:
								in_settings_display = true;
								break;
				
							case 2:
								in_settings_audio = true;
								break;
				
							case 3:
								in_settings_controls = true;
								break;
						
							case 4:
								if (indicate_text_alpha <= 0) || ((indicate_text != "No save data was found") && (indicate_text != "Save data has been reset")){
									if (file_exists("save.ini")){
										file_delete("save.ini");
										indicate_text = "Save data has been reset";
									}else{
										indicate_text = "No save data was found";
									}
									
									indicate_text_time = 135;
									indicate_text_alpha = 1;
								}
								
								isvalid = false;
								break;
						}
					}
				}
			}else if (in_levelselect){
				audio_sound_gain(rain, 0, 2000);
				
				fade = true;
				fade_goto = option_levelselect_goto[selected];
				fade_speed = 0.01;
				global.game_playthrough = false;
			}
		
			if (isvalid){
				selected = 0;
			}
		}
	
		if (keyboard_check_pressed(vk_backspace)){
			var isvalid = false;
		
			if (in_settings) && (!in_levelselect){
				isvalid = true;
				if (!in_settings_gameplay) && (!in_settings_display) && (!in_settings_audio) && (!in_settings_controls){
					in_settings = false;
				}else{
					in_settings_gameplay = false;
					in_settings_display = false;
					in_settings_audio = false;
					in_settings_controls = false;
				}
			}else if (in_levelselect){
				in_levelselect = false;
			}
		
			if (isvalid){
				selected = 0;
			}
		}
	}else{
		var key = keyboard_key;
		var mouse = mouse_button;
		
		if (searching_for_input_wait > 0){
			searching_for_input_wait --;
		}else if (in_settings_controls){
			if (!searching_for_input_mouse){
				if (key != 0){
					option_setting_controls_value[selected] = key;
					global.game_option[| option_setting_controls_edit[selected]] = option_setting_controls_value[selected];
					scr_options_refresh();
					press_break = 5;
					searching_for_input = false;
				}
			}else{
				if (mouse != 0){
					option_setting_controls_value[selected] = mouse;
					global.game_option[| option_setting_controls_edit[selected]] = option_setting_controls_value[selected];
					scr_options_refresh();
					press_break = 5;
					searching_for_input = false;
				}
			}
		}
	}
}