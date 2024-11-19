#include "Bang.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"

extern void _deb();

constexpr byte Size = 1 * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte Time = 8;

constexpr byte RangeX = VVramWidth * CoordRate - 1;

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
    ShowSprite(&pBang->_, pBang->pChars);
}


static void Start(byte x, byte y, ptr<byte> pChars)
{
    ptr<Bang> pBang;
    if (x >= RangeX) return;
    // if (y >= RangeY) return;
    for (pBang : Bangs) {
        if (pBang->_.y != InvalidY) continue;
        pBang->_.x = x;
        pBang->_.y = y;
        pBang->clock = 0;
        pBang->pChars = pChars;
        Show(pBang);
        return;
    }
}


void StartSmallBang(byte x, byte y)
{
    static const byte[] Chars = {
        0x0e, 0x0b, 0x0d, 0x06,
    };
    Start(x - Size, y - Size, Chars);
}


void StartLargeBang(byte x, byte y)
{
    static const byte[] Chars = {
        0x09, 0x0e, 0x0f, 0x08,
        0x0b, 0x06, 0x04, 0x07,
	    0x0d, 0x02, 0x06, 0x0d,
        0x09, 0x0f, 0x07, 0x09,
    };
    Start(x - Size * 2, y - Size * 2, Chars + 0 * 2);
    Start(x, y - Size * 2, Chars + 1 * 2);
    Start(x - Size * 2, y, Chars + 2 * 2);
    Start(x, y, Chars + 3 * 2);
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