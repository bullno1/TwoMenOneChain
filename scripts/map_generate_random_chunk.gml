//generate a random level chunk from a specified collection of chunks
var chunks = g_mapChunks[argument0];
var chunkIndex = irandom(ds_list_size(chunks) - 1);
if(chunkIndex >= ds_list_size(chunks))
{
    return 0;
}
var chunk = ds_list_find_value(chunks, chunkIndex);

return map_generate_chunk(chunk);
