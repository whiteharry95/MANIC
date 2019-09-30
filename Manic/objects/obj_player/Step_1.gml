global.player_health_previous = global.player_health_current;

if (!upgrades_set){
	scr_player_upgrade_refresh();
	
	var upgradecount = array_length_1d(global.upgrade_name);
	for(var i = 0; i < upgradecount; i ++){
		if (global.upgrade_equipped[i]){
			surrounding_light -= surrounding_light_upgradedec;
		}
	}
	
	surrounding_light_to = surrounding_light;
	upgrades_set = true;
}

if (!weapon_default_set){
	var def = PlayerWeapon.Knife;
	
	if (global.level_current >= Level.WinterTown){
		def = PlayerWeapon.Bayonet;
	}
	
	global.weapon_default = def;
	
	weapon_default_set = true;
}