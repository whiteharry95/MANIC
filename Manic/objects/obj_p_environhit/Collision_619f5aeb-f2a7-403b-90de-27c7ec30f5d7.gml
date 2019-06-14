if (object_index == obj_barrel_2) || (object_index == obj_barrel_3){
	explode = true;
}else{
	if (hit_time <= 0){
		flash = 0.8;
		
		spd = 0.35;
		dir = other.dir;
		
		hit -= other.damage * 2;
		hit_time = 20;
	
		if (object_index == obj_prisonbar_3){
			scr_sound_play_distance_pitch(snd_object_metal_hit_0, false, 120, 0.8, 1.2);
			scr_effect_object(x + random_range(-13, 13), y + random_range(-6, 6), obj_ef_blood, spr_ef_metal_0, 0, 1);
		}else{
			scr_sound_play_distance_pitch(snd_object_box_hit_0, false, 120, 0.8, 1.2);
			part_type_direction(global.pt_wood_1, (other.dir - 180) - 30, (other.dir - 180) + 30, 0, 0);
			repeat(7) part_particles_create(global.ps_bottom, x + random_range(-8, 8), y + random_range(-8, 8), global.pt_wood_1, 2);
		}
	}
}

instance_destroy(other);