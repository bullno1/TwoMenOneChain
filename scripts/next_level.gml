g_currentDifficulty += 1;
if(g_currentDifficulty > 2)
{
    on_win_game();
}
else
{
    room_goto(rmGame);
}
