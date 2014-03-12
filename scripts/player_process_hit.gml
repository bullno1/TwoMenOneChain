if(!invincible)
{
    invincible = true;
    alarm[0] = room_speed * BLINK_DURATION;
    
    fx_blink(id, BLINK_DURATION);
}
