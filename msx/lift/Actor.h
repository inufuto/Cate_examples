constexpr byte Actor_SeqMask = 0x03;
constexpr byte Actor_Live = 0x80;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 2;

struct Actor 
{
    Movable _;
    sbyte dx, dy;
    byte status;
    byte c;
};

extern bool CanMoveTo(ptr<Actor> pActor, sbyte dx);
extern bool IsOnLift(ptr<Actor> pActor, ptr<Movable> pLift);
extern bool MoveOnLift(ptr<Actor> pActor, ptr<Movable> pLift);
extern void Fall(ptr<Actor> pActor);

