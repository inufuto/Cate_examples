#include "Block.h"
#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"
#include "Sound.h"
#include "Vram.h"

extern void _deb();

// constexpr byte SpriteColor = 7;
constexpr byte Size = 2;

constexpr byte Block_Live = 0x80;
constexpr byte Block_Destroying = 0x40;
constexpr byte Block_Restarting = 0xc0;
constexpr byte Block_Sleeping = 0x20;
constexpr byte Block_RateMask = 0x0f;
constexpr byte InvalidPosition = 0xff;

FixedBlock[MaxBlockCount] FixedBlocks;
MovingBlock[Sprite_Point - Sprite_Block] MovingBlocks;

static void Locate(ptr<FixedBlock> pFixedBlock)
{
    byte b = pFixedBlock->initialByte;
    byte column = b >> 4;
    byte row = ((b & 0x0f) << 1) + 1;
    pFixedBlock->column = column;
    pFixedBlock->row = row;
    *CellMapPtr(column, row) |= Cell_Block << 4;
}

static void Draw(ptr<FixedBlock> pFixedBlock, byte c)
{
    ptr<byte> pVVram = VVramPtr(
        pFixedBlock->column << CellShift, 
        (pFixedBlock->row << CellShift)
    );
    repeat (2) {
        repeat (2) {
           *pVVram = c; ++pVVram;
           ++c; 
        }
        pVVram += VVramWidth - 2;
    }
}

static void Erase(ptr<FixedBlock> pFixedBlock)
{
    byte column = pFixedBlock->column;
    byte row = pFixedBlock->row;
    ptr<byte> pCell = CellMapPtr(column, row);
    if ((row & 1) == 0) {
        *pCell &= ~Cell_Block;
    }
    else {
        *pCell &= ~(Cell_Block << 4);
    }
    // DrawCellCR(column, row);
}


void InitBlocks()
{
    ptr<byte> pBytes = pStage->pBlocks;
    ptr<FixedBlock> pFixedBlock = FixedBlocks;
    byte count = pStage->blockCount;
    byte i = 0;
    while (i < count) {
        pFixedBlock->initialByte = *pBytes; ++pBytes;
        Locate(pFixedBlock);
        pFixedBlock->status = Block_Live;
        ++i;
        ++pFixedBlock;
    }
    while (i < MaxBlockCount) {
        pFixedBlock->initialByte = InvalidPosition;
        pFixedBlock->status = 0;
        ++i;
        ++pFixedBlock;
    }

    byte sprite = Sprite_Block;
    ptr<MovingBlock> pMovingBlock;
    for (pMovingBlock : MovingBlocks) {
        pMovingBlock->sprite = sprite;
        pMovingBlock->status = 0;
        ++sprite;
    }
}


static void Show(ptr<MovingBlock> pMovingBlock)
{
    ShowSpriteC(pMovingBlock, Char_Block);
}

static ptr<MovingBlock> Start(ptr<FixedBlock> pFixedBlock)
{
    ptr<MovingBlock> pMovingBlock;
    for (pMovingBlock : MovingBlocks) {
        if ((pMovingBlock->status & Movable_Live) == 0) {
            pMovingBlock->x = pFixedBlock->column << CellCoordShift;
            pMovingBlock->y = pFixedBlock->row << CellCoordShift;
            pMovingBlock->status = Movable_Live;
            pMovingBlock->pFixedBlock = pFixedBlock;
            Show(pMovingBlock);
            Erase(pFixedBlock);
            pFixedBlock->status = 0;
            return pMovingBlock;
        }
    }
    return nullptr;
}


bool StartMovingBlock(ptr<FixedBlock> pFixedBlock, sbyte dx)
{
    ptr<MovingBlock> pMovingBlock = Start(pFixedBlock);
    if (pMovingBlock != nullptr) {
        pMovingBlock->dx = dx;
        pMovingBlock->dy = 0;
        return true;
    }
    return false;
}


bool PushBlock(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte x = pMovable->x;
    byte y = pMovable->y;
    if (((x | y) & CellCoordMask) != 0) return false;
    byte column = (x >> CellCoordShift) + dx;
    byte row = (y >> CellCoordShift) + dy;
    if ((GetCell(column, row) & Cell_Block) == 0) return false;
    
    ptr<FixedBlock> pFixedBlock;
    for (pFixedBlock : FixedBlocks) {
        if (
            pFixedBlock->status == Block_Live &&
            pFixedBlock->column == column && pFixedBlock->row == row
        ) {
            if (dx != 0) {
                if (column == 0 || column == ColumnCount - 1) {
                    destroy:
                    pFixedBlock->status = Block_Destroying;
                    pFixedBlock->count = 0;
                    return true;
                }
            }
            else {
                if (row == RowCount - 1) goto destroy;
            }
            byte nextColumn = column + dx;
            if ((GetCell(nextColumn, row) & (Cell_Block | Cell_Item)) != 0) goto destroy;
            return StartMovingBlock(pFixedBlock, dx);
        }
    }
    return false;
}


