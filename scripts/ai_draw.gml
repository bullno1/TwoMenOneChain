return 0;

for(var i = 0; i < NUM_LANES; ++i)
{
    var drawX = grid_pos_to_world(i) - LANE_WIDTH / 2;
    var drawY;
    if(isLeft)
    {
        drawY = 0;
    }
    else
    {
        drawY = 30;
    }
    draw_set_color(c_white);
    draw_text(drawX, drawY, round(laneScores[i]));
}

for(var i = 0; i < 3; ++i)
{
    var drawX = x + (i - 1) * LANE_WIDTH;
    var drawY;
    if(isLeft)
    {
        drawY = y - 100;
    }
    else
    {
        drawY = y - 200;
    }
    
    draw_text(drawX, drawY, round(decisionScores[i]));
}
