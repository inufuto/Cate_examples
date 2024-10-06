#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"

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
        PrintS(pVram, "  ");
        if (RemainCount > 1) {
            static const byte[] Chars = {
            	0xcf, 0x00, 0x3f, 0xf0,
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
    HideAllSprites();
    ClearScreen(); 
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x02, 0xa0, 0x0a, 0x28, 0x28, 0x0a, 0x28, 0x0a, 0x2a, 0xaa, 0x28, 0x0a, 0x28, 0x0a, 0x00, 0x00, //	A
            0x2a, 0xa8, 0x28, 0x00, 0x28, 0x00, 0x2a, 0xa8, 0x28, 0x00, 0x28, 0x00, 0x2a, 0xa8, 0x00, 0x00, //	E
            0x2a, 0xa8, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x2a, 0x2a, 0xa0, 0x28, 0xa8, 0x28, 0x2a, 0x00, 0x00, //	R
            0x2a, 0xa8, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x2a, 0xa8, 0x00, 0x00, //	I
            0x02, 0xa0, 0x0a, 0x28, 0x28, 0x0a, 0x28, 0x0a, 0x2a, 0xaa, 0x28, 0x0a, 0x28, 0x0a, 0x00, 0x00, //	A
            0x28, 0x00, 0x28, 0x00, 0x28, 0x00, 0x28, 0x00, 0x28, 0x00, 0x28, 0x00, 0x2a, 0xa8, 0x00, 0x00, //	L
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
    PresentVram();
}
