///@param radius
///@param include_fly
var radius = argument0;
var include_fly = argument1;

var px = global.player_position_x;
var py = global.player_position_y;

var elist = ds_list_create();
var ecount = collision_circle_list(px, py, radius, obj_p_enemy, false, false, elist, false);
var count = 0;

if (!include_fly){
	for(var e = 0; e < ecount; e ++){
		var enemy = elist[| e];
		
		if (enemy.object_index != obj_enemy_1){
			count ++;
		}
	}
}else{
	count = ecount;
}

ds_list_destroy(elist);

return count;