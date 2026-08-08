#include "Movable.h"

struct FixedBlock {
    byte initialByte;
    byte column, row;
    byte status;
    byte count;
};
struct MovingBlock : Movable
{
    ptr<FixedBlock> pFixedBlock;
};

extern FixedBlock[] FixedBlocks;

extern void InitBlocks();
extern void StartDestroyingBlock(ptr<FixedBlock> pFixedBlock);
extern bool PushBlock(ptr<Movable> pMovable, sbyte dx, sbyte dy);
extern void UpdateBlocks();
extern bool HitToBlock(ptr<Movable> pMovable);
extern void MoveBlocks();
extern void DrawBlocks();
