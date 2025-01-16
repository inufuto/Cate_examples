constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Movable_Live = 0x80;
constexpr byte Movable_Loose = 0x20;
constexpr byte Movable_Pattern = 0x07;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

// struct Movable
// {
//     byte x, y;
//     byte sprite;
//     byte status;
//     sbyte dx, dy;
// };
constexpr byte Movable_x = 0;
constexpr byte Movable_y = 1;
constexpr byte Movable_sprite = 2;
constexpr byte Movable_status = 3;
constexpr byte Movable_dx = 4;
constexpr byte Movable_dy = 5;
constexpr byte Movable_unitSize = 6;
struct Direction {
    sbyte dx, dy;
    byte pattern;
};
extern const Direction[] Directions;

extern void LocateMovable(word pMovable, byte b);
extern void ShowMovable(word pMovable, byte pattern, byte color);
extern void SetDirection(word pMovable, ptr<Direction> pDirection);
extern bool CanMove(word pMovable, sbyte dx, sbyte dy);
extern void MoveMovable(word pMovable);
extern bool IsOnGrid(word pMovable);
extern bool IsNear(word p1, word p2);
