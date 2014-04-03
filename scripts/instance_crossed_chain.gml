if(!instance_exists(id)) return false;
var chainPos = g_leftPlayer.y;

var betweenPlayers = g_leftPlayer.x < x && x < g_rightPlayer.x;
var crossedChain = yprevious < chainPos && chainPos <= y;

return betweenPlayers && crossedChain;
