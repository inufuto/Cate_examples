#include "Item.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Fighter.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"

constexpr byte Size = 2;
constexpr byte Range = WindowHeight * CoordRate;
constexpr byte InvalidY = 0xff;

Item Item;

void InitItem() 
{
    Item.y = InvalidY;
    Item.sprite = Sprite_Item;
}


static void Show()
{
    ShowSprite(&Item, Pattern_Item);
}

static void Hide()
{
    HideSprite(Sprite_Item);
    Item.y = InvalidY;
}

void StartItem(byte x, byte y) 
{
    if (Item.y < Range) return;
    Item.x = x;
    Item.y = y;
    Show();
}


void MoveItem()
{
    if (Item.y < Range) {
        ++Item.y;
        if (Item.y >= Range) {
            Hide();
            return;
        }
        if (
            Item.x + CoordRate >= Fighter.x && Item.x < Fighter.x + CoordRate &&
            Item.y + CoordRate >= Fighter.y && Item.y < Fighter.y + CoordRate 
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
