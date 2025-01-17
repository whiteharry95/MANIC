if (global.cutscene_current != -1) || (global.game_pause){
	return;
}

var inst = other;
var mult = inst.creator == obj_p_player ? scr_get_blood_mult() : 1;

with(owner){
	if (inst.enemy){
		return;
	}

	if (object_index == obj_enemy_1){
		if (owner != obj_player) && (owner != noone){
			return;
		}
	}

	if (cutscene_prop){
		return;
	}

	if (i_time <= 0){
		scr_pawn_damage(max(inst.damage - defense, 1), inst.strength, inst.dir, 3);
		
		if (inst.burn) && (object_index != obj_enemy_1) burn = true;
	
		if (inst.creator == obj_player){
			scr_mouse_cross();
		}
		
		if (object_index != obj_enemy_1) && (object_index != obj_enemy_3) && (object_index != obj_giantturret) && (object_index != obj_giantturret_flamethrower){
			part_particles_create(global.ps_front, inst.x, inst.y, global.pt_blood_0, 3 * mult);
			part_particles_create(global.ps_bottom, x, y + 6, global.pt_blood_1, 10 * mult);
			part_particles_create(global.ps_bottom, x, y + 6, global.pt_blood_3, 3 * mult);
		    part_particles_create(global.ps_bottom, x, y + 6, global.pt_gore_0, 3 * mult);
			part_particles_create(global.ps_front, x, y + 6, global.pt_fire_2, 4);
			part_type_direction(global.pt_blood_5, inst.dir - 20, inst.dir + 20, 0, 0);
			part_type_speed(global.pt_blood_5, 2.75, 3.75, -0.15, 0);
			repeat(6)part_particles_create(global.ps_bottom, inst.x + random_range(-8, 8), inst.y + random_range(-8, 8), global.pt_blood_5, 1);
			scr_effect_object(inst.x, inst.y, obj_ef_blood, spr_ef_blood_0, 0, 1);
			scr_effect_object(inst.x + random_range(-6, 6), inst.y + random_range(-6, 6), obj_ef_blood, spr_ef_blood_1, 0, 1);
		
			repeat(7){
				var spurt = instance_create(x + random_range(-5, 5), y + random_range(-8, 8), obj_ef_bloodspurt);
				spurt.dir = inst.dir + random_range(-38, 38);
			}
		
			repeat(2){
				var gore = instance_create(x, y, obj_ef_gore);
				gore.dir = inst.dir + random_range(-20, 20);
			}
		}
	
		if (object_index == obj_enemy_3) || (object_index == obj_giantturret) || (object_index == obj_giantturret_flamethrower){
			scr_sound_play(snd_object_metal_hit_0, false, 0.8, 1.2);
			scr_effect_object(inst.x, inst.y, obj_ef_blood, spr_ef_metal_0, 0, 1);
		}else{
			scr_sound_play(choose(snd_character_hit_0, snd_character_hit_1), false, 0.8, 1.2);
		}
	}

	inst.deffect = true;
	instance_destroy(inst);
}