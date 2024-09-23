#include "Bang.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"

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
        pBang->y = InvalidY;
        pBang->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


static void Show(ptr<Bang> pBang)
{
    ShowSprite(pBang, pBang->pChars);
}


static void Start(byte x, byte y, ptr<byte> pChars)
{
    ptr<Bang> pBang;
    if (x >= RangeX) return;
    // if (y >= RangeY) return;
    for (pBang : Bangs) {
        if (pBang->y != InvalidY) continue;
        pBang->x = x;
        pBang->y = y;
        pBang->clock = 0;
        pBang->pChars = pChars;
        Show(pBang);
        return;
    }
}


void StartSmallBang(byte x, byte y)
{
    const byte[] Chars = {
        0xa3, 0xa2, 0xa2, 0xa3,
    };
    Start(x - Size, y - Size, Chars);
}


void StartLargeBang(byte x, byte y)
{
    const byte[] Chars = {
        0xa2, 0xa3, 0x80, 0xa9,
	    0xa2, 0xa3, 0xab, 0xa3, 0xa2, 0xaa, 0xa3, 0xa2,
	    0xa2, 0x80, 0xa3, 0xa2,
    };
    Start(x - Size * 2, y - Size * 2, Chars + 0 * 4);
    Start(x, y - Size * 2, Chars + 1 * 4);
    Start(x - Size * 2, y, Chars + 2 * 4);
    Start(x, y, Chars + 3 * 4);
}


void UpdateBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if (pBang->y == InvalidY) continue;
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