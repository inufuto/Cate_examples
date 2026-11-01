constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte MapShift = CoordShift + 1;
constexpr byte MapRate = CoordRate * 2;
constexpr byte MapMask = MapRate - 1;

constexpr byte Movable_Status_None = 0x00;
constexpr byte Movable_Status_Live = 0x01;
constexpr byte Movable_Direction_Mask = 0x06;
constexpr byte Movable_Status_CanMove = 0x08;

struct Movable
{
    byte x, y;
    sbyte dx, dy;
    byte sprite;
    byte status;
};

extern byte MovableX(byte b);
extern byte MovableY(byte b);
extern void SetDirection(ptr<Movable> pMovable, byte direction);
extern bool CanChangeDirection(ptr<Movable> pMovable);
extern bool MoveMovable(ptr<Movable> pMovable);
// extern bool IsNearXYXY(byte x1, byte y1, byte x2, byte y2);
extern bool IsNearXY(ptr<Movable> pMovable, byte x, byte y);
extern bool IsNear(ptr<Movable> p1, ptr<Movable>p2);
extern bool IsVeryNear(ptr<Movable> p1, ptr<Movable> p2);
extern bool IsOnGrid(ptr<Movable> pMovable);
