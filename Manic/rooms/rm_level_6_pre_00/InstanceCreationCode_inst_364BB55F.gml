index = 58;
destroy_on_activate = false;
deactivate_on_activate = true;
reactivate_on_death = true;

if (global.game_boss_firstantag_killed) || (!global.game_is_playthrough){
	instance_destroy();
}