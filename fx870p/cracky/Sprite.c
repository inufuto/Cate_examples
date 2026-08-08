#include "Sprite.h"
#include "VVram.h"
#include "Vram.h"
#include "CopyMemory.h"

constexpr byte InvalidY = 0xff;

struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    CopyMemory(p->chars, pChars, 4);
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->y != InvalidY) {
            ptr<byte> pVVram, pChars;
            byte y;
            y = p->y;
            pVVram = VVramPtr(p->x, y);
            pChars = p->chars;
            pVVram[0] = *pChars; 
            ++pChars; pVVram[1] = *pChars;
            ++pChars; pVVram[VVramWidth] = *pChars;
            ++pChars; pVVram[VVramWidth + 1] = *pChars;
        }
    }
}
