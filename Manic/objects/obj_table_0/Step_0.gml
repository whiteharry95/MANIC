if (global.game_pause){
	image_speed = 0;
	exit;
}

if (fire){
	sprite_index = spr_table_destroyed_0;
	image_speed = 1;
}