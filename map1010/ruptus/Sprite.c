#include "Sprite.h"
#include "Window.h"
#include "Chars.h"
#include "Vram.h"
#include "Init.h"

constexpr byte InvalidCode = 0xff;
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
            byte iy;
            offset = WindowOffset(p->oldX, p->oldY);
            pFront = WindowFront + offset;
            pBack = WindowBack + offset;
            pFront[0] = pBack[0];
            if (p->oldCode >= Char_Fighter) {
                pFront[1] = pBack[1];
                pFront[WindowWidth] = pBack[WindowWidth];
                pFront[WindowWidth + 1] = pBack[WindowWidth + 1];
                SetRowFlag2(p->oldY);
            }
            else {
                SetRowFlag(p->oldY);
            }
            PollVSync();
        }
    }
}


bool DrawSprites()
{
    bool changedAny;
    ptr<Sprite> p;
    changedAny = false;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pFront;
            byte iy, c;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            pFront = WindowFront + WindowOffset(p->x, p->y);
            c = p->code;
            pFront[0] = c; 
            if (p->code >= Char_Fighter) {
                ++c; pFront[1] = c;
                ++c; pFront[WindowWidth] = c;
                ++c; pFront[WindowWidth + 1] = c;
                if (changed) {
                    SetRowFlag2(p->y);
                    changedAny = true;
                }
            }
            else {
                if (changed) {
                    SetRowFlag(p->y);
                    changedAny = true;
                }
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
        PollVSync();
    }
    return changedAny;
}
