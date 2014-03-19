//generate a level chunk from a specified collection of chunks

var MAP_EMPTY = ord('_');
var MAP_HIGH_OBSTACLE = ord('|');
var MAP_LOW_OBSTACLE = ord('o');

var chunkIndex = irandom(ds_list_size(argument0) - 1);
show_debug_message("Generate chunk " + string(chunkIndex));
var chunk = ds_list_find_value(argument0, chunkIndex);

var chunkHeight = ds_grid_height(chunk);
var startY = -chunkHeight * OBSTACLE_HEIGHT - GENERATION_MARGIN;

for(var gridY = 0; gridY < chunkHeight; ++gridY)
{
    for(var gridX = 0; gridX < NUM_LANES; ++gridX)
    {
        var element = ds_grid_get(chunk, gridX, gridY);
        switch(element)
        {
            case MAP_EMPTY:
            break;
            case MAP_LOW_OBSTACLE:
                instance_create(gridX * LANE_WIDTH, startY + gridY * OBSTACLE_HEIGHT, oRock);
            break;
            case MAP_HIGH_OBSTACLE:
                instance_create(gridX * LANE_WIDTH, startY + gridY * OBSTACLE_HEIGHT, oRock);
            break;

            default:
                show_error("Unrecognized map symbol: " + chr(element), false);
            break;
        }
    }
}

//Setup next generation
alarm[0] = -startY / SCROLLING_SPEED;
