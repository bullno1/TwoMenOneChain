var chunkSet = g_mapChunks[argument0];
var chunk = ds_list_find_value(chunkSet, argument1);

var numObjs = instance_number(oTile);
ds_grid_resize(chunk, 3, numObjs + 1);
var objIndex = 0;
with(oTile)
{
    ds_grid_set(chunk, 0, objIndex, world_pos_to_grid(x));
    ds_grid_set(chunk, 1, objIndex, y - room_height);
    var objType;
    if(sprite_index == sprRock)
    {
        objType = 0;
    }
    else
    {
        objType = 1;
    }
    ds_grid_set(chunk, 2, objIndex, objType);
    ++objIndex;
}
