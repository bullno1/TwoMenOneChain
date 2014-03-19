var chunks = ds_list_create();

var filename = file_find_first(working_directory + argument0 + "\*.txt", 0);
while(filename != "")
{
    var chunk = map_load_chunk_from_file(working_directory + argument0 + "\" + filename);
    ds_list_add(chunks, chunk);
    filename = file_find_next();
}
file_find_close();

return chunks;
