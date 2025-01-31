#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte ScoreLeft = 17;
constexpr byte Char_Remain = Char_Man;

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
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + ScoreLeft * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put(pVram, Char_Remain);
                pVram = PrintC(pVram, i + 0x30);
                pVram = PrintC(pVram, ' ');
            }
            else {
                do {
                    pVram = Put(pVram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put(Vram + 2 * VramRowSize + ScoreLeft * VramStep, Char_Food);
    PrintC(pVram, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 9) * VramStep / 2, "GAME OVER");
    PresentVram();
}

void Title()
{
    static const byte[] TitleBytes = {
		0x00, 0x00, 0x00, 0xfe, 0xfe, 0x60, 0x30, 0x60, 
		0xfe, 0xfe, 0x00, 0x5e, 0x5e, 0x00, 0x1c, 0x3e, 
		0x2a, 0x3a, 0x18, 0x00, 0x32, 0x3a, 0x0a, 0x3e, 
		0x3c, 0x00, 0x1c, 0x3e, 0x2a, 0x3a, 0x1a, 0x00, 
		0x3e, 0x3e, 0x20, 0x3e, 0x1e, 0x00, 0x00, 0x00, 
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
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) * VramStep, "NANO");
    }

    PrintS(Vram + VramRowSize * 2 + 1 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 3 + 1 * VramStep, "OR = KEY");

    PresentVram();
}