#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "Main.h"
#include "Rader.h"

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
    PrintS(Vram + 0 * VramRowSize + ScoreLeft * VramStep, "SCORE");   
    PrintS(Vram + 1 * VramRowSize + ScoreLeft * VramStep, "STAGE");
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 10) * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Vram + 3 * VramRowSize + ScoreLeft * VramStep;
    if (RemainCount > 1) {
        const byte[] Chars = { 0x70, 0xd0, 0xe0, 0xb0, };
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2S(pVram, Chars);
            ++pVram;
            pVram = PrintC(pVram, ' ');
            pVram = PrintC(pVram, i + 0x30);
        }
        else {
            do {
                pVram = Put2S(pVram, Chars);
                ++pVram;
                --i;
            } while (i > 0);
        }
        pVram = PrintC(pVram, ' ');
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 9) * VramStep / 2, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 7) * VramStep / 2, "TIME UP");
    PresentVram();
}

void Title()
{
    static const byte[] TitleBytes = {
        0x00, 0xfe, 0xfe, 0x88, 0x8c, 0x9e, 0xf6, 0x72, //	R
        0x00, 0xfc, 0xfe, 0x02, 0x02, 0x02, 0xfe, 0xfc, //	U
        0x00, 0xfe, 0xfe, 0x88, 0x88, 0x88, 0xf8, 0x70, //	P
        0x00, 0x80, 0x80, 0xfe, 0xfe, 0x80, 0x80, 0x00, //	T
        0x00, 0xfc, 0xfe, 0x02, 0x02, 0x02, 0xfe, 0xfc, //	U
        0x00, 0x64, 0xf6, 0x92, 0x92, 0x92, 0xde, 0x4c, //	S
    };
    constexpr byte TitleLength = 6;
    constexpr byte TitleLeft = (ScoreLeft - TitleLength * 2) / 2;
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 0 + TitleLeft * VramStep;
        p = TitleBytes;
        repeat (TitleLength * CharWidth * 2) {
            *pVram = *p; ++ pVram;
            ++p;
        }
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) * VramStep, "MINI");
    }

    PrintS(Vram + VramRowSize * 2 + 2 / 2 * VramStep, "PUSH SPC KEY");
    PrintS(Vram + VramRowSize * 3 + 2 / 2 * VramStep, "OR = KEY");
    PrintS(Vram + VramRowSize * 3 + 18 * VramStep, "INUFUTO 2023");

    PresentVram();
}
