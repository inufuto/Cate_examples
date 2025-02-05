#include "Movable.h"
#include "Block.h"
#include "Sprite.h"
#include "Stage.h"
#include "Vram.h"
#include "Chars.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"
#include "Math.h"
#include "Sound.h"
#include "VVram.h"

constexpr byte Count = Sprite_Point - Sprite_Block;
// constexpr byte Color = 7;
constexpr byte MaxRate = 3;

constexpr byte Status_None = 0x00;
constexpr byte Status_Move = 0x10;
constexpr byte Status_Start = 0x20;
constexpr byte Status_Destroy = 0x30;
constexpr byte Status_Mask = 0x30;
constexpr byte Mans = 0x40;

Movable[Count] Blocks;
static byte startCount;
static byte startX, startY;

void InitBlocks()
{
    ptr<Movable> pBlock;
    byte sprite;

    sprite = Sprite_Block;
    for (pBlock : Blocks) {
        pBlock->sprite = sprite;
        pBlock->status = Status_None;
        ++sprite;
    }
    startCount = 0;
    startX = 1;
    startY = 1;
}


static void ShowDestroy(ptr<Movable> pBlock)
{
    VPut2CXY(
        pBlock->x, pBlock->y,
        Char_Block + 4
    );
}


static void ShowMove(ptr<Movable> pBlock)
{
    ShowSpriteC(pBlock, Char_Block);
}


static void ShowStart(ptr<Movable> pBlock)
{
    VPut2CXY(
        pBlock->x, pBlock->y,
        Char_Block + 8
    );
}


static void DestroyBlock(byte x, byte y)
{
    ptr<Movable> pBlock;
    for (pBlock : Blocks) {
        if ((pBlock->status & Status_Mask) == Status_None) {
            pBlock->status = Status_Destroy;
            pBlock->x = x;
            pBlock->y = y;
            pBlock->clock = 0;
            SetCell(x >> 1, y >> 1, Cell_Wall);
            ShowDestroy(pBlock);
            return;
        }
    }   
}


static void MoveBlock(byte x, byte y, sbyte dx, sbyte dy, byte flag)
{
    ptr<Movable> pBlock;
    for (pBlock : Blocks) {
        if ((pBlock->status & Status_Mask) == Status_None) {
            pBlock->status = Status_Move | flag;
            pBlock->x = x;
            pBlock->y = y;
            pBlock->dx = dx;
            pBlock->dy = dy;
            pBlock->clock = 0;
            pBlock->moveCount = 0;
            SetCell(x >> MapShift, y >> MapShift, Cell_None);
            ShowMove(pBlock);
            return;
        }
    }
}


bool PushBlock(ptr<Movable> pMovable)
{
    if ((pMovable->status & Movable_Pushing) == 0) {
        ptr<sbyte> pElements;
        byte direction, cell, x, y;
        sbyte dx, dy;
        direction = pMovable->status & Movable_DirectionMask;
        pElements = DirectionElements + direction;
        dx = *pElements;
        ++pElements;
        dy = *pElements;
        x = (pMovable->x >> CoordShift) + dx + dx;
        y = (pMovable->y >> CoordShift) + dy + dy;
        cell = GetCell(x >> 1, y >> 1);
        if (cell == Cell_Block) {
            byte nx, ny, next;
            nx = (x >> 1) + dx;
            ny = (y >> 1) + dy;
            if (GetCell(nx, ny) == Cell_None) {
                MoveBlock(
                    x << CoordShift, y << CoordShift,
                    dx, dy, 
                    pMovable == &Man ? Mans : 0
                );
            }
            else {
                DestroyBlock(x, y);
            }
            pMovable->status |= Movable_Pushing;
            return true;
        }
    }    
    return false;
}


void StartBlock()
{
    ptr<Movable> pBlock;
    ++startCount;
    if (startCount < 64) return;
    startCount = 0;
    if (GetCellOrMovable(nullptr, startX, startY) != Cell_None) goto next;
    for (pBlock : Blocks) {
        if ((pBlock->status & Status_Mask) == Status_None) {
            pBlock->status = Status_Start;
            pBlock->x = startX << 1;
            pBlock->y = startY << 1;
            pBlock->clock = 0;
            SetCell(startX, startY, Cell_Wall);
            ShowStart(pBlock);
            break;
        }
    }
    next:
    ++startX;
    if (startX >= MapWidth - 1) {
        startX = 1;
        ++startY;
        if (startY >= MapHeight - 1) {
            startY = 1;
        }
    }
}


void UpdateBlocks()
{
    ptr<Movable> pBlock;
    for (pBlock : Blocks) {
        byte status; 
        status = pBlock->status & Status_Mask;
        switch (status) {
        case Status_None:
            break;
        case Status_Destroy:
            ++pBlock->clock;
            if (pBlock->clock >= 4 * 8) {
                pBlock->status = Status_None;
                SetCell(pBlock->x >> 1, pBlock->y >> 1, Cell_None);
            }
            else {
                ShowDestroy(pBlock);
            }
            break;
        case Status_Move:
            if (IsOnGrid(pBlock)) {
                byte x, y;
                x = pBlock->x >> MapShift;
                y = pBlock->y >> MapShift;
                if (GetCellOrBlock(pBlock, x + pBlock->dx, y + pBlock->dy) != Cell_None) {
                    SetCell(x, y, Cell_Block);
                    pBlock->status = Status_None;
                    HideSprite(pBlock->sprite);
                    continue;
                }
            }
            ++pBlock->moveCount;
            if ((pBlock->moveCount & MoveCountMask) == 0) {
                pBlock->x += pBlock->dx;
                pBlock->y += pBlock->dy;
                ShowMove(pBlock);
                HitMan(pBlock);
                HitMonster(pBlock);
            }
            break;
        case Status_Start:
            ++pBlock->clock;
            if (pBlock->clock >= 4 * 4 * 8) {
                pBlock->status = Status_None;
                SetCell(pBlock->x >> 1, pBlock->y >> 1, Cell_Block);
            }
            else {
                ShowStart(pBlock);
            }
            break;
        }
    }
}


bool IsNearMovingBlock(ptr<Movable> pMovable, byte x, byte y)
{
    ptr<Movable> pBlock;
    for (pBlock : Blocks) {
        if ((pBlock->status & Status_Mask) != Status_Move) continue;
        if (pMovable != pBlock) {
            byte thisX, thisY;
            thisX = pBlock->x >> MapShift;
            thisY = pBlock->y >> MapShift;
            if (x == thisX && y == thisY) return true;
            if (!IsOnGrid(pBlock)) {
                thisX += pBlock->dx;
                thisY += pBlock->dy;
                if (x == thisX && y == thisY) return true;
            }
        }
    }
    return false;
}


bool AnyBlockMoving()
{
    ptr<Movable> pBlock;
    for (pBlock : Blocks) {
        if ((pBlock->status & Status_Mask) == Status_Move) return true;
    }
    return false;   
}


void OnHitBlock(ptr<Movable> pBlock, ptr<Movable> pMonster)
{
    if ((pBlock->status & Mans) != 0) {
        byte rate;
        rate = pBlock->clock;
        StartPoint(pMonster->x, pMonster->y, rate);
        if (rate < MaxRate + 1) {
            ++rate;
            pBlock->clock = rate;
        }
        // UpdateSprites();
        DrawAll();
        Sound_Hit();
    }
}
