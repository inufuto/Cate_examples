#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "VVram.h"
#include "Sprite.h"
#include "Status.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Math.h"
#include "Sound.h"
#include "Vram.h"

extern void _deb();

static const byte[] SpaceChars = {
    Char_Space, Char_Space, Char_Space, Char_Space,
};
static const byte[] StarChars = {
    Char_Star + 0, Char_Star + 1, Char_Star + 2, Char_Star + 3,
};

ptr<Stage> pStage;
byte[ColumnCount * RowCount] PanelMap;
byte StarCount;
byte MovingPanel, PanelX, PanelY, PanelDirection;
ptr<byte> pMoving;
static byte MaxTime;

byte ToCoord(byte a)
{
    return (a << 2) + 1;
}


void InitStage()
{
    ptr<Stage> p;
    byte i, j;
    MaxTime = 60;
    p = Stages;
    i = 0;
    j = 0;
    while (i < CurrentStage) {
        ++p;
        ++i;
        ++j;
        if (j >= StageCount) {
            p = Stages;
            j = 0;
            if (MaxTime >= 30) {
                MaxTime -= 5;
            }
        }
    }
    pStage = p;
}


void InitTrying()
{
    RndIndex = 0;
    {
        StageTime = MaxTime;
        {
            byte i;
            i = pStage->monsterCount;
            do {
                StageTime += 30;
                --i;
            } while (i != 0);
        }
    }
    CopyMemory(PanelMap, pStage->bytes, ColumnCount * RowCount);
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    {
        StarCount = 0;
        ptr<byte> pMap = PanelMap;
        // ptr<byte> pVVram = VVramBack;
        byte row;
        for (row = 0; row < RowCount; ++row) {
            // byte x = 0;
            byte column;
            for (column = 0; column < ColumnCount; ++column) {
                byte b = *pMap;
                if (b != 0) {
                    // byte edge = Edge(pMap, column, row);
                    // pVVram = DrawPanel(pVVram, b, edge);
                    if ((b & Panel_Star) != 0) {
                        ++StarCount;
                    }
                }
                // else {
                //     pVVram = ErasePanel(pVVram);
                // }
                ++pMap;
            }
            // pVVram += VVramWidth * 3;
        }
    }
    InitMan();
    InitMonsters();
    MovingPanel = 0;
    pMoving = nullptr;

    DrawAll();
}


void StartMovingPanel()
{
    byte x = Man.x >> CoordShift;
    byte column = x >> 2;
    byte y = Man.y >> CoordShift;
    byte row = y >> 2;
    ptr<byte> pMap = MapPtr(column, row);
    byte panel = *pMap;
    byte xMod = x & 3;
    if (xMod == 0) {
        if (column == 0) return;
        if ((panel & Panel_Left) != 0) return;
        if (*MapPtr(column - 1, row) != 0) return;
        PanelDirection = Direction_Left;
        goto start;
    }
    if (xMod == 2) {
        if (column == ColumnCount - 1) return;
        if ((panel & Panel_Right) != 0) return;
        if (*MapPtr(column + 1, row) != 0) return;
        PanelDirection = Direction_Right;
        goto start;
    }
    byte yMod = y & 3;
    if (yMod == 0) {
        if (row == 0) return;
        if ((panel & Panel_Top) != 0) return;
        if (*MapPtr(column, row - 1) != 0) return;
        PanelDirection = Direction_Up;
        goto start;
    }
    if (yMod == 2) {
        if (row == RowCount - 1) return;
        if ((panel & Panel_Bottom) != 0) return;
        if (*MapPtr(column, row + 1) != 0) return;
        PanelDirection = Direction_Down;
        goto start;
    }
    return;
    start:
    PanelX = column << 2;
    PanelY = row << 2;
    MovingPanel = panel;
    *pMap = 0;
    Man.status |= Movable_OnPanel;
    Sound_Move();
}


void MovePanel()
{
    static byte clock;
    ++clock;
    if ((clock & CoordMask) == 0 && MovingPanel != 0) {
        sbyte dx, dy;
        if (PanelDirection == Direction_Left) {
            --PanelX;
            dx = -CoordRate;
            dy = 0;
            goto moved;
        }
        if (PanelDirection == Direction_Right) {
            ++PanelX;
            dx = CoordRate;
            dy = 0;
            goto moved;
        }
        if (PanelDirection == Direction_Up) {
            --PanelY;
            dx = 0;
            dy = -CoordRate;
            goto moved;
        }
        if (PanelDirection == Direction_Down) {
            ++PanelY;
            dx = 0;
            dy = CoordRate;
            goto moved;
        }
        return;
        moved:
        pMoving = VVramPtr(PanelX, PanelY);
        SlideMan(dx, dy);
        if (((PanelX | PanelY) & 3) == 0) {
            byte column = PanelX >> 2;
            byte row = PanelY >> 2;
            ptr<byte> pMap = MapPtr(column, row);
            *pMap = MovingPanel;
            MovingPanel = 0;
            Man.status &= ~Movable_OnPanel;
        }
    }
}