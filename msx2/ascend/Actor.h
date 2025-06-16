constexpr byte Actor_SeqMask = 0x03;
constexpr byte Actor_Live = 0x80;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 2;

struct Actor 
{
    Movable _;
    sbyte dx, dy;
    byte status;
    byte pattern;
    // byte clock;
};

extern void MoveActor(ptr<Actor> pActor);
extern void MoveActorY(ptr<Actor> pActor);
extern bool CanMove(ptr<Actor> pActor, sbyte dx);
extern void ShowEnemy(ptr<Actor> pFire, byte color);
