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

static void PrintSpaces(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - VramStep * 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 0 + VramStep * 32, "SCORE");
    PrintS(Vram + VramRowSize * 4 + VramStep * 32, "HI-SCORE");
    PrintS(Vram + VramRowSize * 8 + VramStep * 32, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 20 + VramStep * 32;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pVram);
                pVram += VramStep * 3;
                PrintSpaces(pVram);
                pVram = PrintC(pVram + VramRowSize, i + '0');
            }
            else {
                do {
                    PrintRemain(pVram);
                    pVram += VramStep * 3;
                    --i;
                } while (i > 0);
            }
        }
        if (RemainCount != 3) {
            PrintSpaces(pVram);
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 1 + VramStep * 34, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 5 + VramStep * 34, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + VramStep * 37, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + VramStep * 12, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + VramStep * 4;
        p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 19 + VramStep * 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + VramStep * 9, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 23 + 27 * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     word v;
    //     v = Vram+VramRowSize*8;
    //     c = 0;
    //     repeat (16) {
    //         repeat (16) {
    //             v = Put(v, c);
    //             ++c;
    //         }
    //         v += VramRowSize - 16;
    //     }
    // }
}
