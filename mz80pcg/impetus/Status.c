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
    c = Char_Fighter;
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
    PrintS(Vram + VramRowSize * 0 + VramStep * 32, "SCORE");
    PrintS(Vram + VramRowSize * 4 + VramStep * 32, "HI-SCORE");
    PrintS(Vram + VramRowSize * 8 + VramStep * 32, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + VramStep * 33;
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
        if (RemainCount != 3) {
            repeat (2) {
                repeat (2) {
                    pVram = Put(pVram, Char_Space);
                }
                pVram += VramRowSize - VramStep * 2;
            }                
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + VramStep * 34, Score);
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
        //	I
        0x82, 0x86, 0x83, 0x80, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
        //	M
        0x3b, 0x83, 0x83, 0x85, 
        0x3b, 0x7b, 0x7b, 0x43, 
        0x3b, 0x7b, 0x7b, 0x43, 
        0x82, 0x80, 0x80, 0x7a, 
        //	P
        0x3b, 0x83, 0x7a, 0x85, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x83, 0x7a, 0x80, 
        0x82, 0x80, 0x00, 0x00, 
        //	E
        0x3b, 0x83, 0x7a, 0x80, 
        0x3b, 0x85, 0x3a, 0x81, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
        //	T
        0x82, 0x86, 0x83, 0x80, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x00, 0x3b, 0x7b, 0x00, 
        0x00, 0x82, 0x80, 0x00, 
        //	U
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x00, 0x7a, 0x7a, 0x80, 
        //	S
        0x84, 0x83, 0x7a, 0x85, 
        0x82, 0x85, 0x3a, 0x81, 
        0x84, 0x81, 0x00, 0x43, 
        0x00, 0x7a, 0x7a, 0x80, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = Vram + VramRowSize * 7 + VramStep * 2;
        ptr<byte> p = TitleBytes;
        repeat (7) {
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
    PrintS(Vram + VramRowSize * 20 + VramStep * 9, "OR CR KEY");
}
