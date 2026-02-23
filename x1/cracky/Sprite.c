#include "Movable.h"
#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"

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


void ShowSprite(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y;
    p->code = code;
    PollVSync();
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->code = InvalidCode;
    PollVSync();
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
            byte y;
            y = p->oldY;
            SetRowFlags(y, 3);
            pVVram = VVramPtr(p->oldX, y);
            repeat (2) {
                repeat (2) {
                    *pVVram = 0; ++pVVram;
                }
                pVVram += VVramWidth - 2;
            }
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        PollVSync();
        if (p->code != InvalidCode) {
            ptr<byte> pVVram;
            byte c, y;
            y = p->y;
            SetRowFlags(y, 3);
            pVVram = VVramPtr(p->x, y);
            c = p->code;
            repeat (2) {
                repeat (2) {
                    *pVVram = c; ++pVVram;
                    ++c;
                }
                pVVram += VVramWidth - 2;
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
