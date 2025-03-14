struct Direction {
    sbyte dx, dy;
};

constexpr byte Direction_Up = 0;
constexpr byte Direction_UpRight = 1;
constexpr byte Direction_Right = 2;
constexpr byte Direction_DownRight = 3;
constexpr byte Direction_Down = 4;
constexpr byte Direction_DownLeft = 5;
constexpr byte Direction_Left = 6;
constexpr byte Direction_UpLeft = 7;

extern const Direction[] Directions;

extern byte NewDirection(byte old, byte target);