control_script = ai_control;

lastDecision = 1;
lastMoveTime = 0;

for(var i = 0; i < NUM_LANES; ++i)
{
    laneScores[i] = 0;
}
