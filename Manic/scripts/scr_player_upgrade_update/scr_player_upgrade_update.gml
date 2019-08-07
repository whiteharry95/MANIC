if (global.level_current >= Level.UndergroundBunker){
	scr_upgrade_add(PlayerUpgrade.Backpack);
}

if (global.level_current >= Level.HumanPrison){
	scr_upgrade_add(PlayerUpgrade.RunningBoots);
}

if (global.level_current >= Level.TrainStation){
	scr_upgrade_add(PlayerUpgrade.KneePads);
}

if (global.level_current >= Level.TheCemetery){
	scr_upgrade_add(PlayerUpgrade.Chestplate);
}

if (global.level_current >= Level.DesolateVillage){
	scr_upgrade_add(PlayerUpgrade.GasMask);
}