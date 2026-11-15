#include "Sprite.h"
#include "Chars.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidY = 0xff;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte code;
};

Sprite[SpriteCount] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
        pSprite->oldY = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte code)
{
    ptr<Sprite> p;
    p = Sprites + pMovable->sprite;
    p->x = pMovable->x;
    p->y = pMovable->y + StageTop;
    p->code = code;
}


void HideSprite(byte index)
{
    ptr<Sprite> pSprite;
    pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        if (pSprite->y != InvalidY) {
            word vram = VramAddress(pSprite->x, pSprite->y);
            byte c = pSprite->code;
            vram = VAdd(vram, c); 
            ++c; vram = VAdd(vram, c);
            vram += VramRowSize - 2;
            ++c; vram = VAdd(vram, c);
            ++c; vram = VAdd(vram, c);
        }
        pSprite->oldX = pSprite->x;
        pSprite->oldY = pSprite->y;
    }
}


void EraseSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        byte x = pSprite->oldX;
        byte y = pSprite->oldY;
        if (
            pSprite->oldY != InvalidY &&
            (pSprite->x != x || pSprite->y != y)
        ) {
            DrawCellXY(x, y);
        }
    }
}