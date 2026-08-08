#include "Item.h"
#include "Stage.h"
#include "VVram.h"
#include "Sprite.h"
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
    const byte[] Chars = {
    	0xc0, 0xc0, 0xd0, 0xc0,
    };
    byte x, y;

    if (ItemX == 0x80) return;

    x = OffsetX(ItemX);
    if (x >= VVramWidth) goto end;
    y = OffsetY(ItemY);
    if (y >= VVramHeight) goto end;
    x -= HalfSize;
    y -= HalfSize;
    if (x < VVramWidth - HalfSize * 2 && y < VVramHeight - HalfSize * 2) {
        ShowSprite(Sprite_Item, x, y, Chars);
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
