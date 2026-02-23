#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
                #include "VVram.h"


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
    c = Char_MyFighter;
    repeat (2) {
        repeat (2) {
            VPut(vram, c);
            vram += 1;
            ++c;
        }
        vram += VramWidth - 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramWidth * 0 + 32, "SCORE");
    PrintS(Vram + VramWidth * 4 + 32, "HI-SCORE");
    PrintS(Vram + VramWidth * 8 + 32, "STAGE");
    {
        word vram;
        vram = Vram + VramWidth * 20 + 33;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(vram);
                vram += 3;
                VPut(vram, Char_Space);
                PrintC(vram + VramWidth, i + '0');
                ++vram;
            }
            else {
                do {
                    PrintRemain(vram);
                    vram += 3;
                    --i;
                } while (i > 0);
            }
        }
        repeat (2) {
            repeat (2) {
                VPut(vram, Char_Space);
                vram += 1;
            }
            vram += VramWidth - 2;
        }                
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramWidth * 2 + 34, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramWidth * 5 + 34, HiScore);
    PrintC(vram, '0');
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
        vram = Vram + VramRowSize * 7 + 4;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    VPut(vram, *p);
                    ++vram;
                    ++p;
                }
                vram += VramRowSize - 4;
            }
            vram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 23 + 27 * VramStep, "INUFUTO 2021");

    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat(222) {
    //         VPut(vram ,c);
    //         ++c;
    //         ++vram;
    //     }
    // }
    // {
    //     word c;
    //     ptr<word> p;
    //     c = 0;
    //     p = GVVram;
    //     do {
    //         *p = c;
    //         ++c;
    //         ++p;
    //     } while (c != 0x1e4);
    //     RowFlags[0] = 0xff;
    //     RowFlags[1] = 0xff;
    //     RowFlags[2] = 0xff;
    //     RowFlags[3] = 0xff;
    //     ToGVram();
    // }
}
