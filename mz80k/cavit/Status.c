#include "Status.h"
#include "Vram.h"
#include "Stage.h"
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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                pVram = Put2S(pVram, ManChars);
                ++pVram;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
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
    static const byte[] TitleBytes = {
        //	C
        0xf0, 0xfe, 0xf3, 0xfd, 
        0xfa, 0xf5, 0xf0, 0xf0, 
        0xf2, 0xfd, 0xf0, 0xfc, 
        0xf0, 0xf2, 0xf3, 0xf1, 
        //	A
        0xf0, 0xfe, 0xfb, 0xf4, 
        0xfa, 0xf5, 0xf0, 0xff, 
        0xfa, 0xf7, 0xf3, 0xff, 
        0xf2, 0xf1, 0xf0, 0xf3, 
        //	V
        0xfa, 0xf5, 0xf0, 0xff, 
        0xf2, 0xfd, 0xf8, 0xf7, 
        0xf0, 0xfb, 0xfe, 0xf1, 
        0xf0, 0xf2, 0xf3, 0xf0, 
        //	I
        0xf2, 0xfb, 0xf7, 0xf1, 
        0xf0, 0xfa, 0xf5, 0xf0, 
        0xf0, 0xfa, 0xf5, 0xf0, 
        0xf2, 0xf3, 0xf3, 0xf1, 
        //	T
        0xf2, 0xfb, 0xf7, 0xf1, 
        0xf0, 0xfa, 0xf5, 0xf0, 
        0xf0, 0xfa, 0xf5, 0xf0, 
        0xf0, 0xf2, 0xf1, 0xf0, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = Vram + VramRowSize * 8 + 6 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (5) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR CR KEY");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
