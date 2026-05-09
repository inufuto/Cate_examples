#include "Sprite.h"
#include "Vram.h"

constexpr byte InvalidY = 0xf0;

struct Sprite {
    byte x, y;
    byte[4] chars;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite: Sprites) {
        pSprite->y = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    ptr<byte> p = pSprite->chars;
    repeat (4) {
        *p = *pChars;
        ++p;
        ++pChars;
    }
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite = Sprites + Sprite_End;
    repeat (Sprite_End) {
        --pSprite;
        byte x = pSprite->x;
        byte y = pSprite->y;
        if (y <= VramHeight - 1 && x <= VramWidth - 1) {
            ptr<byte> pVram = VramPtr(x, y + StageTop);
            ptr<byte> p = pSprite->chars;
            repeat (2) {
                repeat (2) {
                    byte c = *p;
                    if (c != 0) {
                        *pVram = c;
                    }
                    ++pVram;
                    ++p;
                }
                pVram += VramRowSize - 2 * VramStep;
            }
        }
    }
}
