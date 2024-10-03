#include "Status.h"
#include "Vram.h"
// #include "Main.h"
#include "Sprite.h"
#include "Print.h"
// #include "Man.h"

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
    {
        ptr<byte> pVram;
        pVram = StatusPane + 10;
        if (RemainCount > 1) {
            static const byte[] Chars = {
            	0x22, 0x88, 0xaf, 0xaf,
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
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(StatusPane, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(StatusPane + 7, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (12 - 9) / 2, "GAME OVER");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x2a, 0x82, 0xa0, 0xa2, 0xa0, 0xa2, 0xa0, 0xa2, 0xaa, 0xa2, 0xa0, 0xa0, 0xa0, 0xa0, 0x00, 0x00, 
            0x82, 0x8a, 0xa2, 0x80, 0xaa, 0x80, 0x8a, 0x80, 0x82, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
            0xaa, 0x28, 0xa0, 0x28, 0xa0, 0x28, 0xa0, 0x28, 0xa0, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
            0x0a, 0xa0, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x2a, 0xa8, 0x28, 0x28, 0x28, 0x28, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 0xa2, 0xa8, 0xa2, 0x8a, 0xa2, 0x8a, 0xa2, 0xa8, 0xa2, 0x8a, 0x00, 0x00, 
        };
        constexpr byte TitleLength = 5;
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
    DrawAll();
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}
