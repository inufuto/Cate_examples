#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Block.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Man.h"

extern void _deb();

constexpr byte Size = 2;
static const byte[] Chars = { 0xe0, 0xb0, 0xd0, 0x70, };
Block[MaxBlockCount] Blocks;

void InitBlocks()
{
    ptr<byte> pBytes;
    ptr<Block> pBlock;
    byte count, i;
    pBytes = pStage->pBlocks;
    pBlock = Blocks;
    count = pStage->blockCount;
    i = 0;
    while (i < count) {
        byte b;
        b = *pBytes; ++pBytes;
        pBlock->_.x = ToX(b);
        pBlock->_.y = ToY(b) - 2;
        pBlock->_.sprite = i + Sprite_Block;
        pBlock->status = Block_Live;
                                            _deb();
        ShowSprite(&pBlock->_, Chars);
        ++i;
        ++pBlock;
    }
    while (i < MaxBlockCount) {
        pBlock->status = 0;
        ++i;
        ++pBlock;
    }
    // pMovingBlock = nullptr;
}


bool HitBlock(byte x, byte y)
{
    ptr<Block> pBlock;
    y += 2;
    for (pBlock: Blocks) {
        byte status;
        status = pBlock->status;
        if ((status & Block_Live) != 0) {
            if ((status & Block_Up) != 0) {
                if (y - 1 == pBlock->_.y && IsNear(pBlock->_.x, x)) {
                    return true;
                }
            }
        }
    }
    return false;
}


void HitUnderBlock()
{
    ptr<Block> pBlock;
    for (pBlock: Blocks) {
        if ((pBlock->status & (Block_Live | Block_Up)) == Block_Live) {
            if (
                IsNear(pBlock->_.x, Man._.x) &&
                pBlock->_.y == Man._.y - 2
            ) {
                pBlock->status |= Block_Up;
                --pBlock->_.y;
                ShowSprite(&pBlock->_, Chars);
                return;
            }
        }
    }
}


void HitOverBlock()
{
    ptr<Block> pBlock;
    for (pBlock: Blocks) {
        if ((pBlock->status & (Block_Live | Block_Up)) == (Block_Live | Block_Up)) {
            if (
                IsNear(pBlock->_.x, Man._.x) &&
                IsNear(pBlock->_.y - 2, Man._.y)
            ) {
                pBlock->status &= ~Block_Up;
                ++pBlock->_.y;
                ShowSprite(&pBlock->_, Chars);
                return;
            }
        }
    }
}
