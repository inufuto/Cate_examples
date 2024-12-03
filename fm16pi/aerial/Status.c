#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}


static void PrintRemain(word vram)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            vram += VramStep;
            ++c;
        }
        vram += VramRowSize - VramStep * 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 0 + VramStep * 32, "SCORE");
    PrintS(Vram + VramRowSize * 3 + VramStep * 32, "HIGH");
    PrintS(Vram + VramRowSize * 4 + VramStep * 32, "SCORE");
    PrintS(Vram + VramRowSize * 8 + VramStep * 32, "STAGE");
    {
        word vram;
        vram = Vram + VramRowSize * 20 + VramStep * 33;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(vram);
                vram += VramStep * 3;
                Put(vram, Char_Space);
                PrintC(vram + VramRowSize, i + '0');
                vram += VramStep;
            }
            else {
                do {
                    PrintRemain(vram);
                    vram += VramStep * 3;
                    --i;
                } while (i > 0);
            }
        }
        if (RemainCount != 3) {
            repeat (2) {
                repeat (2) {
                    Put(vram, Char_Space);
                    vram += VramStep;
                }
                vram += VramRowSize - VramStep * 2;
            }                
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + VramStep * 34, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + VramStep * 34, HiScore);
    PrintC(vram, '0');
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
        word vram;
        vram = Vram + VramRowSize * 7 + VramStep * 4;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    Put(vram, *p);
                    vram += VramStep;
                    ++p;
                }
                vram += VramRowSize - VramStep * 4;
            }
            vram += VramStep * 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + VramStep * 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + VramStep * 9, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 28 * VramStep, "INUFUTO 2024");
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
