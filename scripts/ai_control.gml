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

//evaluate each lane
var holdingObject = instance_exists(g_caughtObject);
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

var laneScores;
for(var laneIndex = 0; laneIndex < NUM_LANES; ++laneIndex)
{
    laneScores[laneIndex] = 0;
}


for(var myLane = myMinLane; myLane <= myMaxLane; ++myLane)
{
    //consider myself
    var laneScore = 0;
    laneScore += threatDistances[myLane];
 
    //consider partner
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
    
    var partnerSum = 0;
    for(var partnerLane = partnerMin; partnerLane <= partnerMax; ++partnerLane)
    {
        partnerSum += threatDistances[partnerLane];    
    }
    laneScore += partnerSum / (partnerMax - partnerMin + 1);
    
    laneScores[myLane] = laneScore;
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
