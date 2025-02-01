constexpr byte CoordShift = 0;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Movable_Live = 0x80;
constexpr byte Movable_Fall = 0x40;

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
extern byte NextCell;

extern void LocateMovable(ptr<Movable> pMovable, byte b);
extern bool IsNearXY(byte x, byte y, ptr<Movable> p2);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);
extern void MoveMovable(ptr<Movable> pMovable);
extern bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy);
extern bool FallMovable(ptr<Movable> pMovable);
extern bool InRange(ptr<Movable> pMovable, sbyte dx, sbyte dy);
