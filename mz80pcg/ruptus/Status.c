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
            0x8c, 0x87, 0x85, 0x8b, 
            0x8c, 0x83, 0x88, 0x8f, 
            0x8c, 0x87, 0x8f, 0x82, 
            0x84, 0x81, 0x84, 0x85, 
            //	U
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x80, 0x85, 0x85, 0x81, 
            //	P
            0x8c, 0x87, 0x85, 0x8b, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x87, 0x85, 0x81, 
            0x84, 0x81, 0x80, 0x80, 
            //	T
            0x84, 0x8d, 0x87, 0x81, 
            0x80, 0x8c, 0x83, 0x80, 
            0x80, 0x8c, 0x83, 0x80, 
            0x80, 0x84, 0x81, 0x80, 
            //	U
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x8c, 0x83, 0x80, 0x8f, 
            0x80, 0x85, 0x85, 0x81, 
            //	S
            0x88, 0x87, 0x85, 0x8b, 
            0x84, 0x8b, 0x8a, 0x82, 
            0x88, 0x82, 0x80, 0x8f, 
            0x80, 0x85, 0x85, 0x81, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (VVramWidth - LogoLength * 4) * VramStep / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
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
    PrintS(Vram + VramRowSize * 19 + (VVramWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + (VVramWidth - 14) * VramStep / 2, "OR CR KEY");
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
