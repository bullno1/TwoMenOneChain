level_editor_save(currentSet, currentLevel);
currentSet = ((argument0 % 3) + 3 ) % 3;
var numLevels = level_editor_get_num_levels(currentSet);
currentLevel = ((argument1 % numLevels) + numLevels) % numLevels;
level_editor_load(currentSet, currentLevel);
