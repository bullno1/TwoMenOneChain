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
    if(instance_place(x + (decisionIndex - 1) * LANE_WIDTH / 2, y - SCROLLING_SPEED * (LANE_WIDTH / SNAP_SPEED / 2), oHarmful) != noone)
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
    maxLane = min(partner.gridPos, NUM_LANES);
}
else
{
    minLane = max(partnerLane + 1, NUM_LANES - 1);
    maxLane = min(NUM_LANES, partnerLane + CHAIN_LIMIT + 2);
}

//evaluate each lane
var currentLane = world_pos_to_grid(x);
for(var laneIndex = 0; laneIndex < NUM_LANES; ++laneIndex)
{
    var moveDirection = sign(laneIndex - currentLane);
    var decisionIndex = moveDirection + 1;
    var chainLength = abs(laneIndex - partnerLane) - 1;
    var chainBonus = 0;
    lanePenalties[laneIndex] = decisionPenalties[decisionIndex];
    switch(chainLength)
    {
    case 0:
        chainBonus = -50;
    break;
    case 1:
        chainBonus = 100;
    break;
    case 2:
        chainBonus = 50;
    break;
    case 3:
        chainBonus = -200;
    break;
    default:
        chainBonus = -250;
    break;
    }
    if((isLeft && laneIndex >= partnerLane) || (!isLeft && laneIndex <= partnerLane))
    {
        chainBonus = -250;
    }
    
    var nextLane = currentLane + moveDirection;
    var laneScore = threatDistances[laneIndex] + threatDistances[nextLane] + chainBonus;
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
