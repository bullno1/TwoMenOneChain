//player_move(direction): attempt to move a player towards a direction
//direction: -1 | 0 | 1

var nextGridPos = gridPos + argument0;
if(nextGridPos < 0 || nextGridPos >= NUM_LANES || nextGridPos == partner.gridPos)
{
    return false;//TODO: trigger animation
}

gridPos = nextGridPos;
