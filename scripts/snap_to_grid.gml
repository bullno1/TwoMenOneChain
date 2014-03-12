//snap_to_grid(): snap a grid bound object to its correct position
var worldX = grid_pos_to_world(gridPos);
var diff = worldX - x;
if(abs(diff) < SNAP_SPEED)
{
    x = worldX;
}
else
{
    x += SNAP_SPEED * sign(diff);
}
