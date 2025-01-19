#include "Movable.h"
#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        *pVram = c; ++pVram;
        ++p;
    }
    return pVram;
}

static ptr<byte> PrintRemain(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (4) {
        *pVram = *pChars;
        ++pVram;
        ++pChars;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 2, "SCORE");
    PrintS(Vram + 16, "HI-SCORE");
    PrintS(Vram + 33, "STAGE");
    PrintByteNumber2(Vram + 39, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = Vram + 54;
        if (RemainCount > 1) {
            static const byte[] Chars = {
                0x88, 0xfb, 0xfb, 0x84,
            };
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = PrintRemain(pVram, Chars);
                *pVram = i + '0';
            }
            else {
                do {
                    pVram = PrintRemain(pVram, Chars);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + 8, Score);
    *pVram = '0';

    pVram = PrintNumber5(Vram + 25, HiScore);
    *pVram = '0';
}

void PrintFoodCount()
{
    static const byte[] Chars = {
        0x88, 0x8f, 0x8f, 0x84,
    };
    ptr<byte> pVram = PrintRemain(Vram + 43, Chars);
    PrintByteNumber2(pVram, FoodCount);
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 27, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x2a, 0x3d, 0x38, 
            0x00, 0x2a, 0x15, 0x01, 
            0x00, 0x02, 0x01, 0x00, 
            0x3f, 0x08, 0x04, 0x20, 
            0x3f, 0x2a, 0x15, 0x3f, 
            0x03, 0x02, 0x01, 0x02, 
            0x30, 0x00, 0x30, 0x20, 
            0x0e, 0x05, 0x0b, 0x2e, 
            0x03, 0x00, 0x03, 0x03, 
            0x10, 0x20, 0x30, 0x00, 
            0x15, 0x3f, 0x0e, 0x05, 
            0x00, 0x02, 0x03, 0x01, 
            0x30, 0x30, 0x00, 0x00, 
            0x3f, 0x2a, 0x15, 0x00, 
            0x03, 0x02, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte LogoWidth = 4 * LogoLength;
        constexpr byte LogoX = (VramWidth - LogoWidth) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 5 + LogoX;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (3) {
                repeat (4) {
                    *pVram = *p | 0xc0;
                    ++pVram;
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 3;
        }
    }
    PrintS(Vram + VramRowSize * 13 + 25, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 14 + 25, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 15 + 52, "INUFUTO 2025");
}