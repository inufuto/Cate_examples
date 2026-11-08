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
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(ScorePane, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = ScorePane + 10;
    if (RemainCount > 1) {
        static const byte[] Chars = {
            0x33, 0xcc, 0x03, 0xc3,
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
    if (RemainCount < 3) {
        Erase2(pVram, false);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (12 - 9) / 2, "GAME OVER");
    DrawAll();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (12 - 7) / 2, "TIME UP");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x2a, 0x82, 0xa0, 0xa2, 0xa0, 0x02, 0x2a, 0x82, 0x00, 0xa2, 0xa0, 0xa0, 0x2a, 0x80, 0x00, 0x0a, 
            0x80, 0xa0, 0x88, 0xa2, 0x88, 0xa2, 0x88, 0xa2, 0xaa, 0x80, 0x00, 0x00, 0x00, 0x00, 0x02, 0x80, 
            0xa8, 0x2a, 0x8a, 0x28, 0x8a, 0x28, 0x8a, 0x2a, 0xa8, 0x28, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
            0x82, 0xa8, 0xa2, 0x8a, 0xa2, 0x8a, 0x82, 0x8a, 0xa2, 0xa8, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
            0x00, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00, 
            0x22, 0x80, 0x22, 0x82, 0x22, 0x8a, 0x22, 0x8a, 0x22, 0x8a, 0xaa, 0x02, 0x00, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0xa0, 0xaa, 0x28, 0xa2, 0x28, 0xa2, 0x28, 0xaa, 0xa0, 0xa2, 0x00, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x0a, 0x0a, 0x8a, 0x28, 0x8a, 0xa0, 0x0a, 0x28, 0x8a, 0x0a, 0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte TitleLength = 4;
        constexpr byte TitleLeft = (12 - TitleLength * 2) / 2;
        ptr<byte> pVram = Vram + VramWidth * 6 + TitleLeft;
        ptr<byte> p = TitleBytes;
        repeat (2) {
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
            pVram += VramWidth * 8 - TitleLength * 2;
        }
        PrintS(Vram + VramRowSize * 10 + TitleLeft + TitleLength * 2 - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 0, "PUSH START");
    SwitchStatus(0);
    DrawAll();
}