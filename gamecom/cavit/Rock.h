#include "Fixed.h"
#include "Movable.h"

extern Fixed[] FixedRocks;
extern Movable[] FallingRocks;

extern ptr<byte> InitRocks(ptr<byte> pStage);
extern void DrawRocks();
extern void TestRocks();
extern void MoveRocks();
extern bool IsNearRock(ptr<Movable> pMovable, byte x, byte y);
extern void OnHitRock(ptr<Movable> pFallingRock, ptr<Movable> pMonster);
extern bool AdjacentRock(ptr<Movable> pMovable, byte x, byte y);
