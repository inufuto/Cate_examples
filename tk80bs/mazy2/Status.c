#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Sprite.h"
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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 9 * VramStep, CurrentStage + 1);
    PrintS(Vram + 13, "TIME");
    {
        ptr<byte> pVram = Vram + 20 * VramStep;
        if (RemainCount > 1) {
            pVram = Put2S(pVram, ManChars);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(Vram + 18 * VramStep, 0xbc);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 14 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 18 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 9 * VramStep, "TIME UP");
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
            0x83, 0x80, 0x80, 0x80, 
            0x83, 0x82, 0x82, 0x80, 
            0x83, 0x82, 0x82, 0x80, 
            0xab, 0xac, 0xac, 0x90, 
            //	A
            0x20, 0x80, 0x80, 0xaa, 
            0x83, 0x82, 0x20, 0x80, 
            0x83, 0x80, 0x90, 0x80, 
            0xab, 0xac, 0x20, 0x90, 
            //	Z
            0xab, 0x90, 0x80, 0x80, 
            0x20, 0xa9, 0x80, 0x20, 
            0xa9, 0x80, 0x20, 0x20, 
            0xab, 0x90, 0x90, 0x90, 
            //	Y
            0x83, 0x82, 0x83, 0x82, 
            0xab, 0x80, 0x80, 0xac, 
            0x20, 0x83, 0x82, 0x20, 
            0x20, 0xab, 0xac, 0x20, 
            //	2
            0xa9, 0x80, 0x90, 0x80, 
            0x20, 0xa9, 0x80, 0x80, 
            0xa9, 0x80, 0x90, 0x20, 
            0xab, 0x90, 0x90, 0x90, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram + VramRowSize * 4 + (24 - LogoLength * 4) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 7 + 18, "MINI");
    }
    PrintS(Vram + VramRowSize * 12 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 13 + 5, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 15 + 12, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}