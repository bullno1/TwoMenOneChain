//generate a random level chunk from a specified collection of chunks

var chunkIndex = irandom(ds_list_size(argument0) - 1);
var chunkHeight = map_generate_chunk(argument0, chunkIndex);

//Setup next generation
alarm[0] = chunkHeight / SCROLLING_SPEED;
