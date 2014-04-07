var chunks = argument0;
var file = file_text_open_write(argument1);

var numChunks = ds_list_size(chunks);
for(var chunkIndex = 0; chunkIndex < numChunks; ++chunkIndex)
{
    var chunk = ds_list_find_value(chunks, chunkIndex);
    var numObjs = ds_grid_height(chunk) - 1;
    file_text_write_real(file, numObjs);
    file_text_writeln(file);
    for(var objIndex = 0; objIndex < numObjs; ++objIndex)
    {
        var objX = ds_grid_get(chunk, 0, objIndex);
        var objY = ds_grid_get(chunk, 1, objIndex);
        var objType = ds_grid_get(chunk, 2, objIndex);
        
        file_text_write_real(file, objX);
        file_text_write_real(file, objY);
        file_text_write_real(file, objType);
        file_text_writeln(file);
    }
}

file_text_close(file);
