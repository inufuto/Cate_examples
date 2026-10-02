#include "Movable.h"

struct Bang : Movable {
    byte time;
};

extern Bang[] Bangs;

extern void InitBangs();
extern void StartBang(byte x, byte y);
extern void UpdateBangs();
