#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
#include "Vram.h"

constexpr byte InvalidCode = 0xff;

struct Sprite {
    byte x, y, code;
    byte oldX, oldY, oldCode;
};
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
        if (p->oldCode != InvalidCode && (p->oldX != p->x || p->oldY != p->y)) {
            word offset;
            ptr<byte> pFront, pBack;
            offset = VVramOffset(p->oldX, p->oldY);
            pFront = VVramFront + offset;
            pBack = VVramBack + offset;
            if (p->oldCode >= Char_Fighter) {
                repeat (2) {
                    repeat (2) {
                        *pFront = *pBack;
                        ++pFront;
                        ++pBack;
                    }
                    pFront += VVramWidth - 2;
                    pBack += VVramWidth - 2;
                }
            }
            else {
                *pFront = *pBack;
            }
        }
    }
}


void DrawSprites()
{
    bool changed;
    ptr<Sprite> p;
    changed = false;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            ptr<byte> pFront;
            byte x, y, c;
            x = p->x;
            y = p->y;
            pFront = VVramFront + VVramOffset(x, y);
            c = p->code;
            if (p->code >= Char_Fighter) {
                repeat (2) {
                    if (y < VVramHeight) {
                        repeat (2) {
                            if (c != 0 && x < VVramWidth) {
                                *pFront = c;
                            }
                            ++pFront;
                            ++c;
                            ++x;
                        }
                        x -= 2;
                    }
                    pFront += VVramWidth - 2;
                    ++y;
                }
            }
            else {
                *pFront = c;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
