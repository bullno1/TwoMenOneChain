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

for(var decisionIndex = 0; decisionIndex < 3; ++decisionIndex)
{
    if(instance_place(x + (decisionIndex - 1) * LANE_WIDTH, y, oHarmful) != noone)
    {
        decisionPenalties[decisionIndex] = -room_height;
    }
    else
    {
        decisionPenalties[decisionIndex] = 0;
    }
}

var minLane, maxLane;
var partnerLane = world_pos_to_grid(partner.x);
if(isLeft)
{
    minLane = max(0, partnerLane - CHAIN_LIMIT - 1);
    maxLane = partner.gridPos;
}
else
{
    minLane = max(partnerLane + 1, NUM_LANES - 1);
    maxlane = min(NUM_LANES, parterlane + CHAIN_LIMIT);
}

//evaluate each lane
var currentLane = world_pos_to_grid(x);
for(var laneIndex = minLane; laneIndex < maxLane; ++laneIndex)
{
    var moveDirection = sign(laneIndex - currentLane);
    var decisionIndex = moveDirection + 1;
    var laneScore = (threatDistances[laneIndex] + decisionPenalties[decisionIndex]);
    laneScores[laneIndex] = laneScore;
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
