#include "Movable.h"

struct ManDirection : Direction {
    byte key;
};
struct Man : Movable {
    ptr<ManDirection> pDirection;
};

extern Man Man;

extern void InitMan();
extern void MoveMan();
extern void SlideMan(sbyte dx, sbyte dy);
extern void LooseMan();
