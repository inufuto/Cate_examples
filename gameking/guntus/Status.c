#include "Status.h"
#include "Vram.h"
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
    PrintByteNumber3(StatusPane + 7, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(StatusPane, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
        ptr<byte> pVram;
        pVram = StatusPane + 10;
        PrintS(pVram, "  ");
        if (RemainCount > 1) {
            static const byte[] Chars = {
            	0x3b, 0x08, 0xb8, 0x88,
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
            0x02, 0xa8, 0x0a, 0x0a, 0x28, 0x00, 0x28, 0xaa, 0x28, 0x0a, 0x0a, 0x0a, 0x02, 0xaa, 0x00, 0x00, //	G
            0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x0a, 0xa8, 0x00, 0x00, //	U
            0x28, 0x0a, 0x2a, 0x0a, 0x2a, 0x8a, 0x2a, 0xaa, 0x28, 0xaa, 0x28, 0x2a, 0x28, 0x0a, 0x00, 0x00, //	N
            0x2a, 0xa8, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x00, 0x00, //	T
            0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x28, 0x0a, 0x0a, 0xa8, 0x00, 0x00, //	U
            0x0a, 0xa8, 0x28, 0x0a, 0x28, 0x00, 0x0a, 0xa8, 0x00, 0x0a, 0x28, 0x0a, 0x0a, 0xa8, 0x00, 0x00, //	S
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


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}
