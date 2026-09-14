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
    PrintS(VramOrg + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(VramOrg + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(VramOrg + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(VramOrg + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(VramOrg + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        static const byte[] RemainChars = {
            Char_MyFort + 2, 
            Char_MyFort + 3,
            Char_MyFort + 6,
            Char_MyFort + 7,
        };
        word vram;
        vram = VramOrg + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                ptr<byte> pChars;
                pChars = RemainChars;
                repeat (2) {
                    repeat (2) {
                        Put(vram, *pChars);
                        vram += VramStep;
                        ++pChars;
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
    
    vram = PrintNumber5(VramOrg + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(VramOrg + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(VramOrg + VramRowSize * 12 + 37 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = VramOrg + VramRowSize * 10 + 10 * VramStep;
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
    PrintS(VramOrg + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(VramOrg + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	B
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x4b, 0x4a, 0x47, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	O
        0x48, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
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
        vram = VramOrg + VramRowSize * 8 + 2 * VramStep;
        p = TitleBytes;
        repeat (7) {
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
    PrintS(VramOrg + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(VramOrg + VramRowSize * 21 + 9 * VramStep, "OR CODE KEY");
}


void DrawFence()
{
    word top, bottom;
    top = VramOrg;
    bottom = VramOrg + VramRowSize * 23;
    repeat(StageWidth) {
        Put(top, Char_Fence);
        top += VramStep;
        Put(bottom, Char_Fence + 1);
        bottom += VramStep;
    }
}