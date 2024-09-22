#include "Direction.h"
#include "Vram.h"

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


const Course[] Courses = {
    {
        0, 3, 
        Direction_Right, (WindowWidth - 24) / 2,
        { 12, 4, 5, 1, 4, 5, 2, 12, 10, 15, 7, InvalidElement }
    },
    {
        WindowWidth - 2, 3, 
        Direction_Left, (WindowWidth - 24) / 2,
        { 13, 8, 9, 3, 8, 9, 0, 13, 6, 15, 11, InvalidElement }
    },
    {
        0, 11, 
        Direction_Right, (WindowWidth - 24) / 2,
        { 12, 10, 11, 8, 9, 12, 10, 15, InvalidElement }
    },
    {
        WindowWidth - 2, 11, 
        Direction_Left, (WindowWidth - 24) / 2,
        { 13, 6, 7, 4, 5, 13, 6, 15, InvalidElement }
    },
    {
        0, 19, 
        Direction_Right, (WindowWidth - 24) / 2,
        { 12, 3, 2, 12, 10, 15, InvalidElement }
    },
    {
        WindowWidth - 2, 19, 
        Direction_Left, (WindowWidth - 24) / 2,
        { 13, 1, 0, 13, 6, 15, InvalidElement }
    },
    {
        12, 0, 
        Direction_Down, 4,
        { 14, 14, InvalidElement }
    },
    {
        13, WindowHeight - 1, 
        Direction_Up, WindowHeight - 20,
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