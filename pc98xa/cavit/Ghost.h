#include "Monster.h"

constexpr byte Ghost_Status_Throgh = 0x10;
constexpr byte Ghost_Status_Wait = 0x20;

extern Movable[] Ghosts;

extern ptr<byte> InitGhosts(ptr<byte> pStage);
extern void StartGhosts();
extern void MoveGhosts();
extern void HitGhost(ptr<Movable> pMovable);
extern bool AdjacentGhost(byte sprite, byte x, byte y);
