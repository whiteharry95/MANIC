if (global.pers_runthrough){
	instance_deactivate_object(object_index);
}

state = scr_player_move;
scr_player_setup();

img_index = 0;
img_speed = 0;

hspd = 0;
vspd = 0;

image_speed = 0;
image_index = 0;