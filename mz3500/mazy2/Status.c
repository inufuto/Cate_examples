#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man_Left_Stop;

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 21 + 32 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2 * VramStep;
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
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    vram = Vram + VramRowSize * 19 + 32 * VramStep;
    byte i = HeldKnifeCount;
    while (i != 0) {
        vram = Put(vram, Char_Knife) + VramStep;
        --i;
    }
    Put(vram, Char_Space);
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
            0x2a, 0x25, 0x25, 0x29, 
            0x2a, 0x21, 0x21, 0x2d, 
            0x2a, 0x21, 0x21, 0x2d, 
            0x22, 0x1f, 0x1f, 0x23, 
            //	A
            0x1e, 0x2c, 0x2b, 0x20, 
            0x2a, 0x21, 0x1e, 0x2d, 
            0x2a, 0x25, 0x23, 0x2d, 
            0x22, 0x1f, 0x1e, 0x23, 
            //	Z
            0x22, 0x23, 0x2b, 0x25, 
            0x1e, 0x26, 0x25, 0x1e, 
            0x26, 0x25, 0x1e, 0x1e, 
            0x22, 0x23, 0x23, 0x23, 
            //	Y
            0x2a, 0x21, 0x2a, 0x21, 
            0x22, 0x29, 0x2c, 0x1f, 
            0x1e, 0x2a, 0x21, 0x1e, 
            0x1e, 0x22, 0x1f, 0x1e, 
            //	2
            0x26, 0x25, 0x23, 0x29, 
            0x1e, 0x26, 0x2c, 0x25, 
            0x26, 0x2d, 0x23, 0x1e, 
            0x22, 0x23, 0x23, 0x23, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
