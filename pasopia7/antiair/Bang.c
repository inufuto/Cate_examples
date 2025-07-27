#include "Bang.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Size = 1 * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte Time = 8;

constexpr byte RangeX = WindowWidth * CoordRate - 1;

Bang[MaxBangCount] Bangs;

void InitBangs()
{
    byte sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->_.y = InvalidY;
        pBang->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


static void Show(ptr<Bang> pBang)
{
    ShowSprite(&pBang->_, pBang->pattern);
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
        pBang->clock = 0;
        pBang->pattern = pattern;
        Show(pBang);
        return;
    }
}


void StartSmallBang(byte x, byte y)
{
    Start(x - Size, y - Size, Char_SmallBang);
}


void StartLargeBang(byte x, byte y)
{
    Start(x - Size * 2, y - Size * 2, Char_LargeBang + 0 * 4);
    Start(x, y - Size * 2, Char_LargeBang + 1 * 4);
    Start(x - Size * 2, y, Char_LargeBang + 2 * 4);
    Start(x, y, Char_LargeBang + 3 * 4);
}


void UpdateBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if (pBang->_.y == InvalidY) continue;
        ++pBang->clock;
        if (pBang->clock >= Time) {
            HideSprite(pBang->_.sprite);
            pBang->_.y = InvalidY;
        }
        else {
            Show(pBang);
        }
    }
}