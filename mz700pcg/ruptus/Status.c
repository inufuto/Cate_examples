#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"
#include "VVram.h"
#include "Main.h"
#include "Stage.h"
#include "Rader.h"

constexpr byte Char_Remain = Char_Fighter;

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
    PrintS(Vram + VramRowSize * 0 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + VVramWidth * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 8 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 8 + (VramWidth - 2) * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
    PrintRader();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 1 + (VramWidth - 6) * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 5 + (VramWidth - 6) * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 10 + (VVramWidth + 1) * VramStep;
    if (RemainFighterCount > 1) {
        byte i;
        i = RemainFighterCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            pVram = Erase2(pVram);
            pVram += VramRowSize - 2;
            pVram = PrintC(pVram, i + 0x30);
            pVram += 1 - VramRowSize;
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }
    if (RemainFighterCount < 3) {
        pVram = Erase2(pVram);
    }
}


void PrintGameOver()
{
    constexpr byte Left = (VVramWidth - 8) / 2;
    PrintS(Vram + VramRowSize * (VramHeight / 2) + Left * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	R
            0x3c, 0x37, 0x35, 0x3b, 
            0x3c, 0x33, 0x38, 0x3f, 
            0x3c, 0x37, 0x3f, 0x32, 
            0x34, 0x31, 0x34, 0x35, 
            //	U
            0x3c, 0x33, 0x30, 0x3f, 
            0x3c, 0x33, 0x30, 0x3f, 
            0x3c, 0x33, 0x30, 0x3f, 
            0x30, 0x35, 0x35, 0x31, 
            //	P
            0x3c, 0x37, 0x35, 0x3b, 
            0x3c, 0x33, 0x30, 0x3f, 
            0x3c, 0x37, 0x35, 0x31, 
            0x34, 0x31, 0x30, 0x30, 
            //	T
            0x34, 0x3d, 0x37, 0x31, 
            0x30, 0x3c, 0x33, 0x30, 
            0x30, 0x3c, 0x33, 0x30, 
            0x30, 0x34, 0x31, 0x30, 
            //	U
            0x3c, 0x33, 0x30, 0x3f, 
            0x3c, 0x33, 0x30, 0x3f, 
            0x3c, 0x33, 0x30, 0x3f, 
            0x30, 0x35, 0x35, 0x31, 
            //	S
            0x38, 0x37, 0x35, 0x3b, 
            0x34, 0x3b, 0x3a, 0x32, 
            0x38, 0x32, 0x30, 0x3f, 
            0x30, 0x35, 0x35, 0x31, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        ptr<byte> pVram;
        byte x, y;
        pVram = Vram + VramRowSize * 7 + (VVramWidth - LogoLength * 4) * VramStep / 2;
        y = 7; x = (WindowWidth - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
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
    PrintS(Vram + VramRowSize * 19 + (VVramWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + (VVramWidth - 14) * VramStep / 2, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + (VVramWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
