//player_init(): Initializes a player's states

globalvar g_leftPlayer, g_rightPlayer, g_caughtObject;
g_caughtObject = noone;
health = MAX_HP;
y = room_height - (health - 1) * HP_DISTANCE;

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
partner = otherPlayer;
invincible = false;
wasSnapping = false;

if(isLeft)
{
    g_leftPlayer = id;
}
else
{
    g_rightPlayer = id;
}
