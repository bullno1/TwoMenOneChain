draw_self();

for(var i = 0; i < NUM_LANES; ++i)
{
    var drawX = grid_pos_to_world(i) - LANE_WIDTH / 2;
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_text(drawX, 0, debug_vars[i]);
    draw_text(drawX, 20, debug_vars2[i]);
}

draw_text(x, y - 100, debug_var_head);
