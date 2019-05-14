if (!dec_set){
	depth_offset = sprite_height + 20;
	
	var declist = ds_list_create();
	var decnum = collision_rectangle_list(x + 6, y + 6, x + (16 * image_xscale) - 6, y + (16 * image_yscale) - 6, obj_p_decorative, false, true, declist, false);
	
	if (decnum > 0){
		for(var i = 0; i < decnum; i ++){
			var inst = declist[| i];
			inst.ceiling = id;
			inst.depth_offset = inst.y + depth_offset + 10;
		}
	}
	
	ds_list_destroy(declist);
	dec_set = true;
}