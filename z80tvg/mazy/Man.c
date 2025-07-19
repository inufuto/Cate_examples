#include "Man.h"
#include "Map.h"
#include "ScanKeys.h"
#include "Chars.h"
#include "Vram.h"
#include "VVram.h"
#include "Main.h"
#include "Knife.h"
#include "Sound.h"

struct Direction {
    byte key;
    sbyte dx, dy;
    byte pattern;
    byte index;
    sbyte xOffset, yOffset;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, Char_Man_Left, 0, 0, 0 },
    { Keys_Right, 1, 0, Char_Man_Right, 1, 1, 0 },
    { Keys_Up, 0, -1, Char_Man_Up, 2, 0, 0 },
    { Keys_Down, 0, 1, Char_Man_Down, 3, 0, 1 },
};

byte ManX, ManY;
bool ManLost;
static ptr<Direction> pPrevDirection;
static byte pattern;
static byte seqIndex;
static bool buttonOn;

static void UpdateBasePosition()
{
    if (ManX < VVramWidth / 2) {
        BaseX = 0;
    }
    else {
        byte x, margin;
        margin = MapWidth - VVramWidth;
        if (margin > MapWidth) {
            margin = 0;
        }
        x = ManX - VVramWidth / 2;
        if (x >= margin) {
            BaseX = margin;
        }
        else {
            BaseX = x;
        }
    }
    if (ManY < VVramHeight / 2) {
        BaseY = 0;
    }
    else {
    	if (MapHeight > VVramHeight) {
            byte y, margin;
            margin = MapHeight - VVramHeight;
            y = ManY - VVramHeight / 2;
            if (y >= margin) {
                BaseY = margin;
            }
            else {
                BaseY = y;
            }
        }
        else {
            BaseY = 0;
        }
    }
}

void InitMan()
{
    ManX = ToMapSize(*pStage); ++pStage;
    ManY = ToMapSize(*pStage); ++pStage;
    UpdateBasePosition();
    pPrevDirection = Directions + 1; // right
    pattern = pPrevDirection->pattern;
    seqIndex = 0;
}


void DrawMan()
{
    VPut2(ManX, ManY, pattern);
}


void MoveMan()
{
    byte key;
    ptr<Direction> pDirection;
    byte x, y;
    if (ManLost) return;
    key = ScanKeys();
    for (pDirection : Directions) {
        if ((key & pDirection->key) != 0) {
            x = ManX + pDirection->dx;
            y = ManY + pDirection->dy;
            if (CanMove2(x, y)) {
                pPrevDirection = pDirection;
                goto canMove;
            }
        }
    }
    if ((key & Keys_Dir) != 0) {
        x = ManX + pPrevDirection->dx;
        y = ManY + pPrevDirection->dy;
        if (CanMove2(x, y)) {
            canMove:
            ManX = x;
            ManY = y;
            UpdateBasePosition();
            if (x == GoalX && y == GoalY) {
                StageClear = true;
            }
            seqIndex = (seqIndex + 1) & 3;
            if (seqIndex == 3) {
                seqIndex = 1;
            }
            pattern = pPrevDirection->pattern + ((1 + seqIndex) << 2);
            goto testButton;
        }
    }
    pattern = pPrevDirection->pattern;
    testButton:
    if ((key & Keys_Button0) != 0 && !buttonOn) {
        byte x, y;
        x = ManX + pPrevDirection->dx;
        y = ManY + pPrevDirection->dy;
        if (CanMove1(x, y)) {
            StartKnife(x, y, pPrevDirection->index);
            buttonOn = true;
            return;
        }
    }
    else {
        buttonOn = false;
    }
}


void EndMan()
{
    static const byte[] Patterns = {
        Char_Man_Left_Stop,
        Char_Man_Down_Stop,
        Char_Man_Die2,
        Char_Man_Die3
    };
    byte i;
    repeat (10) {
        VPut2(ManX, ManY, Patterns[i]);
        VVramToVram();
        PresentVram();
        Sound_Loose();
        i = (i + 1) & 3;
    }
}