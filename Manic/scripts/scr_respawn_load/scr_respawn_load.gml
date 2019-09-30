global.game_combat_state = CombatState.Idle;
global.weapon_slot_standalone = -1;
scr_weapon_list();

if (global.level_current == Level.Prologue){
	global.weapon_slot[0] = -1;
	global.weapon_slotammo[0] = -1;
	global.weapon_slotscale[0] = 1;
}

if (instance_exists(obj_pawn_other_train_0)){
	instance_destroy(obj_pawn_other_train_0);
}

if (global.boss_current != -1){
	var music = global.boss_music[global.boss_current];
	
	if (music != noone){
		if (audio_is_playing(music)){
			audio_sound_gain(music, 0, 1200);
		}
	}
}

global.player_health_current = global.player_health_max;
global.weapon_slotcurrent = 0;

global.boss_current = -1;

if (global.player_is_respawning) && (global.checkpoint_room == noone){
	var roomto = global.level_room[global.level_current];
	
	if (roomto == room){
		room_restart();
	}else{
		room_goto(roomto);
	}
}else{
	room_goto(global.checkpoint_room);
	
	var slotcount = global.weapon_slotmax;
	for(var i = 0; i < slotcount; i ++){
		global.weapon_slot[i] = global.checkpoint_weapon_slot[i];
		global.weapon_slotammo[i] = global.checkpoint_weapon_slotammo[i];
		global.weapon_slotquantity[i] = global.checkpoint_weapon_slotquantity[i];
	}
	
	global.checkpoint_goto = true;
	global.game_level_opening_type = global.checkpoint_starttype;
}