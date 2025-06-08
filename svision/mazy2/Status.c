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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");
     {
        ptr<byte> pVram = Vram + 16 * VramStep;
        if (RemainCount > 1) {
            pVram = Put2C(pVram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(Vram + 15 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 15 * VramStep, HeldKnifeCount + '0');
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x29, 0x24, 0x24, 0x28, 
            0x29, 0x20, 0x20, 0x2c, 
            0x29, 0x20, 0x20, 0x2c, 
            0x21, 0x1e, 0x1e, 0x22, 
            //	A
            0x1d, 0x2b, 0x2a, 0x1f, 
            0x29, 0x20, 0x1d, 0x2c, 
            0x29, 0x24, 0x22, 0x2c, 
            0x21, 0x1e, 0x1d, 0x22, 
            //	Z
            0x21, 0x22, 0x2a, 0x24, 
            0x1d, 0x25, 0x24, 0x1d, 
            0x25, 0x24, 0x1d, 0x1d, 
            0x21, 0x22, 0x22, 0x22, 
            //	Y
            0x29, 0x20, 0x29, 0x20, 
            0x21, 0x28, 0x2b, 0x1e, 
            0x1d, 0x29, 0x20, 0x1d, 
            0x1d, 0x21, 0x1e, 0x1d, 
            //	2
            0x25, 0x24, 0x22, 0x28, 
            0x1d, 0x25, 0x2b, 0x24, 
            0x25, 0x2c, 0x22, 0x1d, 
            0x21, 0x22, 0x22, 0x22, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 5 + (20 - 4 * LogoLength) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 9 + 15 * VramStep, "MICRO");
    }
    PrintS(Vram + VramRowSize * 14 + 0 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 16 + 8 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2 + VramStep;
    //     byte c = 0x00;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // DrawAll();
}