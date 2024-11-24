#include "Item.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Main.h"
#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Point.h"
#include "Sound.h"
#include "Sprite.h"
#include "VVram.h"

constexpr byte InvalidX = 0xff;
constexpr byte InvalidType = 0xff;

Item[MaxItemCount] Items;
byte ItemCount;
static byte LastType;
static byte Rate;

void InitItems() 
{
    ptr<Item> pItem;
    byte count, i, sprite;
    ptr<byte> p;
    sprite = Sprite_Item;
    i = 0;
    pItem = Items;
    p = pStage->pItems;
    while (i < pStage->itemCount) {
        byte b;
        b = *p; ++p;
        pItem->x = ToX(b);
        pItem->y = ToY(b) + 1;
        pItem->type = *p; ++p;
        pItem->sprite = sprite;
        ++pItem;
        ++i;
        ++sprite;
    }
    ItemCount = i;
    while (i < MaxItemCount) {
        pItem->x = InvalidX;
        ++pItem;
        ++i;
    }
    LastType = InvalidType;
    Rate = 0;
}


static void Show(ptr<Item> pItem) 
{
    const byte[] Chars = {
        0x50, 0xf0, 0x50, 0x00, 0x50, 0xe0, 0x50, 0x00,
    	0x50, 0x90, 0x50, 0x80, 0x50, 0xb0, 0x50, 0x00,
    };
    ShowSprite((ptr<Movable>)pItem, Chars + ((pItem->type) << 2));
}

void DrawItems()
{
    ptr<Item> pItem;
    byte index;
    index = 0;
    for (pItem: Items) {
        ptr<byte> p;
        if (pItem->x != InvalidX) {
            p = CellMapPtr(pItem->x, pItem->y);
            *p = (*p & ~Cell_Index) | index | Cell_Type_Item;
            Show(pItem);        
        }
        ++index;
    }
}


void BlinkItems()
{
    ptr<Item> pItem;
    for (pItem: Items) {
        ptr<byte> p;
        if (pItem->x != InvalidX) {
            if (
                pItem->type == LastType &&
                (Clock & (0x04 << CoordShift)) != 0
            ) {
                HideSprite(pItem->sprite);
            }
            else {
                Show(pItem);
            }
        }
    }
}


void HitItems()
{
    byte x, y, cell;
    ptr<byte> pCell;
    ptr<Item> pItem;
    x = Man._.x >> CoordShift;
    y = Man._.y >> CoordShift;
    pCell = CellMapPtr(x, y);
    cell = *pCell;
    if ((cell & Cell_Type) != Cell_Type_Item) return;
    pItem = Items + (cell & Cell_Index);
    if (pItem->x != x || pItem->y != y) return;
    if (pItem->type == LastType) {
        StartPoint(x << CoordShift, y << CoordShift, Rate);
        ++Rate;
        LastType = InvalidType;
    }
    else {
        AddScore(5);
        if (LastType != InvalidType) {
            Rate = 0;
        }
        LastType = pItem->type;
    }
    *pCell = Cell_Type_Floor;
    HideSprite(pItem->sprite);
    pItem->x = InvalidX;
    --ItemCount;
    // UpdateSprites();
    DrawAll();
    Sound_Hit();
}