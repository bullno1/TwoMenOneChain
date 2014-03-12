// Control a player using keyboard

if(keyboard_check_pressed(move_left_key))
{
    return -1;
}
else if(keyboard_check_pressed(move_right_key))
{
    return 1;
}
else
{
    return 0;
}
