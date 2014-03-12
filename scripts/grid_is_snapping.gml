var worldX = gridPos * LANE_WIDTH + LANE_WIDTH / 2;
var diff = worldX - x;
return abs(diff) > SNAP_SPEED;
