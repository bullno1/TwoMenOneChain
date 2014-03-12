var chainPos = oPlayer.y;
globalvar caughtObject;

if(yprevious < chainPos && y >= chainPos && gridPos )//crossed chain
{
    vspeed = 0;
    caughtObject = id;
    instance_change(oPlayerProjectile, false);
}
