#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidCode = 0xff;
Sprite[SpriteCount] Sprites;

void InitSprites()
{
    HideAllSprites();
}

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
            ptr<byte> pFront, pBack;
            byte bits;
            offset = VVramOffset(p->oldX, p->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            bits = 1;
            if (p->oldCode >= Char_Fighter) {
                pFront[1] = pBack[1];
                pFront[VVramWidth] = pBack[VVramWidth];
                pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
                bits = 3;
            }
            SetRowFlags(p->oldY, bits);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pFront;
            byte c, bits;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            pFront = VVramFront + VVramOffset(p->x, p->y);
            c = p->code;
            pFront[0] = c; 
            bits = 1;
            if (p->code >= Char_Fighter) {
                ++c; pFront[1] = c;
                ++c; pFront[VVramWidth] = c;
                ++c; pFront[VVramWidth + 1] = c;
                bits = 3;
            }
            if (changed) {
                SetRowFlags(p->y, bits);
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
