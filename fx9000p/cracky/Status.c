#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

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
    PrintS(Vram + VramRowSize * 1 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 5 + (VVramWidth + 6) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 7 + VVramWidth * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 13 + (VVramWidth + 1) * VramStep;
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
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + (VVramWidth + 2) * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + (VVramWidth + 5) * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 7 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 8 + 8 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	K
        0x4c, 0x43, 0x48, 0x47, 
        0x4c, 0x4b, 0x47, 0x40, 
        0x4c, 0x43, 0x4d, 0x42, 
        0x44, 0x41, 0x40, 0x45, 
        //	Y
        0x4c, 0x43, 0x4c, 0x43, 
        0x44, 0x4b, 0x4e, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = Vram + VramRowSize * 1 + 0 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 5 + 20 * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 11 + 8 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 14 + 12 * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
