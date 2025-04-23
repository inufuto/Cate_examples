#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

constexpr word VVramSize = StageWidth * StageHeight;

Sprite[SpriteCount] Sprites;

void ShowSprite(byte index, byte x, byte y, sbyte pattern) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->x = (x + 4) >> 3;
    p->y = (y + 4) >> 3;
    p->pattern = pattern;
}

void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->pattern = -1;
}

static ptr<byte> VVramPointer(byte x, byte y) {
    return VVram + ((word)y << 5) + x;
}

void EraseSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->oldPattern >= 0 && (
            p->oldX != p->x || 
            p->oldY != p->y ||
            p->pattern > 0
        )) {
            ptr<byte> pVVram, pBG;
            pVVram = VVramPointer(p->oldX, p->oldY);
            pBG = pVVram + VVramSize;
            pVVram[0] = pBG[0];
            pVVram[1] = pBG[1];
            pVVram[32] = pBG[32];
            pVVram[32 + 1] = pBG[32 + 1];
            SetRowFlag2(p->oldY);
        }
    }
}

void DrawSprites() 
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->pattern >= 0) {
            bool changed;
            ptr<byte> pVVram;
            byte c;

            changed = p->oldX != p->x || p->oldY != p->y || p->oldPattern != p->pattern;
            pVVram = VVramPointer(p->x, p->y);
            c = (p->pattern << 2) + Char_Sprite;
            pVVram[0] = c++;
            pVVram[1] = c++;
            pVVram[32] = c++;
            pVVram[32 + 1] = c++;
            if (changed) {
                SetRowFlag2(p->y);
            }
        }
        p->oldX = p->x;
        p->oldY = p->y;
        p->oldPattern = p->pattern;
    }
}

void InitSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->pattern = -1;
        p->oldPattern = -1;
    }
}
