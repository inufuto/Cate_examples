constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Actor_PatternMask = 0x0f;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

constexpr byte Movable_x = 0;
constexpr byte Movable_y = 1;
constexpr byte Movable_sprite = 2;
constexpr byte Movable_unitSize = 3;

constexpr byte Actor_status = 3;
constexpr byte Actor_dx = 4;
constexpr byte Actor_dy = 5;
constexpr byte Actor_unitSize = 6;

// struct Movable
// {
//     byte x, y;
//     byte sprite;
// };

// struct Actor : Movable {
//     byte status;
//     sbyte dx, dy;
// };

extern void LocateActor(word pActor, byte b);
extern void MoveActor(word pActor);
extern bool IsNear(word pMovable, byte x, byte y);
