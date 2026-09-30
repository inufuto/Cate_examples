constexpr byte Block_Live = 0x80;
constexpr byte Block_Moving = 0x40;
constexpr byte Block_Up = 0x20;

struct Block {
    byte x,y;
    byte status;
};

extern Block[] Blocks;
extern ptr<Block> pMovingBlock;

extern void InitBlocks();
extern void DrawBlocks();
extern bool HitBlock(byte x, byte y);
extern void HitUnderBlock();
extern void HitOverBlock();
