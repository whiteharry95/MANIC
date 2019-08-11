if (global.game_pause){
	return;
}

// Flash
flash -= 0.15;
flash = clamp(flash, 0, 1);

// Motion
if (spd > 0.375){
	if (!place_meeting(x + lengthdir_x(spd + 3, dir), y + lengthdir_y(spd + 3, dir), obj_p_pawn)){
		x += lengthdir_x(spd, dir);
		y += lengthdir_y(spd, dir);
	}
	
	spd *= 0.9;
}else{
	if (point_distance(x, y, basex, basey) > 1){
		var dirto = point_direction(x, y, basex, basey);
		if (!place_meeting(x + lengthdir_x(3, dirto), y + lengthdir_y(3, dirto), obj_p_pawn)){
			x += lengthdir_x(abs(basex - x) * 0.1, dirto);
			y += lengthdir_y(abs(basey - y) * 0.1, dirto);
		}
	}
}

// Hit Control
if (hit <= 0){
	death = true;
}

if (hit_time > 0){
	hit_time--;
}

// Object Death
if (death){
	scr_env_destroy(spr_barrel_0_break);
	
	scr_weapon_ammo_spawn(2, 6, 5, x, y + 6);

	if (random(3) < 1){
		instance_create(x, y + 8, obj_health_pack_0);
	}

	if (global.level_current >= Level.UndergroundBunker){
		if (random(5) < 1){
			var weapon = instance_create(x, y + 6, obj_weapondrop);
			weapon.index = choose(PlayerWeapon.Grenade);
			weapon.angle = random_range(20, 40);
			weapon.pack = true;
			weapon.quantity = random_range(2, 3);
		}
	}
}