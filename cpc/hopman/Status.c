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
    PrintS(Vram + VramRowSize * 1 + 32 * 2, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * 2, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * 2, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * 2, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * 2, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 22 + 33 * 2;
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
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * 2, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * 2, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * 2, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * 2, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * 2, "TIME UP");
}

void PrintPerfect() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * 2, "PERFECT!");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	H
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x4b, 0x4a, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	O
            0x48, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	P
            0x4c, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x41, 
            0x44, 0x41, 0x40, 0x40, 
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
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
        };
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + 4 * 2;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * 2;
            }
            vram += 4 * 2 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * 2, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * 2, "INUFUTO 2023");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
