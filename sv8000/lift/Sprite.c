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
    ptr<Sprite> pSprite;
    pSprite = Sprites + pMovable->sprite;
    pSprite->x = pMovable->x;
    pSprite->y = pMovable->y;
    pSprite->code = code;
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
            byte y = pSprite->y;
            word vram = VramAddress(pSprite->x, y);
            byte c = pSprite->code;
            if (y >= StageTop) {
                vram = VAddOver(vram, c);
                ++c;
                vram = VAddOver(vram, c);
                ++c;
            }
            else {
                vram += 2;
                c += 2;
            }
            ++y;
            if (y < VramHeight) {
                vram += VramRowSize - 2;
                vram = VAddOver(vram, c);
                ++c;
                VAddOver(vram, c);
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
            word vram = VramAddress(x, y);
            if (y >= StageTop) {
                vram = VAddOver(vram, Char_Space);
                vram = VAddOver(vram, Char_Space);
            }
            else {
                vram += 2;
            }
            ++y;
            if (y < VramHeight) {
                vram += VramRowSize - 2;
                vram = VAddOver(vram, Char_Space);
                VAddOver(vram, Char_Space);
            }
        }
    }
}