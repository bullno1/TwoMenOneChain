//player_init()

//look for the other player
var otherPlayer;

with(oPlayer)
{
    if(self != other)
    {
        otherPlayer = self;
    }
}

self.isLeft = x < otherPlayer.x;
self.gridPos = (x - LANE_WIDTH/2) div LANE_WIDTH;
self.partner = otherPlayer;
