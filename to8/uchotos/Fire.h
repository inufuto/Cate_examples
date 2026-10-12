#include "Movable.h"

struct Fire : Movable {
    sbyte dx;
    byte time;
};

extern Fire[] Fires;
extern byte FireTime;
extern bool FireMoved;

extern void InitFires();
extern void MoveFires();