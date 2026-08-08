#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

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
    PrintS(Vram + 2 * VramRowSize + ScoreLeft * VramStep, "TIME");
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + ScoreLeft * VramStep;
        if (RemainCount > 1) {
            const byte[] Chars = {
                0x60, 0xc0, 0x60, 0x90,
            };
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
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * VramStep, Score);
    PrintC(pVram, '0');

    // pVram = PrintNumber5(Vram + 9 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 2 * VramRowSize + (ScoreLeft + 9) * VramStep, StageTime);
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
		0x38, 0x7c, 0xc6, 0x82, 0x82, 0xc6, 0x44, 0x00, 
		0x04, 0x2e, 0x2a, 0x3e, 0x1e, 0x00, 0x1c, 0x3e, 
		0x22, 0x36, 0x14, 0x00, 0x1c, 0x3e, 0x22, 0x3e, 
		0x1c, 0x00, 0x3e, 0x3e, 0x10, 0x20, 0x20, 0x00, 
		0x3e, 0x3e, 0x20, 0x3e, 0x20, 0x3e, 0x1e, 0x00, 
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
        repeat (TitleLength * CharWidth * 2) {
            *pVram = *p; ++ pVram;
            ++p;
        }
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) * VramStep, "MINI");
    }

    PrintS(Vram + VramRowSize * 2 + 0 / 2 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 3 + 0 / 2 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 3 + 18 * VramStep, "INUFUTO 2023");

    PresentVram();
}