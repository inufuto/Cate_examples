#include "VVram.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;


void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawSprites();
        VVramToVram();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVram();
    }
}


void VErase2(byte x, byte y)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    VVramChanged = true;
}

void VPut2C(byte x, byte y, byte c)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = c;
            ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
    VVramChanged = true;
}

void VPut2S(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = *pChars;
            ++pVVram;
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
    VVramChanged = true;
}

void MapToVVram() 
{
    {
        ptr<byte> pVVram;
        ptr<byte> pMap;
        byte b, bit;
        word count;

        pVVram = VVramBack;
        pMap = WallMap;
        b = *pMap;
        ++pMap;
        bit = 1;
        count = StageWidth * StageHeight;
        do {
            if ((b & bit) != 0) {
                *pVVram = Char_Wall;
            }
            else {
                *pVVram = Char_Space;
            }
            ++pVVram;
            if ((bit <<= 1) == 0) {
                b = *pMap;
                ++pMap;
                bit = 1;
            }
        } while (--count != 0);
    }
    // {
    //     byte x, y;
    //     ptr<byte> pVVram;

    //     pVVram = VVramBack;
    //     for (y = 0; y < StageHeight; ++y) {
    //         for (x = 0; x < StageWidth; ++x) {
    //             byte c, old;
    //             old = pVVram[0];
    //             c = old;
    //             if (x > 0 && pVVram[-1] != 0) {
    //                 c &= ~Wall_Left;
    //             }
    //             if (pVVram[1] != 0) {
    //                 c &= ~Wall_Right;
    //             }
    //             if (y > 0 && pVVram[-StageWidth] != 0) {
    //                 c &= ~Wall_Top;
    //             }
    //             if (y < StageHeight-1 && pVVram[StageWidth] != 0) {
    //                 c &= ~Wall_Bottom;
    //             }
    //             if (c == 0 && old != 0) {
    //                 c = 0x10;
    //             }
    //             *pVVram = c;
    //             ++pVVram;
    //         }
    //     }
    // }
    // {
    //     ptr<byte> pVVram;
    //     word count;
    //     byte c;

    //     pVVram = VVramBack;
    //     count = StageWidth * StageHeight;
    //     do {
    //         c = *pVVram;
    //         if (c == 0 || c == 0x10) {
    //             c = Char_Wall;
    //         }
    //         else  {
    //             c += Char_Wall;
    //         }
    //         *pVVram = c;
    //         ++pVVram;
    //         --count;
    //     }
    //     while (count != 0);
    // }
}
