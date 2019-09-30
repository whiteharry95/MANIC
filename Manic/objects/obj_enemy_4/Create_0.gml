pawn = PawnType.Enemy;
blend = -1;
scale = random_range(1, 1.1);
scale_mult_x = 1;
scale_mult_y = 1;
destroy = false;

mypath = path_add(); path_set_kind(mypath, 1); path_set_precision(mypath, 8)
prevpath = noone;

hitbox = instance_create_layer(x, y, "Hitbox", obj_enemy_hitbox_0);
hitbox.sprite_index = spr_maggot_hitbox_0;
hitbox.owner = id;

damage = 1;
strength = 0.5;

whiteflash_alpha = 0;
whiteflash_alphadec = 0.075;
mylight = noone;

companion_attack_time = 0;
companion_attack_time_max = 90;
companion_attack_break = 0;

contact_attack_ready_time = 30;

mucus_release_time = random_range(60 * 4, 60 * 8);
mucus_is_releasing = false;
mucus_is_releasing_startbreak = 0;

burn = false;
burn_x = x;
burn_y = y;
burn_start = false;
burn_time = -1;
burn_cycle = 3;
burn_sound = noone;

poison = false;
poison_time = 0;
poison_start = false;

bleed = false;
bleed_time = 0;

headless = false; 
headless_x = x;
headless_y = y;
headless_image = 0;

barrel_pause_time = random(40);
barrel_pause_break = 0;

defense = 0;

move_speed = 0;
move_speed_real = 0;
move_speed_offset = random_range(1.2, 1.4);
move_x_to = x;
move_y_to = y;
move_away_time = 20 + random_range(-10, 10);

i_time = 0;
i_blend_time = 0;

knockback_speed = 0;
knockback_direction = 0;
knockback_multiplier = 0.1;

cutscene_prop = false;
in_cutscene = false;

health_max = 15;
health_current = health_max;
health_alpha = 0;
health_scale = 1;
health_flash = 0;

target = obj_player;
flies_created = false;

var feet = instance_create(x, y, obj_feetbox_0);
feet.owner = id;

fly[0] = noone; fly[1] = noone; fly[2] = noone; fly[3] = noone;
image_xscale = scale;
image_yscale = scale;

if (global.level_current >= Level.IntoTheCity){
	knockback_multiplier *= 0.925;
	move_speed_offset *= 1.2;
}