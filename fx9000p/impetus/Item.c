#include "Item.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fighter.h"
#include "Status.h"
#include "Main.h"
// #include "Sound.h"
#include "VVram.h"
#include "Chars.h"

constexpr byte Size = 2;
constexpr byte Color = 0x98;
constexpr byte RangeY = VVramHeight - 2 + 1;
constexpr byte InvalidY = 0xff;


byte ItemX, ItemY;

void InitItem() 
{
    ItemY = InvalidY;
}

static void Show()
{
    ShowSprite(Sprite_Item, ItemX, ItemY, Char_Item);
}

static void Hide()
{
    HideSprite(Sprite_Item);
    ItemY = InvalidY;
}

void StartItem(byte x, byte y) 
{
    if (ItemY < RangeY) return;
    ItemX = x;
    ItemY = y;
    Show();
}

void MoveItem()
{
    if (ItemY < RangeY) {
        ++ItemY;
        if (ItemY >= RangeY) {
            Hide();
            return;
        }
        if (
            ItemX + 1 >= FighterX && ItemX < FighterX + 2 &&
            ItemY + 1 >= FighterY && ItemY < FighterY + 2
        ) {
            Hide();
            // Sound_Up();
            ++RemainCount;
            PrintStatus();
            return;
        }
        Show();
    }
}
