#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
#include "Actor.h"
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
        pVram = Vram + VramRowSize * 23 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - VramStep;
                pVram = Put(pVram, i + 0x10);
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

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x00, 0x87, 0x86, 0x81, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x83, 0x7a, 0x43, 
        0x82, 0x80, 0x00, 0x7a, 
        //	S
        0x84, 0x83, 0x7a, 0x85, 
        0x82, 0x85, 0x3a, 0x81, 
        0x84, 0x81, 0x00, 0x43, 
        0x00, 0x7a, 0x7a, 0x80, 
        //	C
        0x00, 0x87, 0x7a, 0x85, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x82, 0x85, 0x00, 0x3a, 
        0x00, 0x82, 0x7a, 0x80, 
        //	E
        0x3b, 0x83, 0x7a, 0x80, 
        0x3b, 0x85, 0x3a, 0x81, 
        0x3b, 0x7b, 0x00, 0x00, 
        0x82, 0x7a, 0x7a, 0x80, 
        //	N
        0x3b, 0x85, 0x00, 0x43, 
        0x3b, 0x43, 0x85, 0x43, 
        0x3b, 0x7b, 0x86, 0x43, 
        0x82, 0x80, 0x00, 0x7a, 
        //	D
        0x3b, 0x83, 0x86, 0x81, 
        0x3b, 0x7b, 0x00, 0x43, 
        0x3b, 0x7b, 0x84, 0x83, 
        0x82, 0x7a, 0x7a, 0x00, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = Vram + VramRowSize * 8 + 4 * VramStep;
        ptr<byte> p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR CR KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
