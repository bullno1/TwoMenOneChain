var chainPos = oPlayer.y;

var betweenPlayers = g_leftPlayer.gridPos < gridPos && gridPos < g_rightPlayer.gridPos;
var crossedChain = yprevious < chainPos && chainPos <= y;

return betweenPlayers && crossedChain;
