if (component_spawn){
	var comp, compcount = 8;
	
	switch(type){
		case 0:
			sprite_index = spr_train_0_part_2;
			break;
		
		case 1:
			sprite_index = spr_train_1_part_2;
			break;
	}
	
	for(var i = 1; i < compcount + 1; i ++){
		comp = instance_create_layer(x + ((i * 112) * -dir), y, "Trains", obj_pawn_other_train_0);
		comp.spd = spd;
		comp.dir = dir;
		comp.type = type;
		
		if (i == floor(compcount / 2)){
			comp.sound_handler = true;
		}
		
		if (i == compcount){
			switch(type){
				case 0:
					comp.sprite_index = spr_train_0_part_1;
					break;
				
				case 1:
					comp.sprite_index = spr_train_1_part_1;
					break;
			}
		}
		
		comp.image_speed = image_speed;
		comp.image_index = image_index;
	}
	
	mylight = instance_create_layer(x + (53 * sign(image_xscale)), y, "Lights", obj_pawn_other_train_light);
	
	hitbox = instance_create_layer(x, y, "Hitbox", obj_train_hitbox_0);
	hitbox.owner = id;
	
	component_spawn = false;
}

if (!sprite_set){
	if (sprite_index == spr_train_0_part_0){
		switch(type){
			case 1:
				sprite_index = spr_train_1_part_0;
				break;
		}
	}
	
	sprite_set = true;
}