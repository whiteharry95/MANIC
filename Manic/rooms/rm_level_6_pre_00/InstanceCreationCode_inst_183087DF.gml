index = 52;
moveto_dir = 1;
moveto_room = rm_level_6_00;
moveto_level = Level.TrainStation;
moveto_type = 0;

if (global.game_is_playthrough) && (scr_player_has_companion(obj_companion_0)){
	instance_destroy();
}