var textChunks = ds_list_create();

var file = file_text_open_read(argument0);
show_debug_message(argument0);
while(!file_text_eof(file))
{
    var line = file_text_read_string(file);
    ds_list_add(textChunks, line);
    file_text_readln(file);
}
file_text_close(file);

var numLines = ds_list_size(textChunks);
var chunk = ds_grid_create(NUM_LANES, numLines);
for(var gridY = 0; gridY < numLines; ++gridY)
{
    for(var gridX = 0; gridX < NUM_LANES; ++gridX)
    {
        var line = ds_list_find_value(textChunks, gridY);
        var symbol = string_byte_at(line, gridX + 1);
        if(!map_is_valid_symbol(symbol))
            show_error("Error while loading chunk from file " + argument0 + ". Unrecognized symbol '" + chr(symbol) + "'", true);
        ds_grid_set(chunk, gridX, gridY, symbol);        
    }
}

ds_list_destroy(textChunks);

return chunk;
