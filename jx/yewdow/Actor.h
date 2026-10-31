#include "Movable.h"

constexpr byte Actor_SeqMask = 0x01;
constexpr byte Actor_DirectionMask = 0x06;
constexpr byte Actor_PatternMask = Actor_DirectionMask | Actor_SeqMask;
constexpr byte Actor_Live = 0x08;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 2;
constexpr byte Direction_Up = 4;
constexpr byte Direction_Down = 6;

struct Actor
{
    Movable _;
    sbyte dx, dy;
    byte status;
    byte clock;
};

extern const sbyte[] DirectionElements;

extern void SetDirection(ptr<Actor> pActor, byte direction);
extern bool CanMove(ptr<Actor> pActor, byte direction);
extern void Move(ptr<Actor> pActor);