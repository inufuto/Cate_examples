#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
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
    PrintS(Vram + VramRowSize * 1 + 32 * 2, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * 2, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * 2, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * 2, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * 2, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 23 + 33 * 2;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
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
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * 2, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * 2, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * 2, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 10 + 10 * 2;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width * 2;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * 2, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * 2, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	S
        0x48, 0x47, 0x45, 0x4b, 
        0x44, 0x4b, 0x4a, 0x42, 
        0x48, 0x42, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
        //	C
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x4b, 0x40, 0x4a, 
        0x40, 0x44, 0x45, 0x41, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	N
        0x4c, 0x4b, 0x40, 0x4f, 
        0x4c, 0x4f, 0x4b, 0x4f, 
        0x4c, 0x43, 0x4d, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	D
        0x4c, 0x47, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x48, 0x47, 
        0x44, 0x45, 0x45, 0x40, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 4 * 2;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * 2;
            }
            pVram += 4 * 2 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * 2, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * 2, "INUFUTO 2025");
    // {
    //     ptr<byte> v = Vram+32*10;
    //     byte c = 0;
    //     repeat (16) {
    //         repeat (16) {
    //             v = Put(v, c);
    //             ++c;
    //         }
    //         v += VramRowSize - 16 * VramStep;
    //     }
    // }
}
