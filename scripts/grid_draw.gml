draw_set_color(GRID_COLOR);

for(var lineX = ROAD_START; lineX < ROAD_START + ROAD_WIDTH + LANE_WIDTH; lineX += LANE_WIDTH)
{
    draw_line(lineX, 0, lineX, room_height);
}
