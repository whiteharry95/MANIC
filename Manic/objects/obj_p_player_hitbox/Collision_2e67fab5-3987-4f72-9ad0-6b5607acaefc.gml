var inst = other;

with(owner){
	if (object_index == obj_companion_0){
		return;
	}

	if (object_index != obj_player){
		if (!inst.damage_companion){
			return;
		}
	}else{
		if (state == scr_player_dash){
			return;
		}
	}

	if (inst.time > 2) && (!inst.damage_enemy){
		inst.explode = true;
		inst.spd = 0;
	}
}