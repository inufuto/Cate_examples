constexpr byte CoordShift = 1;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

constexpr byte Movable_Live = 0x80;
constexpr byte Actor_Fall = 0x40;
constexpr byte Actor_PatternMask = 0x0f;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

struct Movable
{
    byte x, y;
    byte sprite;
};

struct Actor : Movable {
    byte status;
    sbyte dx, dy;
};

extern byte NextCell;

extern void LocateActor(ptr<Actor> pActor, byte b);
extern void MoveActor(ptr<Actor> pActor);
extern bool CanMove(ptr<Actor> pActor, sbyte dx, sbyte dy);
extern bool FallActor(ptr<Actor> pActor);
extern bool InRange(ptr<Movable> pMovable, sbyte dx, sbyte dy);
extern bool IsNear(ptr<Movable> p1, ptr<Movable> p2);