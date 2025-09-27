#include "Sprite.h"
#include "Vram.h"

constexpr byte Invalidpattern = 0xff;
constexpr byte MaxY = VramHeight * CharHeight - CharHeight * 2;

struct Element {
    byte x, y, pattern;
};
struct Sprite {
    Element now;
    Element old0;
    Element old1;
};
Sprite[SpriteCount] Sprites;

void InitSprites()
{
    HideAllSprites();
}

void HideAllSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        p->now.pattern = Invalidpattern;
        p->old0.pattern = Invalidpattern;
        p->old1.pattern = Invalidpattern;
    }
}


void ShowSprite(byte index, byte x, byte y, sbyte pattern)
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.x = x;
    p->now.y = y;
    p->now.pattern = pattern;
}


void HideSprite(byte index) 
{
    ptr<Sprite> p;
    p = Sprites + index;
    p->now.pattern = Invalidpattern;
}


void EraseSprites()
{
    ptr<Sprite> p;
    for (p : Sprites) {
        if (p->old1.pattern != Invalidpattern && p->old1.y <= MaxY) {
            EraseSprite(p->old1.x, p->old1.y);
        }
        if (p->old0.pattern != Invalidpattern && p->old0.y <= MaxY) {
            p->old1.x = p->old0.x;
            p->old1.y = p->old0.y;
            p->old1.pattern = p->old0.pattern;
        }
    }
}


void DrawSprites()
{
    ptr<Sprite> p;
    p = Sprites + SpriteCount - 1;
    repeat (SpriteCount) {
        if (p->now.pattern != Invalidpattern && p->now.y <= MaxY) {
            DrawSprite(p->now.x, p->now.y, p->now.pattern);
        }
        p->old0.x = p->now.x;
        p->old0.y = p->now.y;
        p->old0.pattern = p->now.pattern;
        --p;
    }
}
