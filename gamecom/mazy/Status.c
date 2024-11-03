#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

static word PrintS(word yx, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        yx = PrintC(yx, c);
        ++p;
    }
    return yx;
}

void PrintStatus()
{
    PrintS(Vram + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 4 + (VVramWidth + 4) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 6 + VVramWidth * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * (VVramHeight - 2) + (VVramWidth + 1) * VramStep;
        word yx;
        byte count;
        yx = RemainLeft;
        for (count = 1; count < RemainCount; ++count) {
            yx = Put2C(yx, Char_Man);
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    word yx;
    yx = PrintNumber5(Vram + VramRowSize + VVramWidth * VramStep, Score);
    PrintC(yx, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 7 + (VVramWidth + 3) * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word yx;
    byte count, i;

    yx = Vram + VramRowSize * (VVramHeight - 4) + (VVramWidth + 1) * VramStep;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        yx = Put(yx, Char_Kn_Left);
        ++i;
        --count;
    }
    while (i != 4) {
        yx = Put(yx, Char_Space);
        ++i;
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + (VVramWidth - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 8 + (VVramWidth - 7) / 2 * VramStep, "TIME UP");
}


void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4f, 0x4d, 0x4d, 0x42, 
            0x48, 0x4f, 0x42, 0x44, 
            0x45, 0x4d, 0x43, 0x4f, 
            0x40, 0x4f, 
            0x4f, 0x4c, 0x4c, 0x43, 
            0x4f, 0x40, 0x4f, 0x40, 
            0x48, 0x47, 0x40, 0x4d, 
            0x4a, 0x47, 
            0x4f, 0x4c, 0x4c, 0x43, 
            0x4f, 0x45, 0x4f, 0x48, 
            0x47, 0x40, 0x40, 0x40, 
            0x4f, 0x40, 
            0x45, 0x44, 0x44, 0x41, 
            0x45, 0x40, 0x45, 0x44, 
            0x45, 0x45, 0x41, 0x40, 
            0x45, 0x40, 
        };
        constexpr byte LogoWidth = 14;
        ptr<byte> p;
        word yx;
        yx = Vram + VramRowSize * 4 + (18 - LogoWidth) / 2 * VramStep;
        p = TitleBytes;
        repeat (4) {
            repeat (LogoWidth) {
                yx = Put(yx, *p);
                ++p;
            }
            yx += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 8 + ((18 + LogoWidth) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 0 * VramStep, "PUSH TRIGGER");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "BUTTON");
    PrintS(Vram + VramRowSize * 17 + 6 * VramStep, "INUFUTO 2024");
}
