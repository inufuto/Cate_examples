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

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 1 + 32 * CharHeight, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * CharHeight, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * CharHeight, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * CharHeight, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * CharHeight, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 21 + 33 * CharHeight;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Man_Left_Stop;
                repeat (2) {
                    repeat (2) {
                        VPut(vram, c);
                        vram += CharHeight;
                        ++c;
                    }
                    vram += VramRowSize - 2 * CharHeight;
                }
                vram += 3 * CharHeight - VramRowSize * 2;
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
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * CharHeight, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * CharHeight, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * CharHeight, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 10 + 10 * CharHeight;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width * CharHeight;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * CharHeight, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * CharHeight, "TIME UP");
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
        vram = Vram + VramRowSize * 8 + 8 * CharHeight;
        p = TitleBytes;
        repeat (4) {
            repeat (4) {
                repeat (4) {
                    VPut(vram, *p);
                    vram += CharHeight;
                    ++p;
                }
                vram += VramRowSize - 4 * CharHeight;
            }
            vram += 4 * CharHeight - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * CharHeight, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * CharHeight, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * CharHeight, "INUFUTO 2021");
}
