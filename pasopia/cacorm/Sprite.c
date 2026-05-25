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
    }
}


void ShowSprite(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->code = code;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->code = InvalidCode;
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            ptr<byte> pVVram;
            byte y, c;
            y = p->y;
            pVVram = VVramPtr(p->x, y);
            c = p->code;
            pVVram[0] = c; 
            ++c; pVVram[1] = c;
            ++c; pVVram[VVramWidth] = c;
            ++c; pVVram[VVramWidth + 1] = c;
        }
    }
}
