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
    PrintS(Vram + VramRowSize * 1 + 32, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 22 + 33;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                Put(pVram, Char_Space);
                pVram += VramRowSize - VramStep;
                pVram = Put(pVram, i + '0');
                Put(pVram, Char_Space);
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
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 10 + 10;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	C
        0x80, 0x8e, 0x85, 0x8b, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x8b, 0x80, 0x8a, 
        0x80, 0x84, 0x85, 0x81, 
        //	R
        0x8c, 0x87, 0x85, 0x8b, 
        0x8c, 0x83, 0x88, 0x8f, 
        0x8c, 0x87, 0x8f, 0x82, 
        0x84, 0x81, 0x84, 0x85, 
        //	A
        0x80, 0x8e, 0x8d, 0x82, 
        0x8c, 0x83, 0x80, 0x8f, 
        0x8c, 0x87, 0x85, 0x8f, 
        0x84, 0x81, 0x80, 0x85, 
        //	C
        0x80, 0x8e, 0x85, 0x8b, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x8b, 0x80, 0x8a, 
        0x80, 0x84, 0x85, 0x81, 
        //	K
        0x8c, 0x83, 0x88, 0x87, 
        0x8c, 0x8b, 0x87, 0x80, 
        0x8c, 0x83, 0x8d, 0x82, 
        0x84, 0x81, 0x80, 0x85, 
        //	Y
        0x8c, 0x83, 0x8c, 0x83, 
        0x84, 0x8b, 0x8e, 0x81, 
        0x80, 0x8c, 0x83, 0x80, 
        0x80, 0x84, 0x81, 0x80, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 4;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramRowSize * 20 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20, "INUFUTO 2025");
}
