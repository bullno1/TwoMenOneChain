//player_move(direction): attempt to move a player towards a direction
//direction: -1 | 0 | 1
//returns whether the move is allowed

var nextGridPos = gridPos + argument0;

//Validate move
var outOfBound = nextGridPos < 0 || nextGridPos >= NUM_LANES;
var overlapPartner = nextGridPos == partner.gridPos;
var exceedChainLimit = abs(nextGridPos - partner.gridPos) - 1 > CHAIN_LIMIT;
if(outOfBound || overlapPartner || exceedChainLimit)
{
    return false;
}

gridPos = nextGridPos;
return true;
