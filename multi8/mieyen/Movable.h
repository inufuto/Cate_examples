constexpr byte CoordShift = 0;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Movable_Live = 0x80;
constexpr byte Movable_Loose = 0x20;
constexpr byte Movable_Pattern = 0x07;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

struct Movable
{
    byte x, y;
    byte sprite;
    byte status;
    sbyte dx, dy;
};
struct Direction {
    sbyte dx, dy;
    byte pattern;
};
extern const Direction[] Directions;

extern void LocateMovable(ptr<Movable> pMovable, byte b);
extern void ShowMovable(ptr<Movable> pMovable, byte pattern);
extern void SetDirection(ptr<Movable> pMovable, ptr<Direction> pDirection);
extern bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy);
extern void MoveMovable(ptr<Movable> pMovable);
extern bool IsOnGrid(ptr<Movable> pMovable);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);
