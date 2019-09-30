show_debug_overlay(true);
audio_channel_num(200);
randomize();

scr_global_set();
scr_input_setup();
scr_save_game_reader();

// Enumerators
enum InputType{
	Keyboard,
	Gamepad,
}

enum Grade{
    EMinus,
    E,
    EPlus,
    DMinus,
    D,
    DPlus,
    CMinus,
    C,
    CPlus,
    BMinus,
    B,
    BPlus ,
    AMinus,
    A ,
    APlus,
	S,
}

enum CombatState{
	Idle,
	Buildup,
	Climax,
}

enum PawnType{
	Enemy,
	Boss,
	Companion,
}

enum SoundType{
	Sound,
	Music,
	Ambience,
}

room_goto(rm_title_0);