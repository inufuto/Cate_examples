#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Block.h"
#include "Chars.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Man.h"

// extern void DebPrintDX(word w);
// extern void DebPrintC(byte b);

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


static void Draw(ptr<Block> pBlock)
{
    byte y;
    y = pBlock->y - topY;
    if ((pBlock->status & Block_Up) != 0) {
        --y;
    }
    if (y < WindowHeight - 1) {
        ptr<byte> pBackground;
        byte c;
        pBackground = Background + VramOffset(pBlock->x, y + yMod);
        c = Char_Block;
        repeat (2) {
            if (y < WindowHeight - 1) {
                repeat (2) {
                    *pBackground = c; ++pBackground;
                    ++c;
                }
                pBackground += StageWidth - 2;
            }
            else {
                pBackground += StageWidth;
            }
            ++y;
        }
    }
}

static void Hide(ptr<Block> pBlock)
{
    byte y;
    ptr<byte> pBackground;
    y = pBlock->y - topY;
    if ((pBlock->status & Block_Up) != 0) {
        --y;
    }
    pBackground = Background + VramOffset(pBlock->x, y + (topY & 3));
    repeat (2) {
        if (y < WindowHeight - 1) {
            repeat (2) {
                *pBackground = Char_Space; ++pBackground;
            }
            pBackground += StageWidth - 2;
        }
        else {
            pBackground += StageWidth;
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
            Draw(pBlock);
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
    bool changed;
    changed = false;
    if (pMovingBlock != nullptr) {
        move:
        movable.y = pMovingBlock->y;
        movable.yd = Man._.yd;
        if (movable.yd <= -CoordRate) {
            pMovingBlock->status = (pMovingBlock->status & ~Block_Moving) | Block_Up;
            HideSprite(movable.sprite);
            Draw(pMovingBlock);
            changed = true;
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
                    changed = true;
                    goto move;
                }
            }
        }
    }
    if (changed) {
        FillBackground();
        BackgroundToVram();
        UpdateOffset();
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
            Draw(pMovingBlock);
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
