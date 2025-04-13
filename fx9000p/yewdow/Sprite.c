#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"


constexpr byte InvalidCode = 0xff;
struct Sprite {
    byte x, y;
    byte code;
};
Sprite[Sprite_End] Sprites;

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
            byte x, y, c;
            x = p->x;
            y = p->y;
            pVVram = VVramPtr(x + 1, y + 1) - (VVramWidth + 1);
            c = p->code;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            *pVVram = c;
                        }
                        ++pVVram;
                        ++c;
                        ++x;
                    }
                    x -= 2;
                    pVVram -= 2;
                }
                else {
                    c += 2;
                }
                pVVram += VVramWidth;
                ++y;
            }
        }
    }
}
