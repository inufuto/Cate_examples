#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidCode = 0xff;
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->code = InvalidCode;
        p->oldCode = InvalidCode;
    }
}


void ShowSprite(byte index, byte x, byte y, byte code)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = x;
    p->y = y;
    p->code = code;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->code = InvalidCode;
}

void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldCode != InvalidCode && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->code == InvalidCode
        )) {
            word offset;
            ptr<byte> pFront, pBack, pFlags;
            byte y, iy, bits, b;
            y = p->oldY;
            offset = VVramOffset(p->oldX, y);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFlags = RowFlags + (y >> 3);
            bits = ((byte)1) << (y & 7);
            pFront[0] = pBack[0];
            *pFlags |= bits;
            if (p->oldCode >= Char_MyRobo) {
                pFront[1] = pBack[1];
                pFront[VVramWidth] = pBack[VVramWidth];
                pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
                bits <<= 1;
                if (bits == 0) {
                    ++pFlags;
                    bits = 1;
                }
                *pFlags |= bits;
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pFront, pFlags;
            byte y, iy, c, bits;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            y = p->y;
            pFront = VVramFront + VVramOffset(p->x, y);
            pFlags = RowFlags + (y >> 3);
            bits = ((byte)1) << (y & 7);
            c = p->code;
            pFront[0] = c; 
            if (changed) {
                *pFlags |= bits;
            }
            if (p->code >= Char_MyRobo) {
                ++c; pFront[1] = c;
                ++c; pFront[VVramWidth] = c;
                ++c; pFront[VVramWidth + 1] = c;
                if (changed) {
                    bits <<= 1;
                    if (bits == 0) {
                        ++pFlags;
                        bits = 1;
                    }
                    *pFlags |= bits;
                }
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
