///@param increment
///@param to
var old_weapon, to = -1, increment = argument[0];
global.weapon_slotprevious = global.weapon_slotcurrent;

if (argument_count > 1){
	to = argument[1];
}

if (global.weapon_slot_standalone == -1){
	if (global.weapon_slot[global.weapon_slotcurrent] != -1){
	    old_weapon = global.weapon_object[global.weapon_slot[global.weapon_slotcurrent]];
	}
	
	var slotcount = global.weapon_slotmax - 1;
	
	// Change the current slot to the next.
	if (to == -1){
		if (increment){
			if (global.weapon_slotcurrent < slotcount){
				global.weapon_slotcurrent ++;
			}else{
				global.weapon_slotcurrent = 0;
			}
		}else{
			if (global.weapon_slotcurrent > 0){
				global.weapon_slotcurrent --;
			}else{
				global.weapon_slotcurrent = slotcount;
			}
		}
	}else{
		global.weapon_slotcurrent = to;
	}
	
	// New Weapon Setup
	var new_weaponslot = global.weapon_slot[global.weapon_slotcurrent]; // Get the new weapon that has just been switched to.
	
	if (new_weaponslot != -1){
	    if (!instance_exists(global.weapon_object[new_weaponslot])){
	        var wep = instance_create(obj_player.x, obj_player.y, global.weapon_object[new_weaponslot]); // Create the new weapon object.
			wep.image_angle = point_direction(global.player_position_x, global.player_position_y, scr_input_get_mouse_x(), scr_input_get_mouse_y());
			with(wep){
				event_perform(ev_step_end, 0);
			}
		}
	}
}else{
	if (global.weapon_slot[global.weapon_slotcurrent] != -1){
		old_weapon = global.weapon_object[global.weapon_slot[global.weapon_slotcurrent]];
	}else if (global.weapon_default != -1){
		old_weapon = global.weapon_object[global.weapon_default];
	}else{
		old_weapon = noone;
	}
}

// Replacing Old Weapon
var old_weaponslot = global.weapon_slot[global.weapon_slotprevious]; // Get the weapon that was previously selected.

if (global.weapon_slot_standalone != -1){
	old_weaponslot = global.weapon_slot[global.weapon_slotcurrent];
}

if (old_weaponslot != -1){
    if (instance_exists(old_weapon)){
        instance_destroy(global.weapon_object[old_weaponslot]);
    }
}else if (global.weapon_default != -1){
	if (instance_exists(global.weapon_object[global.weapon_default])){
        instance_destroy(global.weapon_object[global.weapon_default]);
    }
}

obj_controller_ui.weaponammo_x = 0;