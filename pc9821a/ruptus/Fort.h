#include "Stage.h"

struct Fort {
    byte x, y;
    sbyte life;
    byte flags;
};

extern Fort[] Forts;
extern byte FortCount;
extern void InitForts(ptr<Position> pPositions, byte count);
extern void DrawForts();
extern bool HitFort(byte x, byte y, byte size);
extern ptr<Fort> NearFort(byte x, byte y, byte size);
extern void DrawFortsOnRader();
