#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Stage.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte c;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
        p->oldY = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->c = (pattern << 2) + Char_Sprite;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p = Sprites + index;
    p->y = InvalidY;
}


void EraseSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --p;
        if (p->oldY < VVramHeight - 1 && (p->y != p->oldY || p->x != p->oldX)) {
            byte row = p->oldY >> CellShift;
            byte column = p->oldX >> CellShift;
            repeat (2) {
                if (row >= RowCount - 1) break;
                repeat (2) {
                    if (column < ColumnCount) {
                        byte cell = GetCell(column, row);
                        DrawCell(column, row, cell);
                    }
                    ++column;
                }
                column -= 2;
                ++row;
            }
        }
    }
}

void DrawSprites()
{
    ptr<Sprite> p = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --p;
        byte y = p->y;
        if (y < VVramHeight - 1) {
            ptr<byte> pVVram = VVramPtr(p->x, y);
            byte c = p->c;
            repeat (2) {
                repeat (2) {
                    *pVVram = c;
                    ++pVVram;
                    ++c;
                }
                pVVram += VVramWidth - 2;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
    }
}
