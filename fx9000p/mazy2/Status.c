#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man_Left_Stop;

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
    PrintS(Vram + VramRowSize * 1 + 26 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 26 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 5 + 30 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 7 + 26 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 13 + 26 * VramStep;
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
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 26 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + 29 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 11 + 26 * VramStep;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, Char_Knife);
        --i;
    }
    Put(pVram, Char_Space);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + 8 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + 9 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 4 + (24 - LogoLength * 4) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 8 + (4 * 6 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 11 + 8 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2025");
}
