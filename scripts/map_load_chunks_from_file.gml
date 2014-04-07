var chunks = ds_list_create();

var file = file_text_open_read(argument0);

if(file == -1)
{
    return chunks;
}

while(!file_text_eof(file))
{
    var numObjs = file_text_read_real(file);
    file_text_readln(file);
    var chunk = ds_grid_create(3, numObjs + 1);
    for(var objIndex = 0; objIndex < numObjs; ++objIndex)
    {
        var objX = file_text_read_real(file);
        var objY = file_text_read_real(file);
        var objType = file_text_read_real(file);
        file_text_readln(file);
        
        ds_grid_set(chunk, 0, objIndex, objX);
        ds_grid_set(chunk, 1, objIndex, objY);
        ds_grid_set(chunk, 2, objIndex, objType);
    }
    ds_list_add(chunks, chunk);
}

file_text_close(file);

return chunks;
