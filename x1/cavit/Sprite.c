#include "Sprite.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"
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
            byte y;
            y = p->oldY;
            pVVram = VVramPtr(p->oldX, y);
            pVVram[0] = GChar_Space;
            pVVram[1] = GChar_Space;
            pVVram[VVramWidth] = GChar_Space;
            pVVram[VVramWidth + 1] = GChar_Space;
            SetRowFlags(y);
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->code != InvalidCode) {
            bool changed;
            ptr<byte> pVVram;
            byte y, c;
            changed = p->oldX != p->x || p->oldY != p->y || p->oldCode != p->code;
            y = p->y;
            pVVram = VVramPtr(p->x, y);
            c = p->code;
            pVVram[0] = c; 
            ++c; pVVram[1] = c;
            ++c; pVVram[VVramWidth] = c;
            ++c; pVVram[VVramWidth + 1] = c;
            if (changed) {
                SetRowFlags(y);
            }
            PollVSync();
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldCode = p->code;
    }
}
