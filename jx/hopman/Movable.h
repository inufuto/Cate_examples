constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Movable_Live = 0x80;
constexpr byte Movable_Fall = 0x40;

struct Movable
{
    byte x, y;
    byte xd;
    byte sprite;
};

extern byte GetCellAtFloor(ptr<Movable> pMovable, byte floor);
extern byte GetCellAt(ptr<Movable> pMovable);
extern bool IsFloor(ptr<Movable> pMovable, byte floor);
extern bool IsOnFloor(ptr<Movable> pMovable);
extern bool IsNeedle(ptr<Movable> pMovable, byte floor);
extern bool IsOnNeedle(ptr<Movable> pMovable);
extern bool CanMoveX(ptr<Movable> pMovable, sbyte dx);
extern bool MoveX(ptr<Movable> pMovable, sbyte dx);
extern bool IsNexrX(byte x1, byte x2);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);
