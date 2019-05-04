scr_position_view();

if (!global.game_pause){
	
	// Dust
	if (random(6) < 1) part_particles_create(global.ps_front, random_range(camera_get_view_x(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])), random_range(camera_get_view_y(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])), global.pt_dust_3, 1);
	if (random(8) < 1) part_particles_create(global.ps_front, random_range(camera_get_view_x(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])), random_range(camera_get_view_y(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])), global.pt_dust_1, 1);
	
	// Fog
	if (random(6) < 1){
		if (part_particles_count(global.pt_smoke_3) < 30){
			part_particles_create(global.ps_front, camera_get_view_x(view_camera[0]) + random_range(0, camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + random_range(0, camera_get_view_height(view_camera[0])), global.pt_smoke_3, 1);
		}
	}
}

// Spawning
lighting = 0.65;

global.ambientShadowIntensity = lighting;
global.game_combat_active = false;
scr_level_combatstate_control();