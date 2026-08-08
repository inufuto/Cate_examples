#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

extern void _deb();

constexpr byte ScoreLeft = 15;
constexpr byte Char_Remain = Char_Sprite;

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
        pVram = Vram + 3 * VramRowSize + ScoreLeft * AsciiWidth;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    PrintScore();
    PrintTime();
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
        0x00, 0x3e, 0x7e, 0xc8, 0x88, 0xc8, 0x7e, 0x3e, //	A
        0x00, 0xfe, 0xfe, 0x02, 0x7e, 0x02, 0xfe, 0xfc, //	W
        0x00, 0x3e, 0x7e, 0xc8, 0x88, 0xc8, 0x7e, 0x3e, //	A
        0x00, 0x64, 0xf6, 0x92, 0x92, 0x92, 0xde, 0x4c, //	S
        0x00, 0x64, 0xf6, 0x92, 0x92, 0x92, 0xde, 0x4c, //	S
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
    PrintS(Vram + VramRowSize * 2 + 0 / 2 * AsciiWidth, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 3 + 0 / 2 * AsciiWidth, "OR = KEY");
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