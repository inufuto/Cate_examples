#include "Movable.h"

struct Bang {
    Movable _;
    ptr<byte> pChars;
    byte clock;
};

extern Bang[] Bangs;

extern void InitBangs();
extern void StartSmallBang(byte x, byte y);
extern void StartLargeBang(byte x, byte y);
extern void StartBang(byte x, byte y, bool large);
extern void UpdateBangs();
