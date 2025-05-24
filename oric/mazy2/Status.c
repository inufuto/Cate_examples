#include "Status.h"
#include "Vram.h"
#include "Stage.h"
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
    PrintS(Vram + VramRowSize * 1 + 34 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 34 * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 5 + 34 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 8 + 34 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 11 + 34 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 34 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 19 + 34 * VramStep;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, Char_Knife) + 1;
        --i;
    }
    Put(pVram, Char_Space);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x49, 0x44, 0x44, 0x48, 
            0x49, 0x40, 0x40, 0x4c, 
            0x49, 0x40, 0x40, 0x4c, 
            0x41, 0x3e, 0x3e, 0x42, 
            //	A
            0x3d, 0x4b, 0x4a, 0x3f, 
            0x49, 0x40, 0x3d, 0x4c, 
            0x49, 0x44, 0x42, 0x4c, 
            0x41, 0x3e, 0x3d, 0x42, 
            //	Z
            0x41, 0x42, 0x4a, 0x44, 
            0x3d, 0x45, 0x44, 0x3d, 
            0x45, 0x44, 0x3d, 0x3d, 
            0x41, 0x42, 0x42, 0x42, 
            //	Y
            0x49, 0x40, 0x49, 0x40, 
            0x41, 0x48, 0x4b, 0x3e, 
            0x3d, 0x49, 0x40, 0x3d, 
            0x3d, 0x41, 0x3e, 0x3d, 
            //	2
            0x45, 0x44, 0x42, 0x48, 
            0x3d, 0x45, 0x4b, 0x44, 
            0x45, 0x4c, 0x42, 0x3d, 
            0x41, 0x42, 0x42, 0x42, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte LogoWidth = LogoLength * 4;
        constexpr byte LogoX = (32 - LogoWidth) / 2;
        constexpr byte LogoY = 8;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * LogoY + LogoX;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
        pVram = Vram + VramRowSize * LogoY + LogoX - 2;
        repeat (4) {
            pVram[1] = Color_Cyan;
            pVram[2 + LogoWidth] = Color_White;
            pVram += VramRowSize;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 22 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0x20;
    //     repeat (Char_End - 0x20) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
