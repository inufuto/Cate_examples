#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Status.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Math.h"
#include "Sound.h"

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


static ptr<byte> DrawPanel(ptr<byte> pVram, byte b, byte edge)
{
    {
        static const byte[] ArrowChars = {
            Char_Arrow + 4, Char_Arrow + 5
        };
        static const byte[] WallChars = {
            Char_Panel + 4, Char_Panel + 4
        };
        ptr<byte> pChars = (b & Panel_Top) == 0 ? (edge & Panel_Top) == 0 ? SpaceChars : ArrowChars : WallChars;
        pVram = Put(pVram, Char_Panel + 0);
        repeat (2) {
            pVram = Put(pVram, *pChars); ++pChars;
        }
        pVram = Put(pVram, Char_Panel + 1);
        pVram += VramRowSize - VramStep * 4;
    }
    {
        static const byte[] LeftArrowChars = {
            Char_Arrow + 0, Char_Arrow + 2
        };
        static const byte[] LeftWallChars = {
            Char_Panel + 4, Char_Panel + 4
        };
        ptr<byte> pLeftChars = (b & Panel_Left) == 0 ? (edge & Panel_Left) == 0 ? SpaceChars : LeftArrowChars : LeftWallChars;

        static const byte[] RightArrowChars = {
            Char_Arrow + 1, Char_Arrow + 3
        };
        static const byte[] RightWallChars = {
            Char_Panel + 4, Char_Panel + 4
        };
        ptr<byte> pRightChars = (b & Panel_Right) == 0 ? (edge & Panel_Right) == 0 ? SpaceChars : RightArrowChars : RightWallChars;
        ptr<byte> pCenterChars = (b & Panel_Star) != 0 ? StarChars : SpaceChars;
        repeat (2) {
            pVram = Put(pVram, *pLeftChars); ++pLeftChars;
            repeat (2) {
                pVram = Put(pVram, *pCenterChars); ++pCenterChars;
            }
            pVram = Put(pVram, *pRightChars); ++pRightChars;
            pVram += VramRowSize - VramStep * 4;
        }
    }
    {
        static const byte[] ArrowChars = {
            Char_Arrow + 6, Char_Arrow + 7
        };
        static const byte[] WallChars = {
            Char_Panel + 4, Char_Panel + 4
        };

        ptr<byte> pChars = (b & Panel_Bottom) == 0 ? (edge & Panel_Bottom) == 0 ? SpaceChars : ArrowChars : WallChars;
        pVram = Put(pVram, Char_Panel + 2);
        repeat (2) {
            pVram = Put(pVram, *pChars); ++pChars;
        }
        pVram = Put(pVram, Char_Panel + 3);
        pVram += -VramRowSize * 3;
    }
    return pVram;
}

static ptr<byte> ErasePanel(ptr<byte> pVram)
{
    {
        repeat (4) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - VramStep * 4;
    }
    repeat (2) {
        repeat (4) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - VramStep * 4;
    }
    {
        repeat (4) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += -VramRowSize * 3;
    }
    return pVram;
}

static byte Edge(ptr<byte> pMap, byte column, byte row)
{
    byte edge = 0;
    if (column != 0 && *(pMap - 1) == 0) {
        edge |= Panel_Left;
    }
    if (column != ColumnCount - 1 && *(pMap + 1) == 0) {
        edge |= Panel_Right;
    }
    if (row != 0 && *(pMap - ColumnCount) == 0) {
        edge |= Panel_Top;
    }
    if (row != RowCount - 1 && *(pMap + ColumnCount) == 0) {
        edge |= Panel_Bottom;
    }
    return edge;
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
        ptr<byte> pVram = Vram + VramRowSize * StageTop;
        byte row;
        for (row = 0; row < RowCount; ++row) {
            byte x = 0;
            byte column;
            for (column = 0; column < ColumnCount; ++column) {
                byte b = *pMap;
                if (b != 0) {
                    byte edge = Edge(pMap, column, row);
                    pVram = DrawPanel(pVram, b, edge);
                    if ((b & Panel_Star) != 0) {
                        ++StarCount;
                    }
                }
                else {
                    pVram = ErasePanel(pVram);
                }
                ++pMap;
            }
            pVram += VramRowSize * 4 - 4 * ColumnCount * VramStep;
        }
    }
    InitMan();
    InitMonsters();
    MovingPanel = 0;

    // DrawAll();
}


