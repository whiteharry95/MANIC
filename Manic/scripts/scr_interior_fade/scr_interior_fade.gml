if (fade_owner == noone){
	fade_owner = instance_place(x + 1, y + 1, obj_interior_fade);
}

if (fade_owner != noone){
	if (fade_owner.fade){
		if (image_alpha > 0){
			image_alpha -= 0.05;
		}
	}else{
		if (image_alpha < 1){
			image_alpha += 0.05;
		}
	}
}