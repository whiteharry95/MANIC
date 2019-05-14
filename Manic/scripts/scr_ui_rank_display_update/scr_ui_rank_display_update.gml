if (rank_display_draw){
	var length = array_length_1d(rank_alpha);

	for(var i = 0; i < length; i ++){
	
		if (rank_display[i]){
			if (rank_alpha[i] < 1){
				rank_alpha[i] += 0.05;
			}
		
			rank_alpha[i] = max(rank_alpha[i], 0);
		}
	}

	if (rank_time > 0){
		rank_time--;
	}else{
	
		var alldrawn = true;
	
		for(var i = 0; i < length; i ++){
	
			if (!rank_display[i]){
				rank_display[i] = true;
				alldrawn = false;
				break;
			}
		}
	
		if (alldrawn){
			rank_end_display = true;
		}
	
		rank_time = 40;
	}

	if (rank_end_display){
		if (rank_end_alpha < 1){
			rank_end_alpha += 0.05;
		}
		
		if (keyboard_check_pressed(vk_enter)) && (!instance_exists(obj_ef_flash)){
			//if ((gamestate == GameState.Developer) || (global.game_playthrough)) && (gamestate != GameState.Public){
			//	//scr_effect_flash_script(0.015, 1, c_black, scr_trigger_1);
			//}
		}
	}else{
		rank = scr_get_rank(rank_score[length - 1]);
	}

	if (rank_display_alpha < 1){
		rank_display_alpha += 0.1;
	}
}