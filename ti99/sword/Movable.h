constexpr byte CoordShift = 2;
constexpr byte CoordRate = 1 << CoordShift;
constexpr byte CoordMask = CoordRate - 1;

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

extern void LocateActor(ptr<Actor> pActor, byte b);
extern void MoveActor(ptr<Actor> pActor);
extern bool IsNear(ptr<Movable> pMovable, byte x, byte y);
