#include "Movable.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidPattern = 0xff;
struct Sprite {
    byte x, y;
    byte pattern;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = InvalidPattern;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->pattern = pattern;
}


void HideSprite(byte sprite) 
{
    ptr<Sprite> pSprite = Sprites + sprite;
    pSprite->pattern = InvalidPattern;
}


void DrawSprites()
{
    byte c = Char_Sprite;
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern != InvalidPattern) {
            byte pattern = p->pattern;
            byte x = p->x;
            byte xMod = x & 3;
            ptr<byte> pVVram = VVramPtr(x, p->y);
            if (pattern < Pattern_Man) {
                LocatePattern(pVVram, xMod, c);
                PutPattern(pattern);
                c += 6;
            }
            else {
                repeat (2) {
                    LocatePattern(pVVram, xMod, c);
                    repeat (2) {
                        PutPattern(pattern);
                        ++pattern;
                    }
                    c += 3;
                    pVVram += VVramWidth;
                }
            }
        }
        else {
            c += 6;
        }
    }
}
