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
    if(bbox_top > 0 && bbox_top < other.bbox_bottom) //if relevant
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

//find the best lane to move towards
//Assume current lane is best to avoid unnecesasry movement
var bestScore = laneScores[gridPos];
var bestLane = gridPos;
for(var i = 0; i < NUM_LANES; ++i)
{
    if(laneScores[i] > bestScore)
    {
        bestScore = laneScores[i];
        bestLane = i;
    }
}

for(var i = 0; i < NUM_LANES; ++i)
{
    debug_vars[i] = threatDistances[i];
    debug_vars2[i] = laneScores[i];
}

debug_var_head = partnerMax;

return sign(bestLane - gridPos);
