#include "Movable.h"

struct Fire : Movable {
    byte time;
};

extern Fire[] Fires;
extern byte FireTime;

extern void InitFires();
extern void StartFire();
extern void MoveFires();
