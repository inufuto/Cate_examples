#include "Item.h"
#include "Stage.h"
#include "Window.h"
#include "Sprite.h"
#include "Chars.h"
#include "Mover.h"

constexpr byte HalfSize = 1;
constexpr byte SpriteColor = 13;

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
    if (x >= WindowWidth) goto end;
    y = OffsetY(ItemY);
    if (y >= WindowHeight) goto end;
    x -= HalfSize;
    y -= HalfSize;
    if (x < WindowWidth - HalfSize * 2 && y < WindowHeight - HalfSize * 2) {
        ShowSprite(Sprite_Item, x, y, Char_Item);
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
    if (HitMover(ItemX, ItemY, HalfSize, x, y, size)) {
        ItemX = 0x80;
        HideSprite(Sprite_Item);
        return true;
    }
    return false;
}
