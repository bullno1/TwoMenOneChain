for(var i = 0; i < NUM_LANES; ++i)
{
    draw_text(grid_pos_to_world(i), 20, string(laneScores[i]));
    draw_text(grid_pos_to_world(i), 35, string(lanePenalties[i]));
}
