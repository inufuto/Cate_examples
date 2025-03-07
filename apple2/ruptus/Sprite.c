#include "Sprite.h"
#include "Window.h"
#include "Chars.h"
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

void __deb() {}

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
            byte y, iy, bits;
            y = p->oldY;
            offset = WindowOffset(p->oldX, y);
            pFront = WindowFront + offset;
            pBack = WindowBack + offset;
            pFlags = RowFlags + (y >> 3);
            bits = ((byte)1) << (y & 7);
            pFront[0] = pBack[0];
            if (p->oldCode == Char_FighterBullet && p->oldY == 8) {
                __deb();
                y = p->oldY;
            }
            *pFlags |= bits;
            if (p->oldCode >= Char_Fighter) {
                pFront[1] = pBack[1];
                pFront[WindowWidth] = pBack[WindowWidth];
                pFront[WindowWidth + 1] = pBack[WindowWidth + 1];
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
            pFront = WindowFront + WindowOffset(p->x, y);
            c = p->code;
            pFront[0] = c; 
            if (changed) {
                pFlags = RowFlags + (y >> 3);
                bits = ((byte)1) << (y & 7);
                *pFlags |= bits;
            }
            if (p->code >= Char_Fighter) {
                ++c; pFront[1] = c;
                ++c; pFront[WindowWidth] = c;
                ++c; pFront[WindowWidth + 1] = c;
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