void UpdateBlocks()
{
    ptr<FixedBlock> pFixedBlock;
    for (pFixedBlock : FixedBlocks) {
        switch (pFixedBlock->status) {
        case Block_Destroying:
            {
                ++pFixedBlock->count;
                if (pFixedBlock->count >= CoordRate * 4) {
                    Erase(pFixedBlock);
                    pFixedBlock->status = Block_Sleeping;
                    pFixedBlock->count = 0;
                }
                // else if ((pFixedBlock->status & CoordMask) == 0) {
                //     byte index = pFixedBlock->count >> CoordShift;
                //     Draw(pFixedBlock, Char_Block + 4 + (index << 2));
                // }
            }
            break;
        case Block_Live:
            {
                byte nextRow = pFixedBlock->row + 1;
                if (nextRow < RowCount) {
                    byte nextCell = GetCell(pFixedBlock->column, nextRow);
                    if (
                        (nextCell & (Cell_Block | Cell_Ceiling)) == 0 &&
                        ((nextRow & 1) != 0 || (nextCell & Cell_Up) == 0)
                    ) {
                        StartMovingBlock(pFixedBlock, 0);
                    }
                }
            }
            break;
        case Block_Restarting:
            {
                ++pFixedBlock->count;
                if (pFixedBlock->count >= CoordRate * 4) {
                    pFixedBlock->status = Block_Live;
                    // Draw(pFixedBlock, Char_Block);
                }
                // else if ((pFixedBlock->status & CoordMask) == 0) {
                //     byte index = pFixedBlock->count >> CoordShift;
                //     Draw(pFixedBlock, Char_Block + 20 + (index << 2));
                // }
            }
            break;
        case Block_Sleeping:
            {
                ++pFixedBlock->count;
                if (pFixedBlock->count >= CoordRate * 4) {
                    pFixedBlock->status = Block_Restarting;
                    pFixedBlock->count = 0;
                    Locate(pFixedBlock);
                }
            }
            break;
        }
    }
}


bool HitToBlock(ptr<Movable> pMovable)
{
    byte x = pMovable->x + pMovable->dx;
    byte y = pMovable->y + pMovable->dy;
    ptr<MovingBlock> pMovingBlock;
    for (pMovingBlock : MovingBlocks) {
        if (
            (pMovingBlock->status & Movable_Live) != 0 &&
            pMovingBlock != pMovable
        ) {
            if (IsNearXY(x, y, pMovingBlock)) return true;
        }
    }
    return false;
}


void MoveBlocks()
{
    ptr<MovingBlock> pMovingBlock;
    for (pMovingBlock : MovingBlocks) {
        if ((pMovingBlock->status & Movable_Live) != 0) {
            bool canMove = true;
            if (((pMovingBlock->x | pMovingBlock->y) & CellCoordMask) == 0) {
                byte column = pMovingBlock->x >> CellCoordShift;
                byte row = pMovingBlock->y >> CellCoordShift;
                if (row < RowCount - 1) {
                    byte lowerCell = GetCell(column, row + 1);
                    if ((lowerCell & (Cell_Ceiling | Cell_Up | Cell_Block)) == 0) {
                        pMovingBlock->dx = 0;
                        pMovingBlock->dy = 1;
                    }
                }
                byte nextColumn = column + pMovingBlock->dx;
                byte nextRow = row + pMovingBlock->dy;
                if (nextColumn >= ColumnCount || nextRow >= RowCount) {
                    stop:
                    HideSprite(pMovingBlock->sprite);
                    pMovingBlock->status = 0;
                    ptr<FixedBlock> pFixedBlock = pMovingBlock->pFixedBlock;
                    pFixedBlock->column = column;
                    pFixedBlock->row = row;
                    pFixedBlock->status = Block_Live;
                    ptr<byte> pCell = CellMapPtr(column, row);
                    if ((row & 1) == 0) {
                        *pCell |= Cell_Block;
                    }
                    else {
                        *pCell |= (Cell_Block << 4);
                    }
                    // DrawCellCR(column, row);
                    goto next;
                }
                byte nextCell = GetCell(nextColumn, nextRow);
                if ((nextCell & (Cell_Item | Cell_Block)) != 0) goto stop;
                if ((nextRow & 1) == 0 && (nextCell & Cell_Up) != 0) goto stop;

                if (pMovingBlock->dy !=0 && HitToBlock(pMovingBlock)) {
                   canMove = false;
                }
            }
            if (canMove) {
                MoveMovable(pMovingBlock);
            }
            Show(pMovingBlock);
            if (((pMovingBlock->x | pMovingBlock->y) & CellMask) == 0) {
                if (HitMonster(pMovingBlock)) {
                    StartPoint(pMovingBlock->x, pMovingBlock->y, pMovingBlock->status & Block_RateMask);
                    ++pMovingBlock->status;
                    Sound_Hit();
                }
            }
        }
        next:
        ;
    }
}


void DrawBlocks()
{
    ptr<FixedBlock> pFixedBlock;
    for (pFixedBlock : FixedBlocks) {
        switch (pFixedBlock->status) {
        case Block_Destroying:
            {
                Draw(pFixedBlock, Char_Block + 4);
            }
            break;
        case Block_Restarting:
            {
                Draw(pFixedBlock, Char_Block + 8);
            }
            break;
        }
    }
}