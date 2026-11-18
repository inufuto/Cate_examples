#include "Sprite.h"
#include "Chars.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte InvalidY = 0xf0;
struct Sprite {
    byte x, y;
    byte oldX, oldY;
    byte c;
};
Sprite[Sprite_End] Sprites;

void HideAllSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        pSprite->y = InvalidY;
        pSprite->oldY = InvalidY;
    }
}


void ShowSprite(ptr<Movable> pMovable, byte pattern)
{
    ptr<Sprite> pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->c = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> pSprite = Sprites + index;
    pSprite->y = InvalidY;
}


void DrawSprites()
{
    ptr<Sprite> pSprite;
    for (pSprite : Sprites) {
        byte y = pSprite->y;
        if (y != InvalidY) {
            word vram = VramAddress(pSprite->x, y + StageTop);
            byte c = pSprite->c;
            repeat (2) {
                repeat (2) {
                    if (c != 0) {
                        vram = VAddOver(vram, c);
                    }
                    else {
                        ++vram;
                    }
                    ++c;
                }
                vram += VramRowSize - 2;
            }
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