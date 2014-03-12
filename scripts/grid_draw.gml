draw_set_color(GRID_COLOR);

for(var lineX = 0; lineX < room_width; lineX += LANE_WIDTH)
{
    draw_line(lineX, 0, lineX, room_height);
}
