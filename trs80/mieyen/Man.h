#include "Movable.h"

struct Man : Movable {};

extern const byte[] ManChars;
extern Man Man;
extern ptr<Direction> pManDirection;

extern void InitMan();
extern void MoveMan();
// extern void FreezeMan();
extern void LooseMan();
