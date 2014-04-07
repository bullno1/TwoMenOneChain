if(!instance_exists(g_leftPlayer) || !instance_exists(g_rightPlayer)) return false;
var chainPos = g_leftPlayer.y;

var betweenPlayers = g_leftPlayer.x < x && x < g_rightPlayer.x;
var crossedChain = yprevious < chainPos && chainPos <= y;

return betweenPlayers && crossedChain;
