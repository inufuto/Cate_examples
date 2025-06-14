#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

extern void _deb();

constexpr byte ScoreLeft = 15;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 * VramRowSize + ScoreLeft * AsciiWidth, "SCORE");   
    PrintS(Vram + 1 * VramRowSize + ScoreLeft * AsciiWidth, "STAGE");
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 10) * AsciiWidth, CurrentStage + 1);
    PrintS(Vram + 2 * VramRowSize + ScoreLeft * AsciiWidth, "TIME");
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + (ScoreLeft + 4) * AsciiWidth;
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
    ptr<byte> pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * AsciiWidth, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 2 * VramRowSize + (ScoreLeft + 9) * AsciiWidth, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram = Vram + 3 * VramRowSize + ScoreLeft * AsciiWidth;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, Char_Knife_Up, 0);
        --i;
    }
    Put(pVram, Char_Space, 0);
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 9) * AsciiWidth / 2, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 7) * AsciiWidth / 2, "TIME UP");
    PresentVram();
}

void Title()
{
    static const byte[] TitleBytes = {
        0x00, 0xfe, 0xfe, 0x80, 0xfe, 0x80, 0xfe, 0x7e, //	M
        0x00, 0x3e, 0x7e, 0xc8, 0x88, 0xc8, 0x7e, 0x3e, //	A
        0x00, 0x86, 0x8e, 0x9a, 0xb2, 0xe2, 0xc2, 0x82, //	Z
        0x00, 0xe0, 0xf0, 0x1e, 0x1e, 0xf0, 0xe0, 0x00, //	Y
        0x00, 0x46, 0xce, 0x9e, 0x9a, 0xba, 0xf2, 0x62, //	2
    };
    constexpr byte TitleLength = 5;
    constexpr byte TitleLeft = (ScoreLeft - TitleLength * 2) / 2;
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 0 + TitleLeft * VramStep;
        p = TitleBytes;
        repeat (TitleLength * 8) {
            *pVram = *p; ++ pVram;
            ++p;
        }
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) * AsciiWidth, "NANO");
    }
    PrintS(Vram + VramRowSize * 2 + 2 / 2 * VramStep, "PUSH SPC KEY");
    PrintS(Vram + VramRowSize * 3 + 2 / 2 * VramStep, "OR = KEY");
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