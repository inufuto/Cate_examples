#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Fighter;

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
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramWidth - 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramWidth * 0 + 32, "SCORE");
    PrintS(Vram + VramWidth * 4 + 32, "HI-SCORE");
    PrintS(Vram + VramWidth * 8 + 32, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramWidth * 21 + 33;
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
                    pVram += 3;
                    --i;
                } while (i > 0);
            }
        }
        repeat (2) {
            repeat (2) {
                pVram = Put(pVram, Char_Space);
            }
            pVram += VramWidth - 2;
        }                
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramWidth * 2 + 34, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramWidth * 5 + 34, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramWidth * 8 + 37, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramWidth * 11 + 12, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	I
        0x34, 0x3d, 0x37, 0x31, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x3c, 0x33, 0x30, 
        0x34, 0x35, 0x35, 0x31, 
        //	M
        0x3c, 0x37, 0x37, 0x3b, 
        0x3c, 0x33, 0x33, 0x3f, 
        0x3c, 0x33, 0x33, 0x3f, 
        0x34, 0x31, 0x31, 0x35, 
        //	P
        0x3c, 0x37, 0x35, 0x3b, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x3c, 0x37, 0x35, 0x31, 
        0x34, 0x31, 0x30, 0x30, 
        //	E
        0x3c, 0x37, 0x35, 0x31, 
        0x3c, 0x3b, 0x3a, 0x32, 
        0x3c, 0x33, 0x30, 0x30, 
        0x34, 0x35, 0x35, 0x31, 
        //	T
        0x34, 0x3d, 0x37, 0x31, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x34, 0x31, 0x30, 
        //	U
        0x3c, 0x33, 0x30, 0x3f, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x30, 0x35, 0x35, 0x31, 
        //	S
        0x38, 0x37, 0x35, 0x3b, 
        0x34, 0x3b, 0x3a, 0x32, 
        0x38, 0x32, 0x30, 0x3f, 
        0x30, 0x35, 0x35, 0x31, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + 2;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR SHIFT KEY");

    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat(216) {
    //         *pVram = c;
    //         ++c;
    //         ++pVram;
    //     }
    // }
    // {
    //     word c;
    //     ptr<byte> pVram;
    //     c = 0x100;
    //     pVram = Vram + VramWidth * 8;
    //     do {
    //         *pVram = c;
    //         *(pVram + 0x800) = (c >> 2) | 0x08;
    //         ++c;
    //         ++pVram;
    //     } while (c != 0x1e4);
    // }
}
