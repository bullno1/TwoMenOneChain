//snap_to_grid(): snap a grid bound object to its correct position
var worldX = self.gridPos * LANE_WIDTH + LANE_WIDTH / 2;
var diff = worldX - x;
if(abs(diff) < SNAP_SPEED)
{
    x = worldX;
}
else
{
    x += SNAP_SPEED * sign(diff);
}
