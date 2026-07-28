#include "Vram.h"
#include "Sprite.h"

extern void _deb();

void TileSprites(byte index, byte x, byte y, byte pattern, byte count, byte color)
{
    do {
        ClearPattern(pattern);
        ShowSpriteXY(index, x, y, pattern, color);
        x += SpriteWidth;
        ++index;
        ++pattern;
        --count;
    } while (count != 0);
}