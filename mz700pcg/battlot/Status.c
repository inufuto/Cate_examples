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
        static const byte[] RemainChars = {
            Char_MyFort + 2, 
            Char_MyFort + 3,
            Char_MyFort + 6,
            Char_MyFort + 7,
        };
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                ptr<byte> pChars;
                pChars = RemainChars;
                repeat (2) {
                    repeat (2) {
                        pVram = Put(pVram, *pChars);
                        ++pChars;
                    }
                    pVram += VramRowSize - 2 * VramStep;
                }
                pVram += 3 * VramStep - VramRowSize * 2;
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
        //	B
        0x3c, 0x37, 0x35, 0x3b, 
        0x3c, 0x3b, 0x3a, 0x37, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x34, 0x35, 0x35, 0x31, 
        //	A
        0x30, 0x3e, 0x3d, 0x32, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x3c, 0x37, 0x35, 0x3f, 
        0x34, 0x31, 0x30, 0x35, 
        //	T
        0x34, 0x3d, 0x37, 0x31, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x34, 0x31, 0x30, 
        //	T
        0x34, 0x3d, 0x37, 0x31, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x34, 0x31, 0x30, 
        //	L
        0x3c, 0x33, 0x30, 0x30, 
        0x3c, 0x33, 0x30, 0x30, 
        0x3c, 0x33, 0x30, 0x30, 
        0x34, 0x35, 0x35, 0x31, 
        //	O
        0x38, 0x37, 0x35, 0x3b, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x3c, 0x33, 0x30, 0x3f, 
        0x30, 0x35, 0x35, 0x31, 
        //	T
        0x34, 0x3d, 0x37, 0x31, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x3c, 0x33, 0x30, 
        0x30, 0x34, 0x31, 0x30, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 2;
        p = TitleBytes;
        repeat (7) {
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
    PrintS(Vram + VramRowSize * 20 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9, "OR SHIFT KEY");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void DrawFence()
{
    ptr<byte> pTop, pBottom;
    pTop = Vram;
    pBottom = Vram + VramRowSize * 23;
    repeat(StageWidth) {
        pTop = Put(pTop, Char_Fence);
        pBottom = Put(pBottom, Char_Fence + 1);
    }
}