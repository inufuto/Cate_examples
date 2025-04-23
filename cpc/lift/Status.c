#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

// extern bool JoystickAvailable;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 1 + 32 * 2, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * 2, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * 2, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * 2, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * 2, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 21 + 33 * 2;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Man_Left_Stop;
                repeat (2) {
                    repeat (2) {
                        VPut(vram, c);
                        vram += 2;
                        ++c;
                    }
                    vram += VramRowSize - 2 * 2;
                }
                vram += 3 * 2 - VramRowSize * 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * 2, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * 2, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * 2, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 10 + 10 * 2;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width * 2;
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
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	F
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x41, 0x40, 0x40, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + 8 * 2;
        p = TitleBytes;
        repeat (4) {
            repeat (4) {
                repeat (4) {
                    VPut(vram, *p);
                    vram += 2;
                    ++p;
                }
                vram += VramRowSize - 4 * 2;
            }
            vram += 4 * 2 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * 2, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * 2, "INUFUTO 2022");
}
