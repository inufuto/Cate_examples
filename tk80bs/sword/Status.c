#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "VVram.h"
#include "Man.h"

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
    PrintS(Vram + VramRowSize * 1 + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 5 + 28 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 24 * VramStep, Score);
    PrintC(pVram, '0');

    // pVram = PrintNumber5(Vram + VramRowSize * 6 + 24 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + VramRowSize * 13 + 25 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2S(pVram, ManChars);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2S(pVram, ManChars);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
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
			0x80, 0x90, 0x80, 0x83, 0x82, 0xaa, 0x80, 0xa9, 0x80, 0x80, 0x83, 0x80, 0x80, 0x83, 0x80, 0x80, 
			0x80, 0x91, 0xaa, 0x83, 0x82, 0x82, 0x80, 0x83, 0x82, 0x80, 0x83, 0x80, 0x80, 0x83, 0x82, 0x80, 
			0x91, 0x20, 0x80, 0xab, 0x90, 0x90, 0xac, 0x20, 0x90, 0xac, 0xab, 0xac, 0x90, 0xab, 0x90, 0xac, 
			0xab, 0x90, 0xac, 0x91, 0x20, 0xa9, 0xaa, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
			0x20, 0x20, 0x20, 0x80, 0x83, 0x83, 0x82, 0xa9, 0x91, 0x20, 0x91, 0x91, 0x20, 0x91, 0x20, 0x91, 
			0x20, 0x20, 0x20, 0x80, 0x83, 0x83, 0x82, 0x80, 0x83, 0x82, 0x80, 0x83, 0x82, 0x80, 0x80, 0xac, 
			0x20, 0x20, 0x20, 0x80, 0x80, 0x80, 0xac, 0x80, 0x80, 0xac, 0x80, 0x80, 0xaa, 0x80, 0xab, 0x80, 
			0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
        };
        constexpr byte LogoWidth = 4 * 4;
        constexpr byte LogoHeight = 4 * 2;
        constexpr byte LogoLeft = (VVramWidth - LogoWidth) / 2;
        ptr<byte> pVram = Vram + VramRowSize * 2 + LogoLeft * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            repeat (LogoWidth) {
                pVram = Put(pVram, *p);
                ++p;
            }
            pVram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 9 + (LogoLeft + LogoWidth - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 12 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 13 + 5, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0xff) {
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
    ptr<byte> top = Vram + VramRowSize * 0;
    ptr<byte> bottom = Vram + VramRowSize * 15;
    repeat(VVramWidth) {
        top = Put(top, 0x9d);
        bottom = Put(bottom, 0x96);
    }
}