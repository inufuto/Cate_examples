constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

struct Movable
{
    byte x, y;
    byte sprite;
};

extern byte NextCell;

extern void LocateMovable(ptr<Movable> pMovable, byte b);
extern bool IsOnGrid(ptr<Movable> pMovable);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);
extern bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy);
