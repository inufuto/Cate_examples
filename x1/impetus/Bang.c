#include "Bang.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Count = SpriteCount - Sprite_Bang;
constexpr byte Size = 1 * CoordRate;
constexpr byte NextSprite = SpriteCount;

constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte RangeX = VVramWidth * CoordRate - 1;
constexpr byte RangeY = VVramHeight * CoordRate;

// static const byte[4] Colors = { 8, 11, 10, 9 };

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
        // color = Colors[count & 3];

        if (mode == Status_Large_Large) {
            ShowSprite(
                sprite,
                pBang->x - Size * 2, pBang->y - Size * 2,
                GChar_LargeBang
            );
        }
        else {
            ShowSprite(
                sprite, pBang->x - Size, pBang->y - Size, GChar_SmallBang
            );
        }
        ++sprite;

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