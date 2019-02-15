var cart_dir = 0, cart_dist = 0;

if (sprite_index != spr_pawn_minecart_0) && (sprite_index != spr_pawn_minecart_1){
	sprite_index = spr_pawn_minecart_0;
}

if (mouse_x > x){
	image_xscale = 1;
}else{
	image_xscale = -1;
}

if (keyboard_check(ord("D"))){
	if (minecart_speed < 2.5){
		minecart_speed += 0.1;
	}
}else if (keyboard_check(ord("A"))){
	if (minecart_speed > -2.5){
		minecart_speed -= 0.1;
	}
}else{
	if (abs(minecart_speed) > 0){
		minecart_speed += -0.025 * sign(minecart_speed);
	}
}

if (minecart_speed != 0) || (minecart_speed != 0){
	image_speed = 1;
}else{
	image_speed = 0;
}

minecart.trail_current = clamp(minecart.trail_current, 0, array_length_1d(minecart.trail_x) - 1);
cart_dir = point_direction(x, y, minecart.trail_x[minecart.trail_current], minecart.trail_y[minecart.trail_current]);
cart_dist = point_distance(x, y, minecart.trail_x[minecart.trail_current], minecart.trail_y[minecart.trail_current]);

if (cart_dist < 4){
	if (minecart_speed > 0){
		if (minecart.trail_current < array_length_1d(minecart.trail_x) - 1){
			minecart.trail_current ++;
		}else{
			minecart.trail_current = 0;
		}
	}else if (minecart_speed < 0){
		if (minecart.trail_current > 0){
			minecart.trail_current --;
		}else{
			minecart.trail_current = array_length_1d(minecart.trail_x) - 1;
		}
	}
	
	minecart.trail_current = clamp(minecart.trail_current, 0, array_length_1d(minecart.trail_x) - 1);
	cart_dir = point_direction(x, y, minecart.trail_x[minecart.trail_current], minecart.trail_y[minecart.trail_current]);
	cart_dist = point_distance(x, y, minecart.trail_x[minecart.trail_current], minecart.trail_y[minecart.trail_current]);
}

if ((cart_dir > 90 - 20) && (cart_dir < 90 + 20)) || ((cart_dir > 270 - 20) && (cart_dir < 270 + 20)){
	sprite_index = spr_pawn_minecart_1;
}else{
	sprite_index = spr_pawn_minecart_0;
}

x += lengthdir_x(abs(minecart_speed), cart_dir);
y += lengthdir_y(abs(minecart_speed), cart_dir);