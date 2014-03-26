for(var i = 0; i < NUM_LANES; ++i)
{
    draw_text(i * LANE_WIDTH, 20, string(laneScores[i]));
    draw_text(i * LANE_WIDTH, 35, string(lanePenalties[i]));
}
