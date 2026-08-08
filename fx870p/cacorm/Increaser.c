#include "Movable.h"
#include "Increaser.h"
#include "Sprite.h"

// constexpr byte Color = 3;
constexpr byte InvalidY = 0xe0;

Movable Increaser;

void InitIncreaser()
{
    Increaser.sprite = Sprite_Increaser;
    HideIncreaser();
}


void ShowIncreaser(byte x, byte y)
{
    const byte[] Chars = { 0x40, 0x40, 0xd0, 0xc0, };
    Increaser.x = x;
    Increaser.y = y;
    ShowSprite(&Increaser, Chars);
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