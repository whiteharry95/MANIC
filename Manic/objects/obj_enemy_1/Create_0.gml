pawn = PawnType.Enemy;
blend = -1;
flash_time = 0;
light_brightness = 0;
scale = random_range(0.675, 0.75);
destroy = false;
buzz = noone;

whiteflash_alpha = 0;
whiteflash_alphadec = 0.1;
mylight = noone;

defense = 0;

damage = 1;
strength = 0.5;
attack_ready_time = random_range(40, 60);

burn = false;
burn_x = x;
burn_y = y;
burn_start = false;
burn_time = -1;
burn_cycle = 3;
burn_sound = noone;
burn_sound_paused = false;

poison = false;
bleed = false;
bleed_time = 0;
headless = false;

move_x_to = x;
move_y_to = y;
move_time = 0;
move_speed = random_range(1.6, 2.3);

i_time = 16;
i_blend_time = 0;

knockback_speed = 0;
knockback_direction = 0;
knockback_multiplier = 1;

health_max = 2;
health_current = health_max;
health_alpha = 0;
health_scale = 1;
health_flash = 0;

owner = noone;

image_xscale = scale;
image_yscale = scale;