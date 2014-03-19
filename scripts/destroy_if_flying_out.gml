//Destroy an instance iff it is flying out of the room
var flyLeft = x < 0 && x < xprevious;
var flyRight = x > room_width && x > xprevious;
var flyUp = y < 0 && y < yprevious;
var flyDown = y > room_height && y > yprevious;

if(flyLeft || flyRight || flyUp || flyDown)
    instance_destroy();
