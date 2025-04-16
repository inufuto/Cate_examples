#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"
// #include "Init.h"

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

void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            ptr<byte> pVVram;
            byte c;
            pVVram = VVramPtr(p->x, p->y);
            c = p->code;
            pVVram[0] = c; 
            if (p->code >= Char_Fighter) {
                ++c; pVVram[1] = c;
                ++c; pVVram[VVramWidth] = c;
                ++c; pVVram[VVramWidth + 1] = c;
            }
            //PollVSync();
        }
    }
}
