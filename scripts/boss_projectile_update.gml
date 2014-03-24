if(instance_crossed_chain())
{
    vspeed = 0;
    if(instance_exists(g_caughtObject))//if players are holding another object
    {
        instance_destroy();
        with(g_caughtObject)
        {
            instance_destroy();
        }
    }
    else if(player_gap() == CHAIN_LIMIT)//if the chain is taut
    {
        instance_destroy();
    }
    else
    {
        g_caughtObject = id;
        instance_change(oPlayerProjectile, false);
    }
}
