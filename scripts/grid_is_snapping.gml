var worldX = grid_pos_to_world(gridPos);
var diff = worldX - x;
return abs(diff) > SNAP_SPEED;
