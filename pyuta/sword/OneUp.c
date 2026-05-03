#include "OneUp.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Main.h"
#include "Stage.h"
#include "Sound.h"
#include "Status.h"
#include "Vram.h"

constexpr byte OneUpColor = 3;
constexpr byte InvalidY = 0xe0;

// Movable OneUp;
static byte nextRow;

void InitOneUp()
{
    WriteVram(OneUp + Movable_y, InvalidY);
    WriteVram(OneUp + Movable_sprite, Sprite_OneUp);
    HideSprite(ReadVram(OneUp + Movable_sprite));
    nextRow = 0;
}


void StartOneUp()
{
    if (ReadVram(OneUp + Movable_y) == InvalidY && RemainCount < 10 && Rnd() < 5) {
        byte row = nextRow;
        byte column = Rnd() & (ColumnCount - 1);
        if (GetCell(column, row) == Cell_Space) {
            WriteVram(OneUp + Movable_x, column << GridCoordShift);
            WriteVram(OneUp + Movable_y, row << GridCoordShift);
            ShowSprite(OneUp, Pattern_Oneup, OneUpColor);
        }
        ++nextRow;
        if (nextRow >= RowCount) {
            nextRow = 0;
        }
    }
}


void HitOneUp(byte x, byte y)
{
    if (IsNear(OneUp, x, y)) {
        WriteVram(OneUp + Movable_y, InvalidY);
        HideSprite(ReadVram(OneUp + Movable_sprite));
        Sound_Up();
        ++RemainCount;
        PrintRemain();
    }
}