#include "OneUp.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Main.h"
#include "Stage.h"
#include "Sound.h"
#include "Status.h"

constexpr byte SpriteColor = 3;
constexpr byte InvalidY = 0xe0;

Movable OneUp;
static byte nextRow;

void InitOneUp()
{
    OneUp.y = InvalidY;
    OneUp.sprite = Sprite_OneUp;
    HideSprite(OneUp.sprite);
    nextRow = 0;
}


void StartOneUp()
{
    if (OneUp.y == InvalidY && RemainCount < 10 && Rnd() < 5) {
        byte row = nextRow;
        byte column = Rnd() & (ColumnCount - 1);
        if (GetCell(column, row) == Cell_Space) {
            OneUp.x = column << CellCoordShift;
            OneUp.y = row << CellCoordShift;
            ShowSprite(&OneUp, Pattern_OneUp, SpriteColor);
        }
        nextRow += 2;
        if (nextRow >= RowCount) {
            nextRow = 0;
        }
    }
}


void HitOneUp(ptr<Movable> pMovable)
{
    if (IsNear(&OneUp, pMovable)) {
        OneUp.y = InvalidY;
        HideSprite(OneUp.sprite);
        Sound_Up();
        ++RemainCount;
        PrintRemain();
    }
}