#include "Chars.h"
#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"

constexpr byte InvalidCode = 0xff;

struct Sprite {
    byte x, y;
    byte code;
    byte oldX, oldY;
    byte oldCode;
};

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
            byte y;
            y = p->oldY;
            offset = VVramOffset(p->oldX, y);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            pFront[0] = pBack[0];
            if (p->oldCode >= Char_Enemy) {
                pFront[1] = pBack[1];
                if (y < VVramHeight - 1) {
                    pFront[VVramWidth] = pBack[VVramWidth];
                    pFront[VVramWidth + 1] = pBack[VVramWidth + 1];
                }
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            ptr<byte> pFront;
            byte y, c;
            y = p->y;
            pFront = VVramFront + VVramOffset(p->x, y);
            c = p->code;
            pFront[0] = c; 
            if (p->code >= Char_Enemy) {
                ++c; pFront[1] = c;
                if (y < VVramHeight - 1) {
                    ++c; pFront[VVramWidth] = c;
                    ++c; pFront[VVramWidth + 1] = c;
                }
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
