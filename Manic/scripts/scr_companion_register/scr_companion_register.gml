///@param obj
var obj = argument0;
var height = ds_grid_height(global.player_companions);
ds_grid_sort(global.player_companions, 0, false);

for(var i = 0; i < height; i ++){
	if (global.player_companions[# 0, i] == -1){
		global.player_companions[# 0, i] = obj;
		return;
	}else if (global.player_companions[# 0, i] == obj){
		return;
	}
}