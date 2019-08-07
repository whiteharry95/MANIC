///@param refresh_display
var refresh_display = false;

if (argument_count > 0){
	refresh_display = argument[0];
}

ini_open(working_directory + "config.ini");

global.game_option[| Options.Screenshake] = clamp(global.game_option[| Options.Screenshake], 0, 100);
global.game_option[| Options.QuickZoom] = clamp(global.game_option[| Options.QuickZoom], 0, 100);
global.game_option[| Options.Flashing] = clamp(global.game_option[| Options.Flashing], 0, 100);

ini_write_real("Options", "Screenshake", global.game_option[| Options.Screenshake]);
ini_write_real("Options", "ScreenFreeze", global.game_option[| Options.ScreenFreeze]);
ini_write_real("Options", "QuickZoom", global.game_option[| Options.QuickZoom]);
ini_write_real("Options", "MaxCorpses", global.game_option[| Options.MaxCorpses]);
ini_write_real("Options", "Flashing", global.game_option[| Options.Flashing]);

ini_write_real("Options", "Fullscreen", global.game_option[| Options.Fullscreen]);
ini_write_real("Options", "Resolution", global.game_option[| Options.Resolution]);
ini_write_real("Options", "WindowScale", global.game_option[| Options.WindowScale]);
ini_write_real("Options", "CameraScale", global.game_option[| Options.CameraScale]);
ini_write_real("Options", "UIScale", global.game_option[| Options.UIScale]);

ini_write_real("Options", "MasterVolume", global.game_option[| Options.MasterVolume]);
ini_write_real("Options", "SoundVolume", global.game_option[| Options.SoundVolume]);
ini_write_real("Options", "MusicVolume", global.game_option[| Options.MusicVolume]);
ini_write_real("Options", "AmbienceVolume", global.game_option[| Options.AmbienceVolume]);

ini_write_real("Options", "Input_MoveRight", global.game_option[| Options.Input_MoveRight]);
ini_write_real("Options", "Input_MoveLeft", global.game_option[| Options.Input_MoveLeft]);
ini_write_real("Options", "Input_MoveUp", global.game_option[| Options.Input_MoveUp]);
ini_write_real("Options", "Input_MoveDown", global.game_option[| Options.Input_MoveDown]);
ini_write_real("Options", "Input_Dash", global.game_option[| Options.Input_Dash]);
ini_write_real("Options", "Input_Interact", global.game_option[| Options.Input_Interact]);
ini_write_real("Options", "Input_Attack", global.game_option[| Options.Input_Attack]);
ini_write_real("Options", "Input_Throw", global.game_option[| Options.Input_Throw]);

ini_close();

if (refresh_display){
	window_set_fullscreen(global.game_option[| Options.Fullscreen]);
	scr_display_update();
}

with(obj_controller_all){
	scr_update_real_volumes();
	
	key_right = global.game_option[| Options.Input_MoveRight];
	key_left = global.game_option[| Options.Input_MoveLeft];
	key_up = global.game_option[| Options.Input_MoveUp];
	key_down = global.game_option[| Options.Input_MoveDown];
	key_dash = global.game_option[| Options.Input_Dash];
	key_interact = global.game_option[| Options.Input_Interact];
	key_attack = global.game_option[| Options.Input_Attack];
	key_throw = global.game_option[| Options.Input_Throw];
}

if (room == rm_title_0){
	if (!obj_titlescreen_main.fade){
		audio_sound_gain(m_ambience_rain_0, 0.6 * obj_controller_all.real_ambience_volume, 50);
	
		with(obj_titlescreen_main){
			scr_titlescreen_options_reload();
		}
	}
}

obj_controller_all.option_refresh = true;