#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"

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
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + ScoreLeft * VramStep;
        if (RemainCount > 1) {
            const byte[] Chars = { 0xd0, 0x00, 0x70, 0xa0, };
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, Chars);
                pVram = PrintC(pVram, ' ');
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    pVram = Put2S(pVram, Chars);
                    --i;
                } while (i > 0);
            }
        }
        pVram = PrintC(pVram, ' ');
        pVram = PrintC(pVram, ' ');
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * VramStep, Score);
    PrintC(pVram, '0');

    // pVram = PrintNumber5(Vram + 9 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 10) * VramStep, CurrentStage + 1);
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
        0x00, 0x3e, 0x7e, 0xc8, 0x88, 0xc8, 0x7e, 0x3e, //	A
        0x00, 0xfe, 0xfe, 0x92, 0x92, 0x92, 0x92, 0x00, //	E
        0x00, 0xfe, 0xfe, 0x88, 0x8c, 0x9e, 0xf6, 0x72, //	R
        0x00, 0x82, 0x82, 0xfe, 0xfe, 0x82, 0x82, 0x00, //	I
        0x00, 0x3e, 0x7e, 0xc8, 0x88, 0xc8, 0x7e, 0x3e, //	A
        0x00, 0xfe, 0xfe, 0x02, 0x02, 0x02, 0x02, 0x00, //	L
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