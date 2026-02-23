#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"

constexpr byte InvalidCode = 0xff;
struct Sprite {
    byte x, y;
    byte code;
    byte oldX, oldY;
    byte oldCode;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->code = InvalidCode;
        p->oldCode = InvalidCode;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> p;
    byte x, y;
    p = Sprites + pMovable->sprite;
    x = pMovable->x - LeftX;
    y = pMovable->y;
    if (x < VVramWidth && y < VVramHeight) {
        p->x = x;
        p->y = y;
        p->code = code;
    }
    else {
        p->code = InvalidCode;
    }
    PollVSync();
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
        if (p->oldCode != InvalidCode && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->code == InvalidCode
        )) {
            ptr<byte> pVVram;
            byte x, y;
            x = p->oldX;
            y = p->oldY;
            pVVram = VVramFront + VVramOffset(x, y);
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            *pVVram = Char_Space;
                        }
                        ++x;
                        ++pVVram;
                    }
                    pVVram += VVramWidth - 2;
                    x -= 2;
                    ++y;
                }
                else {
                    pVVram += VVramWidth;
                    ++y;
                }
            }
        }
    }
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
            pVVram = VVramFront + VVramOffset(x, y);
            c = p->code;
            repeat (2) {
                if (y < VVramHeight) {
                    repeat (2) {
                        if (x < VVramWidth) {
                            *pVVram = c;
                        }
                        ++x;
                        ++pVVram;
                        ++c;
                    }
                    pVVram += VVramWidth - 2;
                    x -= 2;
                    ++y;
                }
                else {
                    pVVram += VVramWidth;
                    ++y;
                    c += 2;
                }
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
