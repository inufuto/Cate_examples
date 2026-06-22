#include "Monster.h"

extern Movable[] Chasers;

extern ptr<byte> InitChasers(ptr<byte> pStage);
extern void StartChasers();
extern void MoveChasers();
extern void HitChaser(ptr<Movable> pMovable);
extern bool AdjacentChaser(ptr<Movable> pMovable, byte x, byte y);