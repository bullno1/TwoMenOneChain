//player_move(direction): attempt to move a player towards a direction
//direction: -1 | 0 | 1
//returns whether the move is allowed

var moveDirection = argument0;
if(moveDirection == 0) return true;

var nextGridPos = gridPos + moveDirection;

//Validate move
var outOfBound = nextGridPos < 0 || nextGridPos >= NUM_LANES;
var overlapPartner = nextGridPos == partner.gridPos;
var gapAfterMove = abs(nextGridPos - partner.gridPos) - 1;
var exceedChainLimit = gapAfterMove > CHAIN_LIMIT;
var holdingObject = instance_exists(g_caughtObject);
var blockedByCaughtObject = holdingObject && gapAfterMove == 0;

if(outOfBound || overlapPartner || exceedChainLimit || blockedByCaughtObject)
{
    return false;
}

gridPos = nextGridPos;
if(holdingObject)
{
    if(g_caughtObject.gridPos == nextGridPos)//because there's no short circuit in GML
    {
        g_caughtObject.gridPos += moveDirection;
    }
}

return true;
