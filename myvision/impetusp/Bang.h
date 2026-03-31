#include "Movable.h"

struct Bang : Movable {
    byte pattern;
    byte clock;
};

extern Bang[] Bangs;

extern void InitBangs();
extern void StartSmallBang(byte x, byte y);
extern void StartLargeBang(byte x, byte y);
extern void UpdateBangs();
