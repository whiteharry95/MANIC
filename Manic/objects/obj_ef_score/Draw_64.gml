var xx = (x - camera_get_view_x(view_camera[0])) * gui_scale_x;
var yy = (y - camera_get_view_y(view_camera[0])) * gui_scale_y;
var scale_offset = wave(0.8, 1.2, 0.8, 0);

draw_set_font(fnt_cambria_2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
scr_text_transformed(xx, yy, string(floor(num_current)), c_white,
clamp(scale, 0, 1) * scale_offset,
clamp(scale, 0, 1) * scale_offset, 0);
draw_set_valign(fa_top);