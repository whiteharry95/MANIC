pawn = PawnType.Enemy;
blend = -1;
scale = random_range(1, 1.1);
initiated = false;

hitbox = instance_create_layer(x, y, "Hitbox", obj_enemy_hitbox_0);
hitbox.sprite_index = spr_turret_hitbox_0;
hitbox.owner = id;

damage = 1;
strength = 1;

shoot_time = 0;
shoot_buildup_time = 120;
shoot_burst_count = 0;
shoot_in_burst = false;

mylight = noone;
flash_time = 0;
light_brightness = 0.25;

burn = false;
burn_x = x;
burn_y = y;
burn_start = false;
burn_time = -1;
burn_cycle = 3;
burn_sound = noone;

poison = false;
headless = false;
bleed = false;

defense = 3;

i_time = 0;
i_blend_time = 0;

knockback_speed = 0;
knockback_direction = 0;
knockback_multiplier = 0;

dir = 0;
dir_to = dir;

cutscene_prop = false;
in_cutscene = false;

health_max = 6;
health_current = health_max;
health_alpha = 0;
health_scale = 1;
health_flash = 0;

setup = false;

target = obj_player;

fly[0] = noone; fly[1] = noone; fly[2] = noone;
image_xscale = scale;
image_yscale = scale;
image_speed = 0;

if (!scr_level_is_arena()){
	if (global.level_current >= Level.IntoTheCity){
		defense ++;
	}
}