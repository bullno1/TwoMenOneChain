//Destroy an instance iff it is flying out of the room
var top = y - sprite_yoffset;
var bottom = top + sprite_height;
var left = x - sprite_xoffset;
var right = x + sprite_width;
var flyLeft = right < 0 && hspeed < 0;
var flyRight = left > room_width && hspeed > 0;
var flyUp = bottom < 0 && vspeed < 0;
var flyDown = top > room_height && vspeed > 0;

if(flyLeft || flyRight || flyUp || flyDown)
{
    instance_destroy();
}
