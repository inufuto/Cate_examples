constexpr byte CoordShift = 3;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte HitRange = (CoordRate * 4 / 3);

constexpr byte Movable_Live = 0x80;

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

extern void LocateMovable(ptr<Movable> pMovable, byte b);
extern void MoveMovable(ptr<Movable> pMovable);
extern bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy);
