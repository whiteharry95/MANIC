pawn = PawnType.Enemy;
blend = -1;
scale = 1.1;
destroy = false;
state = 0;

light_brightness = 0;
levelobj = scr_get_level_object();
mylight = instance_create(x, y, obj_thedogkeeper_light);

arena_x = 0;
arena_y = 0;
arena_width = 0;
arena_height = 0;

run_x = x;
run_y = y;
run_count = 0;

release_count = 0;
release_time = 45;
release_offset = 0;

weapon = -1;
weapon_has = false;
weapon_index = 0;

whiteflash_alpha = 0;
whiteflash_alphadec = 0.075;

burn = false;
burn_x = x;
burn_y = y;
burn_start = false;
burn_time = -1;
burn_cycle = 3;
burn_sound = noone;
burn_sound_paused = false;

poison = false;
poison_time = 0;
poison_start = false;

bleed = false;
headless = false; 

barrel_pause_time = random(40);
barrel_pause_break = 0;

defense = 0;
arm = -1;

dog_count = 3;
dogs_downed = false;
dogs_alive = 3;
dog[0] = instance_create(x, y, obj_thedogkeeper_dog);
dog[0].keeper = id;
dog[0].leash_length = 80;
dog[0].leash_offset = -25;

dog[1] = instance_create(x, y, obj_thedogkeeper_dog);
dog[1].keeper = id;
dog[1].leash_length = 100;
dog[1].leash_offset = 0;

dog[2] = instance_create(x, y, obj_thedogkeeper_dog);
dog[2].keeper = id;
dog[2].leash_length = 80;
dog[2].leash_offset = 25;

move_speed = 0;
move_speed_real = 0;
move_speed_offset = random_range(0.75, 0.9);
move_xTo = x;
move_yTo = y;
move_dir = 0;
move_time = 60;

i_time = 0;
i_blend_time = 0;
flash_time = 0;

knockback_speed = 0;
knockback_direction = 0;
knockback_resist = 0;

health_max = 35;
health_current = health_max;
health_alpha = 0;
health_scale = 1;

target = obj_player;

var feet = instance_create(x, y, obj_feetbox_0);
feet.owner = id;

fly[0] = noone; fly[1] = noone; fly[2] = noone;
image_xscale = scale;
image_yscale = scale;