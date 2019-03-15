// Setup
var weaponalength = array_length_1d(global.weapon_slot);

playerhp_alpha = 0;

playerhit_alpha = 0;
playerhit_colour = c_maroon;

vignette_flash_alpha = 0;
vignette_flash_alpha_speed = 0;
vignette_flash_colour = c_white;

grain_alpha = 0;

areacleared_alpha = 0;
areacleared_time = 0;

weaponammo_scale = 1;
weaponammo_scaleTo = 1;

ui_alpha = 1;

redtint_alpha = 0;
redtint_alphato = 0;

pause_text_update = false;
pause_text_alpha = 0;
pause_selected = 0;
pause_has_selected = false;
pause_has_selected_time = 0;
pause_selectoption[0] = "Resume";
pause_selectoption[1] = "Restart Section";
pause_selectoption[2] = "Exit to Titlescreen";
pause_selectedmax = array_length_1d(pause_selectoption);

game_opening_intro = true;
game_opening_intro_speed = 1.1;
game_opening_intro_alpha = 4.7;
game_opening_intro_text_alpha = -0.25;
game_opening_intro_text_stage = 0;
game_opening_intro_text_time = 60 * 4;

screen_fade_opening = 1.15;

game_ending_screen = false;
game_ending_screen_alpha = 0;
game_ending_screen_text_alpha = 0;

area_next_fade = false;
area_next_alpha = 0;
area_next_alpha_speed = 0.01;
area_next_room = noone;

score_current = global.game_score;
score_scale = 1;
score_shake = 0;
score_text = "";
score_text_offset = 0;
score_text_time = 0;
score_text_alpha = 0;

leveltext_alpha = 0;
leveltext_text = "";
leveltext_other = false;
leveltext_time = 0;
var levels = array_length_1d(global.level_name);
for(var i = 0; i < levels; i++){
	if (room == global.level_room[i]){
		leveltext_time = 60 * 3.5;
	}
}

weaponslot_shake = 0;
for (var i = 0; i < weaponalength; i++){
    weaponslot_scale[i]=0;
}

blackbar_draw = false;
blackbar_sizereal = 0;
blackbar_size = 185;

screenblend_draw = false;
screenblend_alpha = 0;
screenblend_colour = c_white;
screenblend_speed = 0.1;
screenblend_endalpha = 0.6;

rank_display_draw = false;
rank_display_alpha = 0;

control_indicate = false;
control_indicate_text = "";
control_indicate_x = 0;

pausedialogue = false;
pausedialogue_alpha = 0;
pausedialogue_type = 1;
pausedialogue_time = 0;
pausedialogue_option_selected = 0;
pausedialogue_option_max = 0;
pausedialogue_type_text = "I haven't been given dialogue yet!";
pausedialogue_type_option[0] = -1;
pausedialogue_type_option_cutscene[0] = -1;
pausedialogue_type_option_traingoto[0] = -1;
pausedialogue_type_option_trainroom[0] = -1;
pausedialogue_type_option_trainstart_type[0] = -1;

sprite_index = noone;