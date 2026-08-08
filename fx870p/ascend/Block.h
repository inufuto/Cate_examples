constexpr byte Block_Live = 0x80;
constexpr byte Block_Up = 0x20;

struct Block {
    Movable _;
    byte status;
};

extern Block[] Blocks;
extern ptr<Block> pMovingBlock;

extern void InitBlocks();
extern void DrawBlocks();
extern bool HitBlock(byte x, byte y);
extern void HitUnderBlock();
extern void HitOverBlock();
