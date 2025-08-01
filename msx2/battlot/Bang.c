#include "Bang.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte MaxCount = (Sprite_Mono - Sprite_Bang) / 2;
constexpr byte Size = 2;
constexpr byte SizeInCoord = Size * CoordRate;
constexpr byte Status_None = 0x00;
constexpr byte Status_Small = 0x10;
constexpr byte Status_Large_Small = 0x20;
constexpr byte Status_Large_Large = 0x30;

constexpr byte StatusMask = 0xf0;
constexpr byte CountMask = 0x0f;

constexpr byte InvalidSprite = 0x80;

Bang[MaxCount] Bangs;

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
    byte x, y, sprite;
    ptr<Bang> pBang;
    sprite = Sprite_Bang;
    for (pBang : Bangs) {
        byte mode, count;
        mode = pBang->status & 0xf0;
        if (mode == Status_None) continue;
        count = pBang->status & 0x0f;

        x = pBang->x;
        y = pBang->y + StageTop * CoordRate;
        if (mode == Status_Large_Large) {
            byte pattern;
            x -= SizeInCoord / 2;
            y -= SizeInCoord / 2;
            pattern = Pattern_LargeBang;
            repeat (2) {
                repeat (2) {
                    ShowSpriteC(sprite, x, y, pattern);
                    sprite += 2;
                    pattern += 2;
                    x += SizeInCoord;
                }
                x -= SizeInCoord * 2;
                y += SizeInCoord;
            }
        }
        else {
            ShowSpriteC(sprite, x, y, Pattern_SmallBang);
            sprite += 2;
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
    while (sprite < Sprite_Mono) {
        HideSprite(sprite);
        sprite += 2;
    }
}