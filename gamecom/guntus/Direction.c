#include "Direction.h"
#include "VVram.h"

const Direction[] Directions = {
    { 0, -1 }, // Direction_Up
    { 1, -1 }, // Direction_UpRight
    { 1, 0 }, // Direction_Right
    { 1, 1 }, // Direction_DownRight
    { 0, 1 }, // Direction_Down
    { -1, 1 }, // Direction_DownLeft
    { -1, 0 }, // Direction_Left
    { -1, -1 }, // Direction_UpLeft
};

const CourseElement[] CourseElements = {
    {{ // 0
        Direction_Right, Direction_DownRight, Direction_Down, Direction_DownLeft
    }},
    {{ // 1
        Direction_Left, Direction_UpLeft, Direction_Up, Direction_UpRight
    }},
    {{ // 2
        Direction_Left, Direction_DownLeft, Direction_Down, Direction_DownRight
    }},
    {{ // 3
        Direction_Right, Direction_UpRight, Direction_Up, Direction_UpLeft
    }},
    {{ // 4
        Direction_Right, Direction_DownRight, Direction_DownRight, Direction_Down
    }},
    {{ // 5
        Direction_Down, Direction_DownLeft, Direction_DownLeft, Direction_Left
    }},
    {{ // 6
        Direction_Left, Direction_UpLeft, Direction_UpLeft, Direction_Up
    }},
    {{ // 7
        Direction_Up, Direction_UpRight, Direction_UpRight, Direction_Right
    }},
    {{ // 8
        Direction_Left, Direction_DownLeft, Direction_DownLeft, Direction_Down
    }},
    {{ // 9
        Direction_Down, Direction_DownRight, Direction_DownRight, Direction_Right
    }},
    {{ // 10
        Direction_Right, Direction_UpRight, Direction_UpRight, Direction_Up
    }},
    {{ // 11
        Direction_Up, Direction_UpLeft, Direction_UpLeft, Direction_Left
    }},
    {{ // 12
        Direction_Right, Direction_Right, Direction_Right, Direction_Right
    }},
    {{ // 13
        Direction_Left, Direction_Left, Direction_Left, Direction_Left
    }},
    {{ // 14
        Direction_Down, Direction_Down, Direction_Down, Direction_Down
    }},
    {{ // 15
        Direction_Up, Direction_Up, Direction_Up, Direction_Up
    }},
};

constexpr byte HighY = 2;
constexpr byte MiddleY = 6;
constexpr byte LowY = 10;

const Course[] Courses = {
    {
        0, HighY, 
        Direction_Right, (VVramWidth - 16) / 2,
        { 12, 4, 5, 1, 3, 8, 9, 10, 7, InvalidElement }
    },
    {
        VVramWidth - 2, HighY, 
        Direction_Left, (VVramWidth - 16) / 2,
        { 13, 8, 9, 3, 1, 4, 5, 6, 11, InvalidElement }
    },
    {
        0, MiddleY, 
        Direction_Right, (VVramWidth - 16) / 2,
        { 12, 3, 8, 9, 12, 10, 15, InvalidElement }
    },
    {
        VVramWidth - 2, MiddleY, 
        Direction_Left, (VVramWidth - 16) / 2,
        { 13, 1, 4, 5, 13, 6, 15, InvalidElement }
    },

    {
        0, LowY,
        Direction_Right, (VVramWidth - 16) / 2,
        { 12, 3, 2, 12, 10, 15, InvalidElement }
    },
    {
        VVramWidth - 2, LowY,
        Direction_Left, (VVramWidth - 16) / 2,
        { 13, 1, 0, 13, 6, 15, InvalidElement }
    },
    {
        12, 0,
        Direction_Down, 2,
        { 14, 14, InvalidElement }
    },
    {
        13, VVramHeight - 1, 
        Direction_Up, VVramHeight - 14,
        { 15, 15, InvalidElement }
    },
};


byte ToDirection(sbyte dx, sbyte dy)
{
    if (dx == 0) {
        if (dy < 0) return Direction_Up;
        return Direction_Down;
    }
    if (dx < 0) {
        if (dy == 0) return Direction_Left;
        if (dy < 0) return Direction_UpLeft;
        return Direction_DownLeft;
    }
    if (dy == 0) return Direction_Right;
    if (dy < 0) return Direction_UpRight;
    return Direction_DownRight;



    // ptr<Direction> pDirection;
    // byte direction;
    // direction = 0;
    // for (pDirection: Directions) {
    //     if (dx == pDirection->dx && dy == pDirection->dy) {
    //         return direction;
    //     }
    //     ++direction;
    // }
    // return 0;
}