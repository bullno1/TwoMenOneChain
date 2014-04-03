if(!invincible)
{
    invincible = true;
    y = min(room_height, y + HP_DISTANCE);
    if(instance_exists(g_caughtObject))
    {
        with(g_caughtObject)
        {
            instance_destroy();
        }
    }
    
    if(isLeft)
    {
        health = max(0, health - 1);
        if(health == 0)
        {
            on_lose_game();
        }
    }
    alarm[0] = room_speed * BLINK_DURATION;
    
    fx_blink(id, BLINK_DURATION);
}
