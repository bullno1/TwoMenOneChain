//Destroy an instance iff it is flying out of the room
var top = y - sprite_yoffset;
var bottom = top + sprite_height;
var left = x - sprite_xoffset;
var right = x + sprite_width;
var flyLeft = right < 0 && x < xprevious;
var flyRight = left > room_width && x > xprevious;
var flyUp = bottom < 0 && y < yprevious;
var flyDown = top > room_height && y > yprevious;

if(flyLeft || flyRight || flyUp || flyDown)
    instance_destroy();
