#include "Bang.h"
#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Count = 4;
constexpr byte Size = 1 * CoordRate;
constexpr byte NextSprite = SpriteCount;

constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte RangeX = WindowWidth * CoordRate - 1;
constexpr byte RangeY = WindowHeight * CoordRate;

Bang[Count] Bangs;

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
    if (sprite < NextSprite) {
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
            sprite = Show(pBang->x - Size, pBang->y - Size, sprite, Pattern_Bang + 1);
            sprite = Show(pBang->x + Size, pBang->y - Size, sprite, Pattern_Bang + 2);
            sprite = Show(pBang->x - Size, pBang->y + Size, sprite, Pattern_Bang + 3);
            sprite = Show(pBang->x + Size, pBang->y + Size, sprite, Pattern_Bang + 4);
        }
        else {
            sprite = Show(pBang->x, pBang->y, sprite, Pattern_Bang);
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
    while (sprite < NextSprite) {
        HideSprite(sprite);
        ++sprite;
    }
}