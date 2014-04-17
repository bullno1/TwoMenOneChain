if(!invincible)
{
    audio_play_sound(sndHit, 11, false);
}

player_process_hit();
with(partner) player_process_hit();
