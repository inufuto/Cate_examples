#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->y = InvalidY;
    }
}


void ShowSpriteC(ptr<Movable> pMovable, byte c)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->y = pMovable->y;
    pSprite->x = pMovable->x;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = c;
        ++p;
        ++c;
    }
    PollTimer();
}

void ShowSpriteS(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->y = pMovable->y;
    pSprite->x = pMovable->x;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
    }
    PollTimer();
}

void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
    PollTimer();
}


void DrawSprites()
{
    ptr<Sprite> pSprite = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --pSprite;
        if (pSprite->y <= VVramHeight - 1) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pSprite->x, pSprite->y);
            ptr<byte> pChars = pSprite->chars;
            repeat (2) {
                repeat (2) {
                    byte c = *pChars;
                    if (c != Char_Space) {
                        *pVVram = c;
                    }
                    ++pVVram;
                    ++pChars;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}
