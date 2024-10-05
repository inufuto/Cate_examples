#include "Item.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Chars.h"
#include "Main.h"
#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Point.h"
#include "Sound.h"
#include "Sprite.h"

constexpr byte InvalidX = 0xff;
constexpr byte InvalidType = 0xff;

static const byte[] Chars = {
    0x33, 0xaa, 0x33, 0x00,
	0x33, 0xa8, 0x33, 0x00,
    0x33, 0x8a, 0x33, 0x80,
	0x33, 0x8a, 0x33, 0x00,
};

Item[MaxItemCount] Items;
byte ItemCount;
static byte LastType;
static byte Rate;

void InitItems() 
{
    ptr<Item> pItem;
    byte count, i;
    ptr<byte> p;
    pItem = Items;
    i = 0;
    p = pStage->pItems;
    while (i < pStage->itemCount) {
        byte b;
        b = *p; ++p;
        pItem->x = ToX(b);
        pItem->y = ToY(b) + 1;
        pItem->type = *p; ++p;
        ++pItem;
        ++i;
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


void DrawItems()
{
    ptr<Item> pItem;
    byte index;
    index = 0;
    for (pItem: Items) {
        ptr<byte> p;
        if (pItem->x != InvalidX) {
            Put2SXY(pItem->x, pItem->y, Chars + ((pItem->type) << 2), false);
            p = CellMapPtr(pItem->x, pItem->y);
            *p = (*p & ~Cell_Index) | index | Cell_Type_Item;
        }
        ++index;
    }
}


void BlinkItems()
{
    ptr<Item> pItem;
    for (pItem: Items) {
        ptr<byte> p;
        if (pItem->x != InvalidX && pItem->type == LastType) {
            if ((Clock & (0x04 << CoordShift)) != 0) {
                Erase2XY(pItem->x, pItem->y, false);
            }
            else {
                Put2SXY(pItem->x, pItem->y, Chars + ((pItem->type) << 2), false);
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
    Erase2XY(pItem->x, pItem->y, false);
    *pCell = Cell_Type_Floor;
    pItem->x = InvalidX;
    --ItemCount;
    // UpdateSprites();
    Sound_Hit();
    DrawItems();
    PresentVram();
}