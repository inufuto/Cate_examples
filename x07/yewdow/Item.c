#include "Item.h"
#include "Stage.h"
#include "VVram.h"
#include "Movable.h"
#include "Point.h"
#include "Sound.h"
#include "Main.h"

extern void _deb();

constexpr byte InvalidX = 0xff;
constexpr byte InvalidType = 0xff;

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
    p = pStage->items;
    for (i = 0; i < MaxItemCount; ++i) {
        byte b, x, y;
        b = *p; ++p;
        x = (b >> 3) & 0xfe;
        y = (b & 15) << 1;
        pItem->x = x;
        pItem->y = y;
        SetCell(x >> 1, y >> 1, Cell_Item);
        ++pItem;
    }
    ItemCount = MaxItemCount;
    LastType = InvalidType;
    Rate = 0;
}


void HitItems(byte x, byte y)
{
    byte cell;
    x >>= MapShift;
    y >>= MapShift;
    cell = GetCell(x, y);
    if (cell == Cell_Item) {
        ptr<Item> pItem;
        byte index;
        index = 0;
        for (pItem : Items) {
            if (pItem->x != InvalidX && pItem->x >> 1 == x && pItem->y >> 1 == y) {
                byte type;
                type = index >> 1;
                if (LastType != InvalidType) {
                    if (type == LastType) {
                        LastType = InvalidType;
                        ++Rate;
                    }
                    else {
                        LastType = type;
                        Rate = 0;
                    }
                }
                else {
                    LastType = type;
                }
                StartPoint(pItem->x << CoordShift, pItem->y << CoordShift, Rate);
                EraseCell(x, y);
                pItem->x = InvalidX;
                --ItemCount;
                Sound_Hit();
            }
            ++index;
        }
    }
}


void DrawItems()
{
    static const byte[] Chars = {
        0x50, 0xf0, 0x50, 0x00, 0x50, 0xe0, 0x50, 0x00,
	    0x50, 0x90, 0x50, 0x80, 0x50, 0xb0, 0x50, 0x00,
    };
    static byte clock;
    ptr<Item> pItem;
    byte index;
    index = 0;
    for (pItem: Items) {
        byte type;
        type = index >> 1;
        if (pItem->x != InvalidX) {
            if (type != LastType || (clock & CoordRate) != 0) {
                ptr<byte> pVVram, pChars;
                pChars = Chars + ((index & 6) << 1);
                pVVram = VVramPtr(pItem->x, pItem->y);
                repeat(2) {
                    repeat(2) {
                        *pVVram = *pChars; ++pVVram; ++pChars;
                    }
                    pVVram += VVramWidth - 2;
                }
            }
        }
        next:
        ++index;
    }
    ++clock;
}
