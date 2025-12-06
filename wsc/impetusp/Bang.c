#include "Bang.h"
#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Size = 1 * CoordRate;
constexpr byte RangeX = VramWidth * CoordRate - 1;
constexpr byte InvalidY = VramHeight * CoordRate;
constexpr byte Time = 8;

Bang[MaxBangCount] Bangs;

void InitBangs()
{
    byte sprite = Sprite_Bang;
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->y = InvalidY;
        pBang->sprite = sprite;
        ++sprite;
    }
}


static void Show(ptr<Bang> pBang)
{
    ShowSprite(pBang, pBang->pattern);
}

static void Start(byte x, byte y, byte pattern)
{
    ptr<Bang> pBang;
    if (x >= RangeX) return;
    for (pBang : Bangs) {
        if (pBang->y == InvalidY) {
            pBang->x = x;
            pBang->y = y;
            pBang->clock = 0;
            pBang->pattern = pattern;
            Show(pBang);
            return;
        }
    }
}

void StartSmallBang(byte x, byte y)
{
    Start(x - Size, y - Size, Pattern_SmallBang);
}


void StartLargeBang(byte x, byte y)
{
    Start(x - Size * 2, y - Size * 2, Pattern_LargeBang);
    Start(x, y - Size * 2, Pattern_LargeBang + 1);
    Start(x - Size * 2, y, Pattern_LargeBang + 2);
    Start(x, y, Pattern_LargeBang + 3);
}


void UpdateBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if (pBang->y != InvalidY) {
            ++pBang->clock;
            if (pBang->clock >= Time) {
                HideSprite(pBang->sprite);
                pBang->y = InvalidY;
            }
            else {
                Show(pBang);
            }
        }
    }
}