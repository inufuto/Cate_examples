#include "Movable.h"

constexpr byte Man_Attacking = 0x40;

struct Man : Actor {
    byte count;
};
extern const byte[] ManChars;

extern Man Man;
extern Movable Sword;

extern void InitMan();
extern void MoveMan();
extern void HitMan(byte x, byte y);
extern void ShowMan();