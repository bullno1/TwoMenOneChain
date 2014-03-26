//Update a player
if(!grid_is_snapping())
{
    var moveDirection = script_execute(control_script);
    if(!player_move(moveDirection))
    {
        blockedMoveDirection = moveDirection;
        alarm[1] = 60;
    }
    else if(moveDirection != 0)
    {
        blockedMoveDirection = 0;
        alarm[1] = -1;
    }
}

//Check whether object can be launched
var isSnapping = grid_is_snapping();
if(!isSnapping && wasSnapping)//just finished snapping
{
    var partnerIsSnapping;
    with(partner)
    {
        partnerIsSnapping = grid_is_snapping();
    }
    
    var gap = abs(gridPos - partner.gridPos) - 1;
    if(!partnerIsSnapping && gap == CHAIN_LIMIT && instance_exists(g_caughtObject))
    {
        g_caughtObject.vspeed = -LAUNCH_SPEED;
        g_caughtObject = noone;
    }
}

wasSnapping = isSnapping;
