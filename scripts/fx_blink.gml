//fx_blink(id, duration): make object blink
var blinker = instance_create(0, 0, oBlinker);
blinker.target = argument0;
blinker.alarm[0] = argument1 * room_speed;
