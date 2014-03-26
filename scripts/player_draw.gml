draw_self();

switch(blockedMoveDirection)
{
case -1:
    draw_text(x, y - 150, "Left!!");
break;
case 1:
    draw_text(x, y - 150, "Right!!");
break;
}
