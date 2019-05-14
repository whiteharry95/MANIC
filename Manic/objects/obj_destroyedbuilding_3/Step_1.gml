if (!dec_set){
	depth_offset = sprite_height + 100;
	
	var declist = ds_list_create();
	var decnum = collision_rectangle_list(x - 4, y - 4, x + sprite_width + 4, y + sprite_height + 4, obj_p_decorative, false, true, declist, false);
	
	if (decnum > 0){
		for(var i = 0; i < decnum; i ++){
			var inst = declist[| i];
			inst.ceiling = id;
			inst.depth_offset = depth_offset + 200;
		}
	}
	
	ds_list_destroy(declist);
	dec_set = true;
}