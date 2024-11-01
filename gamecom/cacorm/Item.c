#include "Item.h"
#include "Stage.h"
#include "Stages.h"
#include "VVram.h"
#include "Chars.h"
#include "Line.h"
#include "Sound.h"
#include "Movable.h"
#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Increaser.h"
#include "Math.h"
#include "Vram.h"

byte ItemCount;
Item[MaxItemCount] Items;

void InitItems()
{
    ptr<Item> pItem;
    ptr<byte> pBytes;
    byte i;

    pItem = Items;
    ItemCount = pStage->itemCount;
    pBytes = pStage->pItems;
    i = 0;
    while (i < ItemCount) {
        byte b;
        b = *pBytes;
        ++pBytes;
        pItem->x = ((b >> 3) & 0xfe);
        pItem->y = (b & 15) << 1;
        ++i;
        ++pItem;
    }
    while (i < MaxItemCount) {
        pItem->y = StageHeight;
        ++i;
        ++pItem;
    }
}


void DrawItems()
{
    ptr<Item> pItem;
    for (pItem: Items) {
        byte x, y;
        x = pItem->x;
        y = pItem->y;
        if (y < StageHeight) {
            VPut2C(VVramPtr(x, y), Char_Item);
            *CellMapPtr(x >> 1, y >> 1) = Cell_Item;
        }
    }
}


void EraseItems()
{
    ptr<Item> pItem;
    byte rate;
    rate = 0;
    for (pItem: Items) {
        byte x, y;
        x = pItem->x;
        y = pItem->y;
        if (y < StageHeight) {
            if (IsSurrounded(x, y)) {
                ptr<byte> pVVram;
                pVVram = VVramPtr(x, y);
                StartPoint(x << CoordShift, y << CoordShift, rate);
                if (
                    rate != 0 &&
                    !IsIncreaserVisible() &&
                    RemainCount < 10 && 
                    (Rnd() & 7) == 0
                ) {
                    ShowIncreaser(x << CoordShift, y << CoordShift);
                }
                VErase2(pVVram);
                *CellMapPtr(x >> 1, y >> 1) = Cell_Space;
                pItem->y = StageHeight;
                --ItemCount;
                if (rate < 3) {
                    ++rate;
                }
                DrawAll();
                Sound_Hit();
            }
        }
    }
}