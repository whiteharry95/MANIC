gpu_set_fog(true, c_black, 0, 0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * 0.15);
gpu_set_fog(false, c_black, 0, 0);

var offset = wave(0, 2, 1.5, 0, false);
draw_sprite_ext(sprite_index, image_index, x, y - 1 - offset, image_xscale, image_yscale, image_angle, image_blend, image_alpha);