#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + 3, "SCORE");
    PrintS(Vram + 9, "HI-SCORE");
    PrintS(Vram + 18, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 20, CurrentStage + 1);
    PrintS(Vram+ 24, "TIME");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramWidth + 2, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramWidth + 11, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth + 25, StageTime);
}

void PrintRemain()
{
    constexpr ptr<byte> pVram = Vram + 29 * VramStep;
    if (RemainCount > 1) {
        Put(pVram, Char_Remain);
        byte i = RemainCount - 1;
        if (RemainCount >= 3) {
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            Put(pVram + VramRowSize, Char_Space);
        }
    }
    else {
        Put(pVram, Char_Space);
        Put(pVram + VramRowSize, Char_Space);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x2d, 0x02, 0x2d, 0x02, 
            0x2d, 0x02, 0x2d, 0x26, 
            0x2d, 0x02, 0x2d, 0x2a, 
            0x22, 0x23, 0x1f, 0x02, 
            0x02, 0x02, 0x2a, 0x21, 
            0x25, 0x29, 0x2a, 0x25, 
            0x21, 0x28, 0x22, 0x1f, 
            0x23, 0x1f, 0x02, 0x02, 
            0x2d, 0x02, 0x02, 0x22, 
            0x2d, 0x26, 0x25, 0x29, 
            0x23, 0x2a, 0x21, 0x2d, 
            0x02, 0x02, 0x23, 0x1f, 
            0x2b, 0x25, 0x1f, 0x02, 
            0x2a, 0x21, 0x2c, 0x2b, 
            0x22, 0x1f, 0x2d, 0x2a, 
            0x02, 0x02, 0x22, 0x23, 
            0x02, 0x2c, 0x23, 0x1f, 
            0x20, 0x22, 0x2b, 0x21, 
            0x21, 0x23, 0x23, 0x02, 
            0x02, 0x02, 0x02, 0x02, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramWidth * 7 + (32 - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    *pVram = *p;
                    ++pVram;
                    ++p;
                }
                pVram += VramWidth - 4;
            }
            pVram += 4 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramWidth * 20 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramWidth * 23 + 20 - 2, "INUFUTO 2026");
}