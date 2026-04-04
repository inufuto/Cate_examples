#include "Movable.h"

constexpr byte Type_Block = 0x01;
constexpr byte Type_Bomb = 0x02;
constexpr byte Type_TimeBomb = 0x03;

struct FallingBlock {
    Movable _;
    byte flags;
};

extern FallingBlock[] FallingBlocks;
extern byte[] Ground;

extern void InitBlocks();
extern bool StartFallingBlock(byte x, byte y, byte type);
extern void MoveBlocks();
extern bool HitBlock(byte bulletX, byte bulletY);
// extern void SetGroundCell(byte x, byte left, byte right);
extern void UpdateBlocks();
