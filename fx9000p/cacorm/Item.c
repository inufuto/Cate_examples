#include "Item.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Chars.h"
#include "Line.h"
// #include "Sound.h"
#include "Movable.h"
#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Increaser.h"
#include "Math.h"
#include "VVram.h"

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
            // Put2C(VramAddress(x, y + StatusHeight), Char_Item);
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
                // word vram;
                // vram = VramAddress(x, y + StatusHeight);
                StartPoint(x << CoordShift, y << CoordShift, rate);
                if (
                    rate != 0 &&
                    !IsIncreaserVisible() &&
                    RemainCount < 10 && 
                    (Rnd() & 7) == 0
                ) {
                    ShowIncreaser(x << CoordShift, y << CoordShift);
                }
                // Erase2(vram);
                *CellMapPtr(x >> 1, y >> 1) = Cell_Space;
                pItem->y = StageHeight;
                --ItemCount;
                if (rate < 3) {
                    ++rate;
                }
                DrawAll();
                // Sound_Hit();
                Wait(50);
            }
        }
    }
}