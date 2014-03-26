draw_self();

for(var i = 0; i < NUM_LANES; ++i)
{
    draw_text(i * LANE_WIDTH, 20, string(threatDistances[i]));
}
