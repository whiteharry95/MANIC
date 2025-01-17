// Light
if (!instance_exists(mylight)){
	mylight = instance_create_layer(x, y, "Lights", obj_upgrade_pickup_light);
}

mylight.x = x;
mylight.y = y;

if (index == PlayerUpgrade.HeadLight){
	mylight.Light_Range = 120;
}

// Particles
if (!global.game_pause){
	if (random(25) < 1){
		part_particles_create(global.ps_front, x + random_range(-4, 4), y + random_range(-4, 4), global.pt_glow_0, 1);
	}
}

// Pickup
if (instance_exists(obj_player)){
    if (pickup){
        instance_destroy();
		
		scr_sound_play(snd_weapon_pickup_upgrade, false, 0.8, 1.2);
		scr_effect_screenshake(1);
		scr_upgrade_add(index);
		
		if (index == PlayerUpgrade.Chestplate){
			global.player_health_max = 12;
			global.player_health_current = global.player_health_max;
		}
		
		scr_header_display_text(global.upgrade_name[index], global.upgrade_description[index], 60 * 7);
    }
}