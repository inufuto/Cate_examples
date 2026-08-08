#include "Direction.h"

const Direction[] Directions = {
    { 0, -1 },
    { 1, -1 },
    { 1, 0 },
    { 1, 1 },
    { 0, 1 },
    { -1, 1 },
    { -1, 0 },
    { -1, -1 },
};

const Direction[] BulletOffsets = {
    { -1, -1 },
    { 0, -1 },
    { 0, -1 },
    { 0, 0 },
    { -1, 0 },
    { -1, 0 },
    { -1, -1 },
    { -1, -1 },
};


byte NewDirection(byte old, byte target) 
{
    byte diff;
    if (target == old) return old;
    diff = (target - old) & 7;
    if (diff <= 4) {
        return (old + 1) & 7;
    }
    else {
        return (old - 1) & 7;
    }
}