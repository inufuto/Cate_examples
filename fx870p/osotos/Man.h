#include "Movable.h"

struct Man : Movable {};

extern Man Man;
extern const byte[] ManChars;

extern void InitMan();
extern void MoveMan();
extern void LooseMan();
extern bool HitToMan(ptr<Movable> pMovable);
