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
    ptr<Sprite> p = Sprites + index;
    p->x = x;
    p->y = y;
    p->code = code;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p = Sprites + index;
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
            byte y = p->oldY;
            word offset = VVramOffset(p->oldX, y);
            ptr<byte>pFront = VVramFront + offset;
            ptr<byte>pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            if (p->oldCode >= Char_MyRobo) {
                pFront[1] = pBack[1];
                pFront[VVramWidth] = pBack[VVramWidth];
                pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            byte y = p->y;
            ptr<byte> pFront = VVramFront + VVramOffset(p->x, y);
            byte c = p->code;
            pFront[0] = c; 
            if (p->code >= Char_MyRobo) {
                ++c; pFront[1] = c;
                ++c; pFront[VVramWidth] = c;
                ++c; pFront[VVramWidth + 1] = c;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
