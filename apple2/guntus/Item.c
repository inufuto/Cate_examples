#include "Item.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fighter.h"
#include "Status.h"
#include "Status.h"
#include "Sound.h"
#include "Coord.h"
#include "Chars.h"

constexpr byte Size = 2;
constexpr byte Range = WindowHeight * CoordRate;
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
            ItemX + CoordRate >= FighterX && 
            FighterX + CoordRate >= ItemX  &&
            ItemY + CoordRate >= FighterY &&
            FighterY + CoordRate >= ItemY
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
