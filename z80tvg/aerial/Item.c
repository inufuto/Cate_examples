#include "Item.h"
#include "Sprite.h"
#include "Vram.h"
#include "MyFighter.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"
#include "Chars.h"

constexpr byte Size = 2;
constexpr byte RangeX = VramWidth;
constexpr byte InvalidY = 0xff;


Movable Item;

void InitItem() 
{
    Item.y = InvalidY;
    Item.sprite = Sprite_Item;
}

static void Show()
{
    ShowSprite(&Item, Char_Item);
}

static void End()
{
    HideSprite(Item.sprite);
    Item.y = InvalidY;
}

void StartItem(byte x, byte y) 
{
    if (Item.y != InvalidY) return;
    Item.x = x;
    Item.y = y;
    Show();
}

void MoveItem()
{
    if (Item.y != InvalidY) {
        --Item.x;
        if (Item.x >= RangeX) {
            End();
            return;
        }
        if (
            Item.x + 1 >= MyFighter.x && 
            Item.x < MyFighter.x + 2 &&
            Item.y + 1 >= MyFighter.y &&
            Item.y < MyFighter.y + 2
        ) {
            End();
            Sound_Up();
            ++RemainCount;
            PrintStatus();
            return;
        }
        Show();
    }
}
