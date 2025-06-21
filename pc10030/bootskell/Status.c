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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE"); 
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Remain;
                repeat (2) {
                    repeat (2) {
                        Put(vram, c);
                        vram += VramStep;
                        ++c;
                    }
                    vram += VramRowSize - 2 * VramStep;
                }
                vram += 3 * VramStep - VramRowSize * 2;
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
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 10 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x4f, 0x45, 0x4d, 0x42, 
		0x4f, 0x4a, 0x4e, 0x41, 
		0x4f, 0x40, 0x4c, 0x43, 
		0x45, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4e, 0x4d, 0x42, 0x4e, 
		0x4f, 0x4c, 0x43, 0x4f, 
		0x44, 0x45, 0x40, 0x44, 
		0x40, 0x40, 0x48, 0x42, 
		0x4d, 0x42, 0x4d, 0x47, 
		0x4c, 0x43, 0x4c, 0x43, 
		0x45, 0x40, 0x40, 0x45, 
		0x40, 0x40, 0x40, 0x4c, 
		0x48, 0x47, 0x45, 0x4c, 
		0x40, 0x45, 0x4b, 0x4c, 
		0x44, 0x45, 0x41, 0x44, 
		0x43, 0x40, 0x40, 0x40, 
		0x4b, 0x47, 0x48, 0x47, 
		0x4f, 0x42, 0x4c, 0x47, 
		0x41, 0x45, 0x40, 0x45, 
		0x40, 0x4c, 0x43, 0x4f, 
		0x4b, 0x4c, 0x43, 0x4f, 
		0x45, 0x4c, 0x43, 0x4f, 
		0x41, 0x44, 0x41, 0x45, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + 4 * VramStep;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    Put(vram, *p);
                    vram += VramStep;
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR CODE KEY");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void DrawFence()
{
    word top, bottom;
    top = Vram;
    bottom = Vram + VramRowSize * 23;
    repeat(StageWidth) {
        Put(top, Char_Fence);
        top += VramStep;
        Put(bottom, Char_Fence + 1);
        bottom += VramStep;
    }
}