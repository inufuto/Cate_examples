#include "Bang.h"
#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Count = SpriteCount - Sprite_Bang;
constexpr byte Size = 1 * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte Time = 8;

constexpr byte RangeX = VVramWidth * CoordRate - 1;
// constexpr byte RangeY = VVramHeight * CoordRate;

static const byte[4] Colors = { 8, 11, 10, 9 };

Bang[Count] Bangs;

void InitBangs()
{
    byte sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->_.y = InvalidY;
        pBang->_.sprite = sprite;
        ++sprite;
    }
}


static void Show(ptr<Bang> pBang)
{
    byte color;
    color = Colors[pBang->_.clock & 3];
    ShowSprite(&pBang->_, pBang->pattern, color);
}


static void Start(byte x, byte y, byte pattern)
{
    ptr<Bang> pBang;
    if (x >= RangeX) return;
    // if (y >= RangeY) return;
    for (pBang : Bangs) {
        if (pBang->_.y != InvalidY) continue;
        pBang->_.x = x;
        pBang->_.y = y;
        pBang->_.clock = 0;
        pBang->pattern = pattern;
        Show(pBang);
        return;
    }
}


void StartSmallBang(byte x, byte y)
{
    Start(x - Size, y - Size, Pattern_SmallBang);
}


void StartLargeBang(byte x, byte y)
{
    Start(x - Size * 2, y - Size * 2, Pattern_LargeBang);
    Start(x, y - Size * 2, Pattern_LargeBang + 4);
    Start(x - Size * 2, y, Pattern_LargeBang + 8);
    Start(x, y, Pattern_LargeBang + 12);
}


void UpdateBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if (pBang->_.y == InvalidY) continue;
        ++pBang->_.clock;
        if (pBang->_.clock >= Time) {
            HideSprite(pBang->_.sprite);
            pBang->_.y = InvalidY;
        }
        else {
            Show(pBang);
        }
    }
}