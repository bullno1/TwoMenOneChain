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

//locate all nearest obstacles in every lane
with(oObstacle)
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

var holdingObject = instance_exists(g_caughtObject);

//locate boss's projectile
var bossProjectile = noone;
var hasBossProjectile = false;
if(instance_number(oBossProjectile) > 0)
{
    bossProjectile = oBossProjectile.id;
    hasBossProjectile = true;
}

//evaluate each position combination
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
        myMinLane = 2;
    }
    else
    {
        myMinLane = 1;
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
        
        //consider catching and dodging projectile
        var bossProjectileBonus = 0;
        var bossProjectileSafety = room_height;
        if(hasBossProjectile)
        {
            var projectilePos = bossProjectile.gridPos;
            if(poleMin < projectilePos && projectilePos < poleMax && poleMax - poleMin < 3 && bossProjectile.y < y)//can catch
            {
                bossProjectileBonus = 5;
            }
            else if(projectilePos == myLane || projectilePos == partnerLane)//dodge
            {
                bossProjectileSafety = y - bossProjectile.y;
            }
        }

        comboSum += min(personalSafety, partnerSafety, nearestPole, bossProjectileSafety) + bossProjectileBonus;
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
var reachedEdge = isLeft && gridPos == 0;
var blockedByPartner = !isLeft && playerGap == 0;
var blockedByObject = !isLeft && playerGap == 1 && holdingObject;
var stoppedByChain = isLeft && playerGap == 3;
var safeScore = 300;

if(blockedByPartner || blockedByObject || stoppedByChain || reachedEdge)//Can't move left
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
    decisionScores[0] = min(bestLeftScore, safeScore);
}

//consider staying
decisionScores[1] = min(laneScores[gridPos], safeScore);

//consider moving right
var reachedEdge = !isLeft && gridPos == NUM_LANES - 1;
var blockedByPartner = isLeft && playerGap == 0;
var blockedByObject = isLeft && playerGap == 1 && holdingObject;
var stoppedByChain = !isLeft && playerGap == 3;

if(blockedByPartner || blockedByObject || stoppedByChain || reachedEdge)//Can't move right
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
    decisionScores[2] = min(bestRightScore, safeScore);
}

//Add more weight to adjust distance between players
if(holdingObject)
{
    var bossPos = oBoss.gridPos;
    
    if(bossPos == g_caughtObject.gridPos)//can attack
    {
        if(isLeft)
        {
            decisionScores[0] += 1;
        }
        else
        {
            decisionScores[2] += 1;
        }
    }
    else
    {    
        if(isLeft)
        {
            if(playerGap == 1 && bossPos < gridPos)
            {
                decisionScores[0] += 1;
            }
            else if(playerGap == 2 && bossPos > gridPos)
            {
                decisionScores[2] += 1;
            }
        }
        else
        {
            if(playerGap == 1 && bossPos > gridPos)
            {
                decisionScores[2] += 1;
            }
            else if(playerGap == 2 && bossPos < gridPos)
            {
                decisionScores[0] += 1;
            }
        }
    }
}
else
{
    var currentGap = abs(gridPos - world_pos_to_grid(partner.xprevious)) - 1;
    if(currentGap < 1)
    {
        if(isLeft)
        {
            decisionScores[0] += 1;
        }
        else
        {
            decisionScores[2] += 1;
        }
    }
    else if(currentGap > 1)
    {
        if(isLeft)
        {
            decisionScores[2] += 1;
        }
        else
        {
            decisionScores[0] += 1;
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
