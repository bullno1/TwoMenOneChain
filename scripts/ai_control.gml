ai_reset_states();

//locate all nearest threats in every lane
with(oHarmful)
{
    if(bbox_bottom > 0 && bbox_top < other.bbox_bottom) //if relevant
    {
        var distance = other.y - y;
        var gridPos = world_pos_to_grid(x);
        if(distance < other.threatDistances[gridPos])
        {
            other.threatDistances[gridPos] = distance;
            other.laneThreats[gridPos] = id;
        }
    }
}

//evaluate each lane
var currentLane = world_pos_to_grid(x);
for(var laneIndex = 0; laneIndex < NUM_LANES; ++laneIndex)
{
    var moveDirection = sign(laneIndex - currentLane);
    var decisionIndex = moveDirection + 1;
    var laneScore = threatDistances[laneIndex];
    if(laneScore > moveScores[decisionIndex])
    {
        moveScores[decisionIndex] = laneScore;
    }
}

var bestScore = moveScores[0];
var bestDecision = 0;
for(var decisionIndex = 1; decisionIndex < 3; ++decisionIndex)
{
    if(moveScores[decisionIndex] > bestScore)
    {
        bestScore = moveScores[decisionIndex];
        bestDecision = decisionIndex;
    }
}

return bestDecision - 1;
