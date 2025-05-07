#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus()
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");
    {
        word vram = Vram + 29 * VramStep;
        if (RemainCount > 1) {
            vram = Put2C(vram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                vram += VramRowSize;
                vram = PrintC(vram, i + '0');
            }
        }
    }
    Put(Vram + 27 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        word vram = PrintNumber5(Vram + VramRowSize, Score);
        PrintC(vram, '0');
    }
    {
        word vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
        PrintC(vram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 27 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
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
            0x4c, 0x47, 0x47, 0x4b, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x44, 0x41, 0x41, 0x45, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	Z
            0x44, 0x45, 0x4d, 0x47, 
            0x40, 0x48, 0x47, 0x40, 
            0x48, 0x47, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
            //	Y
            0x4c, 0x43, 0x4c, 0x43, 
            0x44, 0x4b, 0x4e, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            //	2
            0x48, 0x47, 0x45, 0x4b, 
            0x40, 0x48, 0x4e, 0x47, 
            0x48, 0x4f, 0x45, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        word vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}