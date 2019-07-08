// Movement
spd_build = 0.19//0.32;
spd_max = 1.9;
spd_offset = 1;
spd_offset_change = 0.05;
move_time = 0;
flash_time = 0;
xaxis = 0;
yaxis = 0;
len = 0;
dir = 0;
canmove = true;

// Hitbox
hitbox = instance_create(x, y, obj_player_hitbox_0);
hitbox.sprite_index = spr_human_hitbox_0;
hitbox.owner = id;

// Light
flashlight_direction = 0;
flashlight_alpha = 0;

// White Flash
whiteflash_alpha = 0;
whiteflash_alphadec = 0.075;

// Externally Controlled Movement
move_x_to = -1;
move_y_to = -1;
move_extSpd = -1;

// Dash
dash_length = 0;
dash_length_current = 0;
dash_speed = 0;
dash_after_speed = 0;
dash_direction = 0;
dash_time = 30;
dash_time_short = 0;
dash_count = 0;

// Footstep
footstep_sound = -1;
footstep_time = 0;

// Health
health_alpha = 0;
health_scale = 1;

// Stamina
global.player_stamina_max = 100;
global.player_stamina_current = global.player_stamina_max;
global.player_stamina_break = 0;
global.player_stamina_active = false;

// Knockback
knockback = false;
knockback_speed = 0;
knockback_direction = 0;

// Burn
burn = false;
burn_time = -1;
burn_cycle_amount = 0;
burn_sound = noone;
burn_sound_paused = false;

// Poison
poison = false;
poison_time = -1;
poison_cycle_amount = 0;

// Blend and Invincibility
i_blend_time = 0;
i_time = 0;
i_time_alpha = 0;
i_time_flicker = false;
i_time_flicker_time = 0;

// Colliders
var feet = instance_create(x, y, obj_feetbox_0);
feet.owner = id;

// Upgrades
var upgradecount = array_length_1d(global.upgrade_name);
for(var i = 0; i < upgradecount; i ++){
	global.upgrade_equipped[i] = false;
	upgrade_has[i] = false;
}

if (global.game_is_playthrough) || (room == rm_prologue_00){
	var upgradecount = array_length_1d(global.upgrade_name);
	for(var i = 0; i < upgradecount; i ++){
		if (global.game_save_upgrade_unlocked[i]){
			scr_upgrade_add(i);
		}
	}
}else{
	if (global.level_current >= Level.UndergroundBunker){
		scr_upgrade_add(PlayerUpgrade.Backpack);
	}
	
	if (global.level_current >= Level.HumanPrison){
		scr_upgrade_add(PlayerUpgrade.RunningBoots);
	}
	
	if (global.level_current >= Level.TrainStation){
		scr_upgrade_add(PlayerUpgrade.KneePads);
	}
	
	if (global.level_current >= Level.TheCemetery){
		scr_upgrade_add(PlayerUpgrade.Chestplate);
	}
	
	if (global.level_current >= Level.DesolateVillage){
		scr_upgrade_add(PlayerUpgrade.GasMask);
	}
}

scr_player_upgrade_refresh();

// Fly
fly[0] = noone; fly[1] = noone; fly[2] = noone;

// Other
is_visible = true;

heartbeat = noone;

has_antagonist_mask = false;

minecart = noone;
minecart_dir = 0;
minecart_touching = false;
minecart_break = 0;
minecart_speed = 0;
minecart_sprite = noone;
minecart_sprite_image = 0;
in_minecart = false;