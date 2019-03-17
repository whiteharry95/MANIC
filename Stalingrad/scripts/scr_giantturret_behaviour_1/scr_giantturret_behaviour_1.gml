var xpos, ypos;
target = global.player;

if (instance_exists(target)){
	
	// Shooting
	if (attack == 0){
		if (shoot_time > 0){
			shoot_time --;
		}else{
			shoot_dir = point_direction(x, y, global.player.x, global.player.y);
			xpos = x + lengthdir_x(22, shoot_dir);
			ypos = y + lengthdir_y(22, shoot_dir);
			
			scr_effect_screenshake(2);
			scr_sound_play(snd_weapon_shoot_0, false, 0.8, 1.2);
			light_brightness = 8;
			
			part_type_direction(global.pt_flash_0, shoot_dir - 17, shoot_dir + 17, 0, 0);
			part_particles_create(global.ps_front, xpos + random_range(-3, 3), ypos + random_range(-3, 3), global.pt_flash_0, 1);
	        part_type_direction(global.pt_smoke_5, shoot_dir - 17, shoot_dir + 17, 0, 0);
			part_particles_create(global.ps_front, xpos + lengthdir_x(5, shoot_dir) + random_range(-3, 3), ypos + lengthdir_y(5, shoot_dir) + random_range(-3, 3), global.pt_smoke_5, 1);
			
		    var bullet = instance_create(xpos, ypos, obj_proj_0);
			bullet.dir = shoot_dir;
		    bullet.image_angle = shoot_dir;
			bullet.spd = 12;
			bullet.damage = 1;
			bullet.strength = 1.25;
			bullet.enemy = true;
			bullet.creator = id;
			
			if (shoot_burst < 2){
				shoot_burst ++;
				shoot_time = 6;
			}else{
				shoot_burst = 0;
				shoot_time = 70;
			}
		}
		
	// Flamethrower
	}else if (attack == 1){
		attack_time_max = 60 * 15;
		
		if (flamethrower_angle_sign == 1){
			if (flamethrower_angle < 90){
				flamethrower_angle += 0.9;
				flamethrower_angle_wait = 80;
			}else{
				if (flamethrower_angle_wait > 0){
					flamethrower_angle_wait --;
				}else{
					flamethrower_angle_sign = -1;
				}
			}
		}else{
			if (flamethrower_angle > 0){
				flamethrower_angle -= 0.9;
				flamethrower_angle_wait = 80;
			}else{
				if (flamethrower_angle_wait > 0){
					flamethrower_angle_wait --;
				}else{
					flamethrower_angle_sign = 1;
				}
			}
		}
		
		if (flamethrower_time > 0){
			flamethrower_time --;
		}else{
			var has_flamethrowers = false;
			for(var i = 0; i < 4; i++){
				if (instance_exists(flamethrower[i])){
					has_flamethrowers  = true;
					flamethrower[i].shoot = true;
				}
			}
			
			if (!has_flamethrowers){
				attack_time = attack_time_max;
			}
			
			flamethrower_time = 6;
		}
		
	// Break
	}else if (attack == 2){
		attack_time_max = 60 * 2.5;
	}
	
	if (attack_time < attack_time_max){
		attack_time ++;
	}else{
		if (attack < 2){
			attack ++;
		}else{
			attack = 0;
		}
		
		if (attack == 2){
			var drop = instance_create(x, y, obj_weapondrop);
			drop.index = choose(PlayerWeapon.Katana, PlayerWeapon.Spear, PlayerWeapon.AssaultRifle, PlayerWeapon.QuickGun);
			drop.spd = 9;
			drop.dir = random(360);
			drop.angle = 0;
		}
		
		shoot_time = 30;
		flamethrower_angle = 0;
		flamethrower_angle_wait = 80;
		flamethrower_time = 30;
		attack_time = 0;
	}
}