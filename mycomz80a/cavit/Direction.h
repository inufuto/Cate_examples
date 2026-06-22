constexpr byte Direction_Right = 0 << 1;
constexpr byte Direction_Left = 1 << 1;
constexpr byte Direction_Down = 2 << 1;
constexpr byte Direction_Up = 3 << 1;

extern sbyte[] DirectionBytes;

extern ptr<sbyte> DirectionPtr(byte direction);