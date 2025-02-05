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


static void PrintRemain(ptr<byte> pVram)
{
    byte c;
    c = Char_MyFighter;
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - VramStep * 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 0 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 8 + 32 * VramStep, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 20 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pVram);
                pVram += VramStep * 3;
                Put(pVram, Char_Space);
                PrintC(pVram + VramRowSize, i + '0');
                pVram += VramStep;
            }
            else {
                do {
                    PrintRemain(pVram);
                    pVram += VramStep * 3;
                    --i;
                } while (i > 0);
            }
        }
        repeat (2) {
            repeat (2) {
                pVram = Put(pVram, Char_Space);
            }
            pVram += VramRowSize - VramStep * 2;
        }                
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 1 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 5 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + 37 * VramStep, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x00, 0x87, 0x86, 0x81, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x83, 0x7a, 0x43, 
        0x82, 0x80, 0x00, 0x7a, 
        //	E
        0x3b, 0x83, 0x7a, 0x80, 
        0x3b, 0x85, 0x3a, 0x81, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
        //	R
        0x3b, 0x83, 0x7a, 0x85, 
        0x3b, 0x7b, 0x84, 0x43, 
        0x3b, 0x83, 0x43, 0x81, 
        0x82, 0x80, 0x82, 0x7a, 
        //	I
        0x82, 0x86, 0x83, 0x80, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
        //	A
        0x00, 0x87, 0x86, 0x81, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x83, 0x7a, 0x43, 
        0x82, 0x80, 0x00, 0x7a, 
        //	L
        0x3b, 0x7b, 0x00, 0x00, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = Vram + VramRowSize * 7 + 4 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - VramStep * 4;
            }
            pVram += VramStep * 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR CR KEY");
    PrintS(Vram + VramRowSize * 23 + 27 * VramStep, "INUFUTO 2025");

    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat(216) {
    //         *pVram = c;
    //         ++c;
    //         ++vram;
    //     }
    // }
    // {
    //     word c;
    //     ptr<byte> pVram;
    //     c = 0x100;
    //     pVram = Vram + VramRowSize * 8;
    //     do {
    //         *pVram = c;
    //         *(vram + 0x800) = (c >> 2) | 0x08;
    //         ++c;
    //         ++vram;
    //     } while (c != 0x1e4);
    // }
}
