if(!invincible)
{
    invincible = true;
    y += HP_DISTANCE;
    if(isLeft)
    {
        health -= 1;
        if(health == 0)
        {
            on_lose_game();
        }
    }
    alarm[0] = room_speed * BLINK_DURATION;
    
    fx_blink(id, BLINK_DURATION);
}
