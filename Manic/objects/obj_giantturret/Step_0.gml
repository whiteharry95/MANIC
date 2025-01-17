if (global.cutscene_current == 55) && (in_cutscene){
	active = true;
}

if (!instance_exists(mylight)){
	mylight = instance_create_layer(x, y, "Lights", obj_giantturret_light);
}

mylight.x = x;
mylight.y = y;
mylight.Light_Intensity = max(1.55 + (clamp(flash_time, 0, 2) / 10), 1.2);
mylight.Light_Intensity *= light_brightness;

obj_controller_ui.bosshealth_value_current = health_current;
obj_controller_ui.bosshealth_value_max = health_max;

var ispaused = false;
if (global.game_pause){
	ispaused = true;
}

if (!active){
	ispaused = true;
}

if (ispaused){
	if (abs(image_xscale) != scale) || (abs(image_yscale) != scale){
		image_xscale = sign(image_xscale) * scale;
		image_yscale = scale;
	}
	
	image_speed = 0;
	return;
}

poison = false;
bleed = false;
headless = false;

scr_pawn_status_handler();

var sprev = state;

state = 0; sprite_index = spr_giantturret_idle_0;
if (health_current <= health_max * 0.75){ state = 1; sprite_index = spr_giantturret_idle_1; }
if (health_current <= health_max * 0.5)  { state = 2; sprite_index = spr_giantturret_idle_2; }
if (health_current <= health_max * 0.25){ state = 2; sprite_index = spr_giantturret_idle_3; }

if (state != sprev){
	shoot_time = 120;
	shoot_burst = 0;
	shoot_buildup_time = 0;
	flamethrower_angle = 0;
	flamethrower_angle_wait = 80;
	flamethrower_time = 30;
	attack_time = 0;
	attack = 0;
}

for(var i = 0; i < 4; i ++){
	if (instance_exists(flamethrower[i])){
		flamethrower[i].shoot = false;
	}
}

if (global.cutscene_current == -1) || (cutscene_prop){
	switch(state){
		case 0:
			scr_giantturret_behaviour_0();
			break;
	
		case 1:
			scr_giantturret_behaviour_1();
			break;
	
		case 2:
			scr_giantturret_behaviour_2();
			break;
	}
}else{
	image_speed = 0;
}

scr_pawn_update();
image_yscale = scale;