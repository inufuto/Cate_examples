#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Block.h"
#include "Chars.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Man.h"

constexpr byte Size = 2;

Block[MaxBlockCount] Blocks;
ptr<Block> pMovingBlock;
static Movable movable;

extern void _deb();
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
        pBlock->x = ToX(b);
        pBlock->y = ToY(b) - 2;
        pBlock->status = Block_Live;
        ++i;
        ++pBlock;
    }
    while (i < MaxBlockCount) {
        pBlock->status = 0;
        ++i;
        ++pBlock;
    }
    pMovingBlock = nullptr;
    movable.sprite = Sprite_Block;
    movable.xd = 0;
}


static void Draw(ptr<byte> pVram, ptr<Block> pBlock)
{
    byte y = pBlock->y - topY;
    if ((pBlock->status & Block_Up) != 0) {
        --y;
    }
    if (y < WindowHeight) {
        pVram += VramOffset(pBlock->x, y + yMod + StatusHeight);
        byte c = Char_Block;
        repeat (2) {
            repeat (2) {
                pVram = WriteVram(pVram, c);
                c += 2;
            }
            pVram += VramRowSize - 2 * VramStep;
            c -= 3;
            ++y;
        }
    }
}

static void Hide(ptr<Block> pBlock)
{
    byte y = pBlock->y - topY;
    if ((pBlock->status & Block_Up) != 0) {
        --y;
    }
    ptr<byte> pVram = pCurrentPage + VramOffset(pBlock->x, y + yMod + StatusHeight);
    repeat (3) {
        if (y < WindowHeight) {
            repeat (2) {
                pVram = WriteVram(pVram, Char_Space);
            }
            pVram += VramRowSize - 2 * VramStep;
        }
        else {
            pVram += VramRowSize;
        }
        ++y;
    }
}

void DrawBlocks()
{
    ptr<Block> pBlock;
    for (pBlock: Blocks) {
        if (
            (pBlock->status & (Block_Live | Block_Moving)) == Block_Live
        ) {
            Draw(pNextPage, pBlock);
        }
    }
}


bool HitBlock(byte x, byte y)
{
    ptr<Block> pBlock;
    y += 2;
    for (pBlock: Blocks) {
        byte status;
        status = pBlock->status;
        if ((status & Block_Live) != 0) {
            if ((status & Block_Moving) != 0 || (status & Block_Up) != 0) {
                if (y == pBlock->y && IsNear(pBlock->x, x)) {
                    return true;
                }
            }
        }
    }
    return false;
}


void HitUnderBlock()
{
    if (pMovingBlock != nullptr) {
        move:
        movable.y = pMovingBlock->y;
        movable.yd = Man._.yd;
        if (movable.yd <= -CoordRate) {
            pMovingBlock->status = (pMovingBlock->status & ~Block_Moving) | Block_Up;
            HideSprite(movable.sprite);
            Draw(pCurrentPage, pMovingBlock);
            pMovingBlock = nullptr;
        }
        else {
            ShowSprite(&movable, Pattern_Block);
        }
    }
    else {
        ptr<Block> pBlock;
        for (pBlock: Blocks) {
            if ((pBlock->status & (Block_Live | Block_Up)) == Block_Live) {
                if (
                    IsNear(pBlock->x, Man._.x) &&
                    IsNear(pBlock->y, Man._.y - 1)
                ) {
                    pMovingBlock = pBlock;
                    pBlock->status |= Block_Moving;
                    movable.x = pMovingBlock->x;
                    Hide(pBlock);
                    goto move;
                }
            }
        }
    }
}


void HitOverBlock()
{
    if (pMovingBlock != nullptr) {
        move:
        movable.y = pMovingBlock->y;
        movable.yd = Man._.yd;
        if (movable.yd == 0) {
            pMovingBlock->status = ~(Block_Moving | Block_Up);
            HideSprite(movable.sprite);
            Draw(pCurrentPage, pMovingBlock);
            pMovingBlock = nullptr;
        }
        else {
            ShowSprite(&movable, Pattern_Block);
        }
    }
    else {
        ptr<Block> pBlock;
        for (pBlock: Blocks) {
            if ((pBlock->status & (Block_Live | Block_Up)) == (Block_Live | Block_Up)) {
                if (
                    IsNear(pBlock->x, Man._.x) &&
                    IsNear(pBlock->y, Man._.y + 2)
                ) {
                    pMovingBlock = pBlock;
                    pBlock->status |= Block_Moving;
                    movable.x = pMovingBlock->x;
                    Hide(pBlock);
                    goto move;
                }
            }
        }
    }
}
