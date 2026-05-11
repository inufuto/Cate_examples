#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Char_Remain = Char_Sprite;

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
    PrintS(Vram + VramRowSize * 1 + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 5 + 28 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 24 * VramStep, Score);
    PrintC(vram, '0');

    // vram = PrintNumber5(Vram + VramRowSize * 6 + 24 * VramStep, HiScore);
    // PrintC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + VramRowSize * 13 + 25 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            PrintC(vram + VramRowSize, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + 8 * VramStep, "GAME OVER");
}

void PrintPerfect()
{
    PrintS(Vram + VramRowSize * 7 + 9 * VramStep, "PERFECT");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
			0x2a, 0x21, 0x27, 0x28, 0x1f, 0x1e, 0x2b, 0x24, 0x23, 0x27, 0x28, 0x23, 0x27, 0x28, 0x23, 0x27, 
			0x29, 0x26, 0x1e, 0x28, 0x1f, 0x1f, 0x2b, 0x28, 0x1f, 0x2b, 0x28, 0x27, 0x23, 0x28, 0x1f, 0x2b, 
			0x26, 0x00, 0x2b, 0x20, 0x21, 0x21, 0x1d, 0x00, 0x21, 0x1d, 0x20, 0x1d, 0x21, 0x20, 0x21, 0x1d, 
			0x20, 0x21, 0x1d, 0x26, 0x00, 0x24, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x2b, 0x28, 0x28, 0x1f, 0x24, 0x26, 0x00, 0x26, 0x26, 0x00, 0x26, 0x00, 0x26, 
			0x00, 0x00, 0x00, 0x2b, 0x28, 0x28, 0x1f, 0x2b, 0x28, 0x1f, 0x2b, 0x28, 0x1f, 0x2b, 0x2a, 0x1d, 
			0x00, 0x00, 0x00, 0x2b, 0x2a, 0x2a, 0x1d, 0x29, 0x2a, 0x1d, 0x2b, 0x29, 0x1e, 0x2b, 0x20, 0x27, 
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoWidth = 4 * 4;
        constexpr byte LogoHeight = 4 * 2;
        constexpr byte LogoLeft = (VVramWidth - LogoWidth) / 2;
        word vram = Vram + VramRowSize * 2 + LogoLeft * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            repeat (LogoWidth) {
                vram = Put(vram, *p);
                ++p;
            }
            vram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 9 + (LogoLeft + LogoWidth - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 12 + 5 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 13 + 5 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2026");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0xff) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void DrawFence()
{
    word top = Vram + VramRowSize * 0;
    word bottom = Vram + VramRowSize * 15;
    repeat(VVramWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}