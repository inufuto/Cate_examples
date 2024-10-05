#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

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
    PrintS(StagePane, "STAGE");
    PrintByteNumber2(StagePane + 6, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = ScorePane + 10;
        if (RemainCount > 1) {
            static const byte[] Chars = {
                0xff, 0x00, 0x28, 0x08,
            };
            byte i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, Chars, false);
                pVram = PrintC(pVram, i + '0');
            }
            else {
                do {
                    pVram = Put2S(pVram, Chars, false);
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
    pVram = PrintNumber5(ScorePane, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    ptr<byte> pVram;
    pVram = PrintByteNumber3(ScorePane + 7, StageTime);
    PrintC(pVram, ' ');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (12 - 9) / 2, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (12 - 7) / 2, "TIME UP");
}

void PrintPerfect()
{
    PrintS(Vram + VramRowSize * 7 + (12 - 8) / 2, "PERFECT!");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x2a, 0xaa, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x00, 0x00, //	H
            0x0a, 0xa8, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x0a, 0xa8, 0x00, 0x00, //	O
            0x2a, 0xa8, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x2a, 0xa8, 0x28, 0x00, 0x28, 0x00, 0x00, 0x00, //	P
            0x2a, 0xa8, 0x28, 0x8a, 0x28, 0x8a, 0x28, 0x8a, 0x28, 0x8a, 0x28, 0x8a, 0x28, 0x8a, 0x00, 0x00, //	M
            0x02, 0xa0, 0x0a, 0x28, 0x28, 0x0a, 0x28, 0x0a, 0x2a, 0xaa, 0x28, 0x0a, 0x28, 0x0a, 0x00, 0x00, //	A
            0x28, 0x0a, 0x2a, 0x0a, 0x2a, 0x8a, 0x2a, 0xaa, 0x28, 0xaa, 0x28, 0x2a, 0x28, 0x0a, 0x00, 0x00, //	N
        };
        constexpr byte TitleLength = 6;
        constexpr byte TitleLeft = (12 - TitleLength * 2) / 2;
        ptr<byte> pVram = Vram + VramWidth * 6 + TitleLeft;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength) {
            repeat (8) {
                repeat (2) {
                    *pVram = *p; ++pVram;
                    ++p;
                }
                pVram += VramWidth - 2;
            }
            pVram += -VramWidth * 8 + 2;
        }
        PrintS(Vram + VramRowSize * 7 + TitleLeft + TitleLength * 2 - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 0, "PUSH START");
    SwitchStatus(0);
    PresentVram();
}