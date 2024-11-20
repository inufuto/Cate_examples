#include "Movable.h"

constexpr byte Man_Live = 0x80;
constexpr byte Man_Jump = 0x40;

struct Man {
    Movable _;
    sbyte dx, dy;
    byte pattern;
    byte status;
    byte clock;
};

extern const byte[] ManChars;
extern Man Man;

extern void InitMan();
extern void MoveMan();
extern void LooseMan();
extern bool IsManOnLift(byte x, byte y);
extern bool MoveManOnLift(ptr<Movable> pLift, sbyte dx, byte oldY);
