#include "Movable.h"

extern ptr<byte> InitMonsters(ptr<Movable> pMonster, byte maxCount, byte sprite, ptr<byte> pStage);
extern void StartMonsters(ptr<Movable> pMonster, byte count, ptr<byte> pStage);
extern void HitMonsterInArray(ptr<Movable> pMonster, byte count, ptr<Movable> pRock);
extern bool AdjacentOtherInArray(
    ptr<Movable> pMonster, byte count, 
    byte sprite, byte x, byte y
);
extern bool AdjacentOther(ptr<Movable> pMonster);
extern void CatchMan(ptr<Movable> pMonster);