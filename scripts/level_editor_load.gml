with(oTile)
{
    instance_destroy();
}

var chunkSet = g_mapChunks[argument0];
var chunk = ds_list_find_value(chunkSet, argument1);

var numObjs = ds_grid_height(chunk) - 1;
for(var objIndex = 0; objIndex < numObjs; ++objIndex)
{
    var objX = grid_pos_to_world(ds_grid_get(chunk, 0, objIndex));
    var objY = ds_grid_get(chunk, 1, objIndex) + room_height;
    var objType = ds_grid_get(chunk, 2, objIndex);
    
    var sprite;
    if(objType == 0)
    {
        sprite = sprRock;
    }
    else
    {
        sprite = sprPole;
    }
    
    var instance = instance_create(objX, objY, oTile);
    instance.sprite_index = sprite;
}
