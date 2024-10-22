#include "Item.h"
#include "Stage.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Mover.h"

constexpr byte Size = 2;

byte ItemX, ItemY;

void InitItem() 
{
    ItemX = 0x80;
}


void StartItem(byte x, byte y) 
{
    if (ItemX != 0x80) return;
    ItemX = x;
    ItemY = y;
}

void DrawItem()
{
    byte x, y;

    if (ItemX == 0x80) return;

    x = OffsetX(ItemX);
    if (x >= WindowWidth * 2) goto end;
    y = OffsetY(ItemY);
    if (y >= WindowHeight * 2) goto end;
    x -= Size;
    y -= Size;
    if (x < (WindowWidth -Size) * 2 && y < (WindowHeight - Size) * 2) {
        ShowSprite(Sprite_Item, x << 2, y << 2, Pattern_Item);
    }
    else {
        end:
        HideSprite(Sprite_Item);
    }
    return;
}


bool HitItem(byte x, byte y, byte size)
{
    if (ItemX == 0x80) return false;
    if (HitMover(ItemX, ItemY, Size, x, y, size)) {
        ItemX = 0x80;
        HideSprite(Sprite_Item);
        return true;
    }
    return false;
}
