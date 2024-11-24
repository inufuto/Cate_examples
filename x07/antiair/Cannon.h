#include "Movable.h"

extern const byte[] CannonChars;
extern Movable Cannon;
extern bool CannonLive;

extern void InitCannon();
extern void MoveFighter();
extern bool HitCannon(byte x, byte y, byte width);