static void DrawArroundPanels(ptr<byte> pMap, byte column, byte row)
{
    ptr<byte> pVram = VramPtr(PanelX, PanelY + (StageTop - 1));
    if (column != 0) {
        ptr<byte> pLeft = pMap - 1;
        byte left = *pLeft;
        if (left != 0 && (left & Panel_Exist) != 0) {
            byte edge = Edge(pLeft, column - 1, row);
            DrawPanel(pVram - VramStep * 4, left, edge);
        }
    }
    if (column != ColumnCount - 1) {
        ptr<byte> pRight = pMap + 1;
        byte right = *pRight;
        if (right != 0 && (right & Panel_Exist) != 0) {
            byte edge = Edge(pRight, column + 1, row);
            DrawPanel(pVram + VramStep * 4, right, edge);
        }
    }
    if (row != 0) {
        ptr<byte> pUpper = pMap - ColumnCount;
        byte upper = *pUpper;
        if (upper != 0 && (upper & Panel_Exist) != 0) {
            byte edge = Edge(pUpper, column, row - 1);
            DrawPanel(pVram - VramRowSize * 4, upper, edge);
        }
    }
    if (row != RowCount - 1) {
        ptr<byte> pLower = pMap + ColumnCount;
        byte lower = *pLower;
        if (lower != 0 && (lower & Panel_Exist) != 0) {
            byte edge = Edge(pLower, column, row + 1);
            DrawPanel(pVram + VramRowSize * 4, lower, edge);
        }
    }
    {
        byte edge = Edge(pMap, column, row);
        DrawPanel(pVram, *pMap, edge);
    }
}

void StartMovingPanel()
{
    byte x = Man.x >> CoordShift;
    byte column = x >> 2;
    byte y = Man.y >> CoordShift;
    byte row = y >> 2;
    ptr<byte> pMap = MapPtr(column, row);
    byte panel = *pMap;
    // if ((panel & Panel_Movable) != 0) {
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
        DrawArroundPanels(pMap, column, row);
        Man.status |= Movable_OnPanel;
        Sound_Move();
    // }
}


static ptr<byte> EraseH(ptr<byte> pVram)
{
    repeat (4) {
        pVram = Put(pVram, Char_Space);
    }
    pVram += VramRowSize - VramStep * 4;
    return pVram;
}

static ptr<byte> EraseV(ptr<byte> pVram)
{
    {
        pVram = Put(pVram, Char_Space);
        pVram += VramRowSize - VramStep;
    }
    repeat (2) {
        pVram = Put(pVram, Char_Space);
        pVram += VramRowSize - VramStep;
    }
    {
        pVram = Put(pVram, Char_Space);
        pVram += -VramRowSize * 3;
    }
    return pVram;
}

void MovePanel()
{
    static byte clock;
    ++clock;
    if ((clock & CoordMask) == 0 && MovingPanel != 0) {
        sbyte dx, dy;
        if (PanelDirection == Direction_Left) {
            ptr<byte> pVram = VramPtr(PanelX - 1, PanelY + (StageTop - 1));
            pVram = DrawPanel(pVram, MovingPanel, 0);
            EraseV(pVram);
            --PanelX;
            dx = -CoordRate;
            dy = 0;
            goto moved;
        }
        if (PanelDirection == Direction_Right) {
            ptr<byte> pVram = VramPtr(PanelX, PanelY + (StageTop - 1));
            pVram = EraseV(pVram);
            pVram = DrawPanel(pVram, MovingPanel, 0);
            ++PanelX;
            dx = CoordRate;
            dy = 0;
            goto moved;
        }
        if (PanelDirection == Direction_Up) {
            ptr<byte> pVram = VramPtr(PanelX, PanelY + (StageTop - 1 - 1));
            pVram = DrawPanel(pVram, MovingPanel, 0);
            pVram += VramRowSize * 4 - VramStep * 4;
            EraseH(pVram);
            --PanelY;
            dx = 0;
            dy = -CoordRate;
            goto moved;
        }
        if (PanelDirection == Direction_Down) {
            ptr<byte> pVram = VramPtr(PanelX, PanelY + (StageTop - 1));
            pVram = EraseH(pVram);
            DrawPanel(pVram, MovingPanel, 0);
            ++PanelY;
            dx = 0;
            dy = CoordRate;
            goto moved;
        }
        return;
        moved:
        SlideMan(dx, dy);
        if (((PanelX | PanelY) & 3) == 0) {
            byte column = PanelX >> 2;
            byte row = PanelY >> 2;
            ptr<byte> pMap = MapPtr(column, row);
            *pMap = MovingPanel;
            DrawArroundPanels(pMap, column, row);
            MovingPanel = 0;
            Man.status &= ~Movable_OnPanel;
        }
    }
}