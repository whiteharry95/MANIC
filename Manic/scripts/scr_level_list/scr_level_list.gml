enum Level{
	Prologue,
	RavagedTown,
	WesternFarmland,
	UndergroundBunker,
	StorageFacility,
	HumanPrison,
	TrainStation,
	TheCemetery,
	DesolateVillage,
	IntoTheCity,
	CityHeadquarters,
}

global.level_name[Level.Prologue] = "The Prologue";
global.level_room[Level.Prologue] = rm_prologue_00;
global.level_collectable_current[Level.Prologue] = 0;
global.level_collectable_number[Level.Prologue] = 0;
global.level_turret_number[Level.Prologue] = 0;
global.level_entered[Level.Prologue] = false;
global.level_cleared[Level.Prologue] = false;
global.level_kill_count[Level.Prologue] = 0;
global.level_kill_max[Level.Prologue] = 3;

global.level_name[Level.RavagedTown] = "Ravaged Town";
global.level_room[Level.RavagedTown] = rm_level_1_00;
global.level_collectable_current[Level.RavagedTown] = 0;
global.level_collectable_number[Level.RavagedTown] = 6;
global.level_turret_number[Level.RavagedTown] = 0;
global.level_entered[Level.RavagedTown] = false;
global.level_cleared[Level.RavagedTown] = false;
global.level_kill_count[Level.RavagedTown] = 0;
global.level_kill_max[Level.RavagedTown] = 40;

global.level_name[Level.WesternFarmland] = "Western Farmland";
global.level_room[Level.WesternFarmland] = rm_level_2_00;
global.level_collectable_current[Level.WesternFarmland] = 0;
global.level_collectable_number[Level.WesternFarmland] = 4;
global.level_turret_number[Level.WesternFarmland] = 0;
global.level_entered[Level.WesternFarmland] = false;
global.level_cleared[Level.WesternFarmland] = false;
global.level_kill_count[Level.WesternFarmland] = 0;
global.level_kill_max[Level.WesternFarmland] = 40;

global.level_name[Level.UndergroundBunker] = "Underground Bunker";
global.level_room[Level.UndergroundBunker] = rm_level_3_00;
global.level_collectable_current[Level.UndergroundBunker] = 0;
global.level_collectable_number[Level.UndergroundBunker] = 4;
global.level_turret_number[Level.UndergroundBunker] = 0;
global.level_entered[Level.UndergroundBunker] = false;
global.level_cleared[Level.UndergroundBunker] = false;
global.level_kill_count[Level.UndergroundBunker] = 0;
global.level_kill_max[Level.UndergroundBunker] = 100;

global.level_name[Level.StorageFacility] = "Storage Facility";
global.level_room[Level.StorageFacility] = rm_level_4_00;
global.level_collectable_current[Level.StorageFacility] = 0;
global.level_collectable_number[Level.StorageFacility] = 3;
global.level_turret_number[Level.StorageFacility] = 0;
global.level_entered[Level.StorageFacility] = false;
global.level_cleared[Level.StorageFacility] = false;
global.level_kill_count[Level.StorageFacility] = 0;
global.level_kill_max[Level.StorageFacility] = 50;

global.level_name[Level.HumanPrison] = "Human Prison";
global.level_room[Level.HumanPrison] = rm_level_5_00;
global.level_collectable_current[Level.HumanPrison] = 0;
global.level_collectable_number[Level.HumanPrison] = 7;
global.level_turret_number[Level.HumanPrison] = 1;
global.level_entered[Level.HumanPrison] = false;
global.level_cleared[Level.HumanPrison] = false;
global.level_kill_count[Level.HumanPrison] = 0;
global.level_kill_max[Level.HumanPrison] = 120;

global.level_name[Level.TrainStation] = "Train Station";
global.level_room[Level.TrainStation] = rm_level_6_00;
global.level_collectable_current[Level.TrainStation] = 0;
global.level_collectable_number[Level.TrainStation] = 3;
global.level_turret_number[Level.TrainStation] = 1;
global.level_entered[Level.TrainStation] = false;
global.level_cleared[Level.TrainStation] = false;
global.level_kill_count[Level.TrainStation] = 0;
global.level_kill_max[Level.TrainStation] = 40;

global.level_name[Level.TheCemetery] = "The Cemetery";
global.level_room[Level.TheCemetery] = rm_level_7_00;
global.level_collectable_current[Level.TheCemetery] = 0;
global.level_collectable_number[Level.TheCemetery] = 4;
global.level_turret_number[Level.TheCemetery] = 3;
global.level_entered[Level.TheCemetery] = false;
global.level_cleared[Level.TheCemetery] = false;
global.level_kill_count[Level.TheCemetery] = 0;
global.level_kill_max[Level.TheCemetery] = 60;

global.level_name[Level.DesolateVillage] = "Desolate Village";
global.level_room[Level.DesolateVillage] = rm_level_8_00;
global.level_collectable_current[Level.DesolateVillage] = 0;
global.level_collectable_number[Level.DesolateVillage] = 2;
global.level_turret_number[Level.DesolateVillage] = 1;
global.level_entered[Level.DesolateVillage] = false;
global.level_cleared[Level.DesolateVillage] = false;
global.level_kill_count[Level.DesolateVillage] = 0;
global.level_kill_max[Level.DesolateVillage] = 60;

global.level_name[Level.IntoTheCity] = "Into the City";
global.level_room[Level.IntoTheCity] = rm_level_9_00;
global.level_collectable_current[Level.IntoTheCity] = 0;
global.level_collectable_number[Level.IntoTheCity] = 4;
global.level_turret_number[Level.IntoTheCity] = 3;
global.level_entered[Level.IntoTheCity] = false;
global.level_cleared[Level.IntoTheCity] = false;
global.level_kill_count[Level.IntoTheCity] = 0;
global.level_kill_max[Level.IntoTheCity] = 80;

global.level_name[Level.CityHeadquarters] = "City Headquarters";
global.level_room[Level.CityHeadquarters] = rm_level_10_00;
global.level_collectable_current[Level.CityHeadquarters] = 0;
global.level_collectable_number[Level.CityHeadquarters] = 0;
global.level_turret_number[Level.CityHeadquarters] = 0;
global.level_entered[Level.CityHeadquarters] = false;
global.level_cleared[Level.CityHeadquarters] = false;
global.level_kill_count[Level.CityHeadquarters] = 0;
global.level_kill_max[Level.CityHeadquarters] = 0;