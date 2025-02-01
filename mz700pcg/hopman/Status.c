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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 22 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = PrintC(pVram, i + '0');
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

void PrintPerfect() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "PERFECT!");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	H
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x8b, 0x8a, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x84, 0x81, 0x80, 0x85, 
            //	O
            0x88, 0x87, 0x85, 0x8b, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x80, 0x85, 0x85, 0x81, 
            //	P
            0x8c, 0x87, 0x85, 0x8b, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x87, 0x85, 0x81, 
            0x84, 0x81, 0x80, 0x80, 
            //	M
            0x8c, 0x87, 0x87, 0x8b, 
            0x8c, 0x83, 0x83, 0x8f, 
            0x8c, 0x83, 0x83, 0x8f, 
            0x84, 0x81, 0x81, 0x85, 
            //	A
            0x80, 0x8e, 0x8d, 0x82, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x87, 0x85, 0x8f, 
            0x84, 0x81, 0x80, 0x85, 
            //	N
            0x8c, 0x8b, 0x80, 0x8f, 
            0x8c, 0x8f, 0x8b, 0x8f, 
            0x8c, 0x83, 0x8d, 0x8f, 
            0x84, 0x81, 0x80, 0x85, 
        };
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 4 * VramStep;
        p = TitleBytes;
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
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         *pVram = c; ++pVram;
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
