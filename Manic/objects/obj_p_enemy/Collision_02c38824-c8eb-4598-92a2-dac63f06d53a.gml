var mult = scr_get_blood_mult();

if (object_index == obj_enemy_0) || (object_index == obj_enemy_2) || (object_index == obj_enemy_3){
	if (cutscene_prop){
		return;
	}
	
	if (object_index == obj_enemy_0){
		if (type == Enemy0_Type.TrainBoss){
			return;
		}
	}
}

if (health_current > 0) && (other.spd > 0.1){
	scr_pawn_damage(health_max, 2 * knockback_multiplier, random(360), 4);
	part_particles_create(global.ps_front, x, y, global.pt_blood_0, 3 * mult);
	part_particles_create(global.ps_bottom, x, y + 6, global.pt_blood_1, 10 * mult);
	part_particles_create(global.ps_bottom, x, y + 6, global.pt_blood_3, 3 * mult);
	part_particles_create(global.ps_bottom, x, y + 6, global.pt_gore_0, 3 * mult);
	scr_effect_object(other.x, other.y, obj_ef_blood, spr_ef_blood_0, 0, 1);
	scr_effect_object(x + random_range(-6, 6), y + random_range(-6, 6), obj_ef_blood, spr_ef_blood_1, 0, 1);
	scr_sound_play(choose(snd_character_hit_0, snd_character_hit_1), false, 0.8, 1.2);

	repeat(8){
		instance_create(x + random_range(-3, 3), y + random_range(-6, 6), obj_ef_bloodspurt);
	}

	part_type_direction(global.pt_blood_5, 0, 360, 0, 0);
	part_type_speed(global.pt_blood_5, 3, 5, -0.2, 0);
	repeat(20)part_particles_create(global.ps_bottom, x + random_range(-8, 8), y + random_range(-8, 8), global.pt_blood_5, 1);
}