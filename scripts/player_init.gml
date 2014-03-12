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
partner = otherPlayer;
invincible = false
