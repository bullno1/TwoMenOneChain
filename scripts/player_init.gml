//player_init(): Initializes a player's states

//look for the other player
var otherPlayer;

with(oPlayer)
{
    if(id != other.id)
    {
        otherPlayer = id;
    }
}

isLeft = x < otherPlayer.x;
gridPos = (x - LANE_WIDTH/2) div LANE_WIDTH;
partner = otherPlayer;
