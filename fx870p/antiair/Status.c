#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Sprite.h"
#include "Cannon.h"

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
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, CannonChars);
                Erase2(pVram);
                pVram = PrintC(pVram, i + '0');
            }
            else {
                do {
                    pVram = Put2S(pVram, CannonChars);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) * VramStep, Score);
    PrintC(pVram, '0');
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


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x7e, 0xfe, 0x88, 0x88, 0xfe, 0x7e, 0x00, 0xf8, 
            0xf8, 0x60, 0x30, 0xf8, 0xf8, 0x00, 0x80, 0x80, 
            0xf8, 0xf8, 0x80, 0x80, 0x00, 0xf8, 0xf8, 0x00, 
            0x00, 0x7e, 0xfe, 0x88, 0x88, 0xfe, 0x7e, 0x00, 
            0x3e, 0x3e, 0x00, 0x3e, 0x3e, 0x24, 0x3e, 0x1a, 
        };
        constexpr byte TitleLength = 5;
        constexpr byte TitleLeft = (ScoreLeft - TitleLength * 2) / 2;
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

    PrintS(Vram + VramRowSize * 2 + 0 / 2 * VramStep, "PUSH SPC KEY");
    PrintS(Vram + VramRowSize * 3 + 0 / 2 * VramStep, "OR = KEY");
    PrintS(Vram + VramRowSize * 3 + 18 * VramStep, "INUFUTO 2024");
    // {
    //     byte c;
    //     word v;
    //     // UfoRowLeft = 0;
    //     UpdateChars();
    //     SwitchChars();
    //     UpdateChars();
    //     SwitchChars();
    //     v = Vram;
    //     c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             v += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}
