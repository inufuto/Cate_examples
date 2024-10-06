#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Block.h"
#include "Chars.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Man.h"
#include "VVram.h"

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
    constexpr byte Char_Space_LeftUpperBlock0 = 0x56;
    constexpr byte Char_Space_UpperBlock1 = 0x05;
    constexpr byte Char_Space_RightUpperBlock0 = 0x59;
    constexpr byte Char_LeftUpperBlock_LeftLowerBlock0 = 0x65;
    constexpr byte Char_LeftUpperBlock_LeftLowerBlock1 = 0x66;
    constexpr byte Char_RightUpperBlock_RightLowerBlock0 = 0x95;
    constexpr byte Char_RightUpperBlock_RightLowerBlock1 = 0x99;
    constexpr byte Char_LowerBlock_Space1 = 0x50;
    static const byte[] Chars = {
        Char_Space_LeftUpperBlock0, Char_Space_RightUpperBlock0,
        Char_LeftUpperBlock_LeftLowerBlock0, Char_RightUpperBlock_RightLowerBlock0,
        Char_Space, Char_Space,
        //
        Char_Space_UpperBlock1, Char_Space_UpperBlock1,
        Char_LeftUpperBlock_LeftLowerBlock1, Char_RightUpperBlock_RightLowerBlock1,
        Char_LowerBlock_Space1, Char_LowerBlock_Space1,
    };
    byte y;
    y = pBlock->y - topY;
    if ((pBlock->status & Block_Up) != 0) {
        --y;
    }
    if (y < VVramHeight) {
        ptr<byte> pVVram;
        ptr<byte> pChars;
        pVVram = VVramPtr(pBlock->x, y);
        pChars = Chars + (word)(((dotOffset << 1) + dotOffset) << 1);
        repeat (3) {
            if (y < VVramHeight) {
                repeat (2) {
                    *pVVram = *pChars;
                    ++pVVram;
                    ++pChars;
                }
                pVVram += VVramWidth - 2;
            }
            else {
                pVVram += VVramWidth;
            }
            ++y;
        }
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
    if (pMovingBlock != nullptr) {
        move:
        movable.y = pMovingBlock->y;
        movable.yd = Man._.yd;
        if (movable.yd <= -CoordRate) {
            pMovingBlock->status = (pMovingBlock->status & ~Block_Moving) | Block_Up;
            HideSprite(movable.sprite);
            // Draw(pMovingBlock);
            BackgroundChanged = true;
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
                    // Hide(pBlock);
                    BackgroundChanged = true;
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
            // Draw(pMovingBlock);
            BackgroundChanged = true;
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
                    // Hide(pBlock);
                    BackgroundChanged = true;
                    goto move;
                }
            }
        }
    }
}
