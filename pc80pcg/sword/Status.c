#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 22 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            Erase2(pVram);
            pVram = Put(pVram + VramRowSize, i + 0x10);
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
    byte y = 22;    
    repeat (2) {
        byte x = 33;
        repeat (2 * 3) {
            SetColorXY(x, y, 0xa8);
            ++x;
        }
        ++y;
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0xfc, 0x33, 0xcf, 
            0x00, 0xf3, 0xcc, 0x0c, 
            0x00, 0xcc, 0x00, 0xff, 
            0x00, 0x30, 0x33, 0x03, 
            0xf0, 0x0f, 0x0c, 0xff, 
            0xf0, 0x0f, 0x0f, 0xff, 
            0x30, 0x33, 0x33, 0x03, 
            0x00, 0x00, 0x00, 0x00, 
            0xc0, 0x3f, 0xcf, 0xf0, 
            0xf0, 0x0f, 0xff, 0xf0, 
            0x00, 0x33, 0x03, 0x30, 
            0x00, 0x00, 0x00, 0x00, 
            0x3f, 0xcf, 0xf0, 0x3f, 
            0xcf, 0x3f, 0xf0, 0x0f, 
            0x03, 0x33, 0x30, 0x33, 
            0x00, 0x00, 0x00, 0x00, 
            0xcf, 0x00, 0xff, 0xc0, 
            0xff, 0x00, 0xff, 0xf0, 
            0x03, 0x00, 0xff, 0xf0, 
            0x00, 0x00, 0x33, 0x33, 
            0xf0, 0x0f, 0x00, 0x00, 
            0xf0, 0x0f, 0xfc, 0xf3, 
            0xf0, 0x0f, 0xff, 0xf0, 
            0x33, 0x00, 0x30, 0x33, 
            0x00, 0x00, 0x00, 0x00, 
            0x0c, 0xff, 0xf3, 0x0c, 
            0x0f, 0xff, 0xfc, 0x03, 
            0x00, 0x33, 0x30, 0x03, 
            0x00, 0x00, 0x00, 0x00, 
            0xff, 0xc0, 0x3f, 0x00, 
            0xff, 0xf3, 0x0c, 0x00, 
            0x33, 0x00, 0x33, 0x00, 
        };
        constexpr byte LogoLength = 8;
        constexpr byte Left = (32 - LogoLength * 4) / 2;
        ptr<byte> pVram = Vram + VramRowSize * 8 + Left * VramStep;
        byte y = 8;
        byte x = Left;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    SetColorXY(x, y, 0xd8);
                    ++p;
                    ++x;
                }
                pVram += VramRowSize - 4 * VramStep;
                x -= 4; ++y;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
            x += 4; y -= 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 128;
    //     repeat (Char_End) {
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
    ptr<byte> pTop = Vram + VramRowSize * 1;
    ptr<byte> pBottom = Vram + VramRowSize * 24;
    byte x = 0;
    repeat(VVramWidth) {
        pTop = Put(pTop, Char_Fence);
        pBottom = Put(pBottom, Char_Fence + 1);
        SetColorXY(x, 1, 0x28);
        SetColorXY(x, 24, 0x28);
        ++x;
    }
}