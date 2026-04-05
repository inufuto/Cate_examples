#include "Bang.h"
#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

extern void _deb();

constexpr byte MaxTime = 8;

constexpr byte RangeX = VramWidth * CoordRate - 1;

static const byte[4] Colors = { 8, 11, 10, 9 };

Bang[MaxBangCount] Bangs;

void InitBangs()
{
    byte sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->sprite = sprite;
        pBang->time = 0;
        HideSprite(sprite);
        ++sprite;
    }
}


static void Show(ptr<Bang> pBang)
{
    ShowSprite(pBang, Pattern_Bang);
}


void StartBang(byte x, byte y)
{
    ptr<Bang> pBang;
    if (x >= RangeX) return;
    for (pBang : Bangs) {
        if (pBang->time == 0) {
            pBang->x = x;
            pBang->y = y;
            pBang->time = MaxTime * CoordRate;
            Show(pBang);
            return;
        }
    }
}


void UpdateBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if (pBang->time != 0) {
            if (--pBang->time == 0) {
                HideSprite(pBang->sprite);
            }
            else {
                Show(pBang);
            }
        }
    }
}
