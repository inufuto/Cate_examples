constexpr byte Direction_Right = 0 * 2;
constexpr byte Direction_Left = 1 * 2;
constexpr byte Direction_Down = 2 * 2;
constexpr byte Direction_Up = 3 * 2;

extern sbyte[] DirectionBytes;

extern ptr<sbyte> DirectionPtr(byte direction);