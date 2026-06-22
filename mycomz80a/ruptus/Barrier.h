#include "Stage.h"

struct Barrier {
    byte startX, startY;
    byte endX, endY;
    byte flags;
};

extern void InitBarriers(ptr<BarrierDef> pDef, byte count);
extern void DrawBarriers();
extern bool NearBarrier(byte x, byte y, byte size);
extern bool HitBarrier(byte x, byte y, byte size);