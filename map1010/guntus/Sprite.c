#include "Chars.h"
#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Init.h"

constexpr byte InvalidCode = 0xff;

struct Sprite {
    byte x, y;
    byte code;
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
    }
}


void ShowSprite(byte index, byte x, byte y, byte code)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = x;
    p->y = y;
    p->code = code;
    PollVSync();
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
            byte y, c, bits;
            y = p->y;
            pVVram = VVramPtr(p->x, y);
            c = p->code;
            pVVram[0] = c; 
            bits = 1;
            if (p->code >= Char_Enemy) {
                ++c; pVVram[1] = c;
                if (y < VVramHeight - 1) {
                    ++c; pVVram[VVramWidth] = c;
                    ++c; pVVram[VVramWidth + 1] = c;
                    bits = 3;
                }
            }
        }
    }
}
