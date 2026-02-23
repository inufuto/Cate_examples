#include "Item.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fighter.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"

constexpr byte Size = 2;
// constexpr byte Color = 3;
constexpr byte Range = VramHeight * CoordRate;
constexpr byte InvalidY = 0xff;


byte ItemX, ItemY;

void InitItem() 
{
    ItemY = InvalidY;
}

static void Show()
{
    ShowSprite(Sprite_Item, ItemX, ItemY, GChar_Item);
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
            FighterX < ItemX + CoordRate && ItemX < FighterX + CoordRate &&
            FighterY < ItemY + CoordRate && ItemY < FighterY + CoordRate 
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
