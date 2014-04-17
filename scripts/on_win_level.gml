with(oBoss)
{  
    alarm[0] = -1;
    vspeed = 1;
    dying = true;
}

with(oHarmful)
{
    var explosion = instance_create(x, y, oExplosion);
    explosion.vspeed = vspeed;
    instance_destroy();
}

oGameController.alarm[0] = -1;//stop obstacle generation
