if (!global.game_objective_set){
	global.game_objective_current = Objectives.KillEnemies;
	
	global.objective_counter[global.game_objective_current] = 0;
	global.objective_counter_max[global.game_objective_current] = 70;
	
	global.game_objective_complete = false;
	global.game_objective_set = true;
}