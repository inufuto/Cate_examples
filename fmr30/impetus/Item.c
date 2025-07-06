#include "Item.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fighter.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"
#include "Chars.h"

constexpr byte Size = 2;
constexpr byte Range = StageHeight * CoordRate;
constexpr byte InvalidY = 0xff;


byte ItemX, ItemY;

void InitItem() 
{
    ItemY = InvalidY;
}

static void Show()
{
    ShowSprite(Sprite_Item, ItemX, ItemY, Pattern_Item);
}

static void Hide()
{
    HideSprite(Sprite_Item);
    ItemY = InvalidY;
}

void StartItem(byte x, byte y) 
{
    if (ItemY < Range) return;
    ItemX = x;
    ItemY = y;
    Show();
}

void MoveItem()
{
    if (ItemY < Range) {
        ++ItemY;
        if (ItemY >= Range) {
            Hide();
            return;
        }
        if (
            ItemX + CoordRate >= FighterX && ItemX < FighterX + CoordRate &&
            ItemY + CoordRate >= FighterY && ItemY < FighterY + CoordRate 
        ) {
            Hide();
            Sound_Up();
            ++RemainCount;
            PrintStatus();
            return;
        }
        Show();
    }
}
