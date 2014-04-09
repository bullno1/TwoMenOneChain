var currentTime = current_time;
if(currentTime - lastMoveTime < 100)
{
    return 0;
}

var laneThreats, threatDistances, poleDistances;

for(var i = 0; i < NUM_LANES; ++i)
{
    laneThreats[i] = noone;
    threatDistances[i] = y;
    poleDistances[i] = y;
}

//locate all nearest threats in every lane
with(oHarmful)
{
    if(bbox_top > 200 && bbox_top < other.bbox_bottom) //if relevant
    {
        var distance = other.y - y;
        if(distance < threatDistances[gridPos])
        {
            threatDistances[gridPos] = distance;
            laneThreats[gridPos] = id;
        }
        
        if(object_index == oPole && distance < poleDistances[gridPos])
        {
            poleDistances[gridPos] = distance;
        }
    }
}

//evaluate each position combination
var holdingObject = instance_exists(g_caughtObject);

//find personal range
var myMinLane, myMaxLane;
if(isLeft)
{
    myMinLane = 0;
    if(holdingObject)
    {
        myMaxLane = NUM_LANES - 3;
    }
    else
    {
        myMaxLane = NUM_LANES - 2;
    }
}
else
{
    if(holdingObject)
    {
        myMinLane = 3;
    }
    else
    {
        myMinLane = 2;
    }
    
    myMaxLane = NUM_LANES - 1;
}

for(var laneIndex = 0; laneIndex < NUM_LANES; ++laneIndex)
{
    laneScores[laneIndex] = 0;
}

for(var myLane = myMinLane; myLane <= myMaxLane; ++myLane)
{
    var laneScore = 0;

    //find partner range
    var partnerMin, partnerMax;
    if(isLeft)
    {
        if(holdingObject)
        {
            partnerMin = myLane + 2;
        }
        else
        {
            partnerMin = myLane + 1;
        }
        partnerMax = min(NUM_LANES - 1, myLane + 4);
    }
    else
    {
        partnerMin = max(0, myLane - 4);
        if(holdingObject)
        {
            partnerMax = myLane - 2;
        }
        else
        {
            partnerMax = myLane - 1;
        }
    }

    var comboSum = 0;
    var personalSafety = threatDistances[myLane];
    //for every combination of my position and partner's position
    for(var partnerLane = partnerMin; partnerLane <= partnerMax; ++partnerLane)
    {
        var partnerSafety = threatDistances[partnerLane];
        
        //consider poles between
        var nearestPole = room_height;
        var poleMin = min(myLane, partnerLane);
        var poleMax = max(myLane, partnerLane);
        for(var poleLane = poleMin; poleLane <= poleMax; ++poleLane)
        {
            nearestPole = min(nearestPole, poleDistances[poleLane]);
        }

        comboSum += min(personalSafety, partnerSafety, nearestPole);
    }

    laneScores[myLane] = comboSum / (partnerMax - partnerMin + 1);
}

for(var i = 0; i < NUM_LANES; ++i)
{
    debug_vars[i] = threatDistances[i];
    debug_vars2[i] = laneScores[i];
}

var decisionScores;
var playerGap = player_gap();

//consider moving left
var blockedByPartner = !isLeft && playerGap == 0;
var blockedByObject = !isLeft && playerGap == 1 && holdingObject;
var stoppedByChain = isLeft && playerGap == 3;

if(blockedByPartner || blockedByObject || stoppedByChain)//Can't move left
{
    decisionScores[0] = 0;
}
else
{
    var bestLeftScore = 0;
    for(var laneIndex = 0; laneIndex < gridPos; ++laneIndex)
    {
        bestLeftScore = max(bestLeftScore, laneScores[laneIndex]);
    }
    decisionScores[0] = bestLeftScore;
}

//consider staying
decisionScores[1] = laneScores[gridPos];

//consider moving right
var blockedByPartner = isLeft && playerGap == 0;
var blockedByObject = isLeft && playerGap == 1 && holdingObject;
var stoppedByChain = !isLeft && playerGap == 3;

if(blockedByPartner || blockedByObject || stoppedByChain)//Can't move right
{
    decisionScores[2] = 0;
}
else
{
    var bestRightScore = 0;
    for(var laneIndex = gridPos + 1; laneIndex < NUM_LANES; ++laneIndex)
    {
        bestRightScore = max(bestRightScore, laneScores[laneIndex]);
    }
    decisionScores[2] = bestRightScore;
}

if(holdingObject)
{
}
else
{
    var currentGap = abs(gridPos - world_pos_to_grid(partner.xprevious)) - 1;
    if(currentGap < 1)
    {
        if(isLeft)
        {
            decisionScores[0] += 5;
        }
        else
        {
            decisionScores[2] += 5;
        }
    }
    else if(currentGap > 1)
    {
        if(isLeft)
        {
            decisionScores[2] += 5;
        }
        else
        {
            decisionScores[0] += 5;
        }
    }
}

//Find the best action
var bestScore = decisionScores[1];
var bestDecision = 1;
for(var decisionIndex = 0; decisionIndex < 3; ++decisionIndex)
{
    if(decisionScores[decisionIndex] > bestScore)
    {
        bestScore = decisionScores[decisionIndex];
        bestDecision = decisionIndex;
    }
}

//Prevent jerking
if(lastDecision + bestDecision == 2 && currentTime - lastMoveTime < 800)//two conflicting decisions
{
    return 0;
}
else
{
    lastDecision = bestDecision;
    lastMoveTime = currentTime;
    return bestDecision - 1;
}
