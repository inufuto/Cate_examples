#include "Item.h"
#include "Sprite.h"
#include "VVram.h"
#include "MyFighter.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"

constexpr byte Size = 2;
constexpr byte RangeX = VVramWidth;
constexpr byte InvalidY = 0xff;


Movable Item;

void InitItem() 
{
    Item.y = InvalidY;
    Item.sprite = Sprite_Item;
}

static void Show()
{
    const byte[] Chars = {
        0xc0, 0xc0, 0xd0, 0xc0,
    };
    ShowSprite(&Item, Chars);
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
