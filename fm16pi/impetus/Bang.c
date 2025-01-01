#include "Bang.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Size = 1 * CoordRate;

constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte RangeX = VVramWidth * CoordRate - 1;
constexpr byte RangeY = VVramHeight * CoordRate;

Bang[BangCount] Bangs;

void InitBangs()
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        ptr<byte> pSprite;
        pBang->status = Status_None;
    }
}


void StartBang(byte x, byte y, bool large)
{
    ptr<Bang> pBang;
    for (pBang : Bangs) {
        if ((pBang->status & 0xf0) != Status_None) continue;

        pBang->x = x;
        pBang->y = y;
        pBang->status = large ? Status_Large_Small : Status_Small;
        return;
    }
}



static byte Show(byte x, byte y, byte sprite, byte pattern)
{
    if (sprite < Sprite_Bang + BangCount) {
        x -= Size;
        y -= Size;
        if (x < RangeX && y < RangeY) {
            ShowSprite(sprite, x, y, pattern);
            return sprite + 1;
        }
    }
    return sprite;
}


void UpdateBangs()
{
    byte sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        byte mode, count;
        mode = pBang->status & 0xf0;
        if (mode == Status_None) continue;
        count = pBang->status & 0x0f;

        if (mode == Status_Large_Large) {
            sprite = Show(pBang->x - Size, pBang->y - Size, sprite, Pattern_LargeBang + 0);
            sprite = Show(pBang->x + Size, pBang->y - Size, sprite, Pattern_LargeBang + 1);
            sprite = Show(pBang->x - Size, pBang->y + Size, sprite, Pattern_LargeBang + 2);
            sprite = Show(pBang->x + Size, pBang->y + Size, sprite, Pattern_LargeBang + 3);
        }
        else {
            sprite = Show(pBang->x, pBang->y, sprite, Pattern_SmallBang);
        }

        ++count;
        if (count >= 8) {
            if (mode == Status_Large_Small) {
                pBang->status = Status_Large_Large;
            }
            else {
                pBang->status = Status_None;
            }
        }
        else {
            pBang->status = mode | count;
        }
    }
    while (sprite < Sprite_Bang + BangCount) {
        HideSprite(sprite);
        ++sprite;
    }
}