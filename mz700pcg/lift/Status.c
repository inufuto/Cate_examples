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

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 1 + 32, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 33;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Man_Left_Stop;
                repeat (2) {
                    repeat (2) {
                        pVram = Put(pVram, c);
                        ++c;
                    }
                    pVram += VramRowSize - 2;
                }
                pVram += 3 - VramRowSize * 2;
                --i;
            } while (i > 0);
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
        //	L
        0x8c, 0x83, 0x80, 0x80, 
        0x8c, 0x83, 0x80, 0x80, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x85, 0x85, 0x81, 
        //	I
        0x84, 0x8d, 0x87, 0x81, 
        0x80, 0x8c, 0x83, 0x80, 
        0x80, 0x8c, 0x83, 0x80, 
        0x84, 0x85, 0x85, 0x81, 
        //	F
        0x8c, 0x87, 0x85, 0x81, 
        0x8c, 0x8b, 0x8a, 0x82, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x81, 0x80, 0x80, 
        //	T
        0x84, 0x8d, 0x87, 0x81, 
        0x80, 0x8c, 0x83, 0x80, 
        0x80, 0x8c, 0x83, 0x80, 
        0x80, 0x84, 0x81, 0x80, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 8;
        p = TitleBytes;
        repeat (4) {
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
