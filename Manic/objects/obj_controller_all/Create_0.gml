global.game_option = 0;
global.pers_runthrough = false;
global.pers_runthrough_pre = false;

gamepad_input_check_disconnected_time = 0;

camera_resize_w = 0;
camera_resize_h = 0;
camera_resize_time = -1;

gui_resize_w = 0;
gui_resize_h = 0;
gui_resize_time = -1;

window_resize_w = 0;
window_resize_h = 0;
window_resize_time = -1;

indicate_text = "";
indicate_text_time = 0;
indicate_text_time_max = 90;
indicate_text_alpha = 0;

show_ui = true;

app_surf_refresh_time = -1;
app_surf_refresh_w = 0;
app_surf_refresh_h = 0;

maximise_time = -1;
minimise_time = -1;

center_window_time = 2;

scr_part_setup();
scr_options_init();
scr_options_refresh(true);
scr_update_real_volumes();

gamepad_check_break = 15;

camera_get_x1 = camera_get_view_x(view_camera[0]);
camera_get_y1 = camera_get_view_y(view_camera[0]);
camera_get_x2 = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]);
camera_get_y2 = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]);

ds_depth_grid_height = 900;
ds_depth_grid = ds_grid_create(2, ds_depth_grid_height);
ds_depth_counter = 0;

full = 0;
full_autoswitch = false;
part = 0;

option_refresh = false;

room_pers_clear = false;
room_pers_clear_at = 0;
room_pers_clear_min = 0;
room_pers_clear_max = 0;
room_pers_clear_original = noone;
room_pers_runthrough_turnoff = false;

cutscene_previous = -1;

input_break = 0;

debug = false;
sprite_index = noone;