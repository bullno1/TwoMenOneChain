var chunk = argument0;
var numObjs = ds_grid_height(chunk) - 1;
var minY = 0;
for(var objIndex = 0; objIndex < numObjs; ++objIndex)
{
    var objX = grid_pos_to_world(ds_grid_get(chunk, 0, objIndex));
    var objY = ds_grid_get(chunk, 1, objIndex);
    var objType = ds_grid_get(chunk, 2, objIndex);
    
    var obj;
    if(objType == 0)
    {
        obj = oRock;
    }
    else
    {
        obj = oPole;
    }
    
    var instance = instance_create(objX, objY, obj);
    minY = min(minY, objY);
}

return minY;
