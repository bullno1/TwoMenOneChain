var drawX = grid_pos_to_world(g_leftPlayer.gridPos) - LANE_WIDTH / 2;
var drawY = g_leftPlayer.y - 10;
var sprite = sprChain0;

switch(player_gap())
{
case 0:
    sprite = sprChain0;
break;
case 1:
    sprite = sprChain1;
break;
case 2:
    sprite = sprChain2;
break;
case 3:
    sprite = sprChain3;
break;
}

draw_sprite(sprite, image_index, drawX, drawY);
