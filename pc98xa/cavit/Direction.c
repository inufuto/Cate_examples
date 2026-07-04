#include "Direction.h"

const sbyte[] DirectionBytes = {
    1, 0,   //Right
    -1, 0,  //Left
    0, 1,   //Down
    0, -1,  //Up
};

ptr<sbyte> DirectionPtr(byte direction)
{
    return DirectionBytes + direction;
}
