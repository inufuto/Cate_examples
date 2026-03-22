extern Movable[] Blocks;


extern void InitBlocks();
extern bool PushBlock(ptr<Movable> pMovable);
extern void StartBlock();
extern void UpdateBlocks();
extern bool IsNearMovingBlock(ptr<Movable> pMovable, byte x, byte y);
extern bool AnyBlockMoving();
extern void OnHitBlock(ptr<Movable> pBlock, ptr<Movable> pMonster);
