#include "Movable.h"
#include "Increaser.h"
#include "Sprite.h"
#include "Chars.h"

constexpr byte Color = 12;
constexpr byte InvalidY = 0xe0;

Movable Increaser;

void InitIncreaser()
{
    Increaser.sprite = Sprite_Increaser;
    HideIncreaser();
}


void ShowIncreaser(byte x, byte y)
{
    Increaser.x = x;
    Increaser.y = y;
    ShowSpriteM(&Increaser, Pattern_Increaser, Color);
}


void HideIncreaser()
{
    Increaser.y = InvalidY;
    HideSprite(Increaser.sprite);
}


bool IsIncreaserVisible()
{
    return Increaser.y < InvalidY;
}