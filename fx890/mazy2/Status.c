#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

extern void _deb();

constexpr byte ScoreLeft = 15;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p, bool right)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c, right);
        ++p;
        right = !right;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 * VramRowSize + ScoreLeft / 2, "SCORE", true);
    PrintS(Vram + 1 * VramRowSize + ScoreLeft / 2, "STAGE", true);
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 10) / 2, CurrentStage + 1, true);
    PrintS(Vram + 2 * VramRowSize + ScoreLeft / 2, "TIME", true);
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + (ScoreLeft + 4) / 2;
        CharShift = 4;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                pVram = Put2C(pVram, Char_Man);
                --i;
            } while (i != 0);
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) / 2, Score, true);
    PrintC(pVram, '0', false);
}

void PrintTime()
{
    PrintByteNumber3(Vram + 2 * VramRowSize + (ScoreLeft + 9) / 2, StageTime, false);
}

void PrintHeldKnives()
{
    ptr<byte> pVram = Vram + 3 * VramRowSize + ScoreLeft / 2;
    CharShift = 4;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, Char_Knife_Up);
        --i;
    }
    Put(pVram, Char_Space);
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 9) / 2 / 2, "GAME OVER", false);
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 7) / 2 / 2, "TIME UP", false);
    PresentVram();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x7e, 0x6b, 0x6b, 0x6b, 0x6b, 0x6b, 0x6b, 0x00, //	M
            0x1c, 0x36, 0x63, 0x63, 0x7f, 0x63, 0x63, 0x00, //	A
            0x7f, 0x06, 0x0c, 0x18, 0x30, 0x60, 0x7f, 0x00, //	Z
            0x66, 0x66, 0x66, 0x3c, 0x18, 0x18, 0x18, 0x00, //	Y
            0x3e, 0x63, 0x07, 0x1e, 0x3c, 0x70, 0x7f, 0x00, //	2
        };
        constexpr byte TitleLength = 5;
        constexpr byte TitleLeft = (ScoreLeft - TitleLength * 2) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 0 + TitleLeft / 2;
        p = TitleBytes;
        repeat (TitleLength) {
            repeat (8) {
                *pVram = *p;
                ++p;
                pVram += VramWidth;
            }
            pVram -= VramWidth * 8 - 1;
        }
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) / 2, "NANO", false);
    }
    PrintS(Vram + VramRowSize * 2 + 0 / 2 / 2, "PUSH SPACE KEY", false);
    PrintS(Vram + VramRowSize * 3 + 0 / 2 / 2, "OR SHIFT KEY", false);
    // {
    //     ptr<byte> pVram = Vram;
    //     byte shift = 0;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c, shift);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram -=16 * VramStep;
    //             shift += 3;
    //             if (shift >= 8) {
    //                 shift -= 3;
    //                 pVram += VramRowSize;
    //             }
    //         }
    //     }
    // }
    PresentVram();
}