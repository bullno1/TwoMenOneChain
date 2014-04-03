gridPos += velocity;
if(gridPos == 0 || gridPos == NUM_LANES - 1)
{
    velocity = -velocity;
}
