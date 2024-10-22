#include "Bang.h"
#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte MaxCount = 12;
constexpr byte Size = 2;
constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte InvalidSprite = 0x80;

Bang[MaxCount] Bangs;

void InitBans()
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


static byte Locate(byte x, byte y, byte sprite, byte pattern)
{
    if (sprite >= Sprite_End) goto end;
    x = OffsetX(x);
    if (x >= WindowWidth * 2) goto end;
    y = OffsetY(y);
    if (y >= WindowHeight * 2) goto end;
    x -= Size;
    y -= Size;
    if (x < (WindowWidth -Size) * 2 && y < (WindowHeight - Size) * 2) {
        ShowSprite(sprite, x << 2, y << 2, pattern);
        return sprite + 1;
    }
end:
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
            sprite = Locate(pBang->x - Size, pBang->y - Size, sprite, Pattern_LargeBang + 0);
            sprite = Locate(pBang->x + Size, pBang->y - Size, sprite, Pattern_LargeBang + 1);
            sprite = Locate(pBang->x - Size, pBang->y + Size, sprite, Pattern_LargeBang + 2);
            sprite = Locate(pBang->x + Size, pBang->y + Size, sprite, Pattern_LargeBang + 3);
        }
        else {
            sprite = Locate(pBang->x, pBang->y, sprite, Pattern_SmallBang);
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
    while (sprite < Sprite_End) {
        HideSprite(sprite);
        ++sprite;
    }
}