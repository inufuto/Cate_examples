#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + VramRowSize * 1 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 5 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 8 + WindowWidth * VramStep, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + (WindowWidth + 1) * VramStep;
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
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + (WindowWidth + 2) * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + (WindowWidth + 2) * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 8 + (WindowWidth + 6) * VramStep, CurrentStage + 1);
}


void PrintGameOver()
{
    constexpr byte Left = (WindowWidth - 8) / 2;
    PrintS(Vram + VramRowSize * (VramHeight / 2) + Left * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x2b, 0x22, 0x28, 0x29, 
            0x2c, 0x1d, 0x2c, 0x29, 
            0x2c, 0x22, 0x2c, 0x21, 
            0x22, 0x1d, 0x22, 0x1d, 
            0x28, 0x29, 0x20, 0x22, 
            0x24, 0x2c, 0x20, 0x1d, 
            0x1e, 0x21, 0x1e, 0x1d, 
            0x1d, 0x1d, 0x1d, 0x1d, 
            0x2c, 0x22, 0x29, 0x20, 
            0x2c, 0x1d, 0x29, 0x20, 
            0x22, 0x1d, 0x21, 0x1e, 
            0x1d, 0x1d, 0x1d, 0x1d, 
            0x25, 0x24, 0x2a, 0x1f, 
            0x29, 0x20, 0x29, 0x20, 
            0x29, 0x24, 0x2a, 0x20, 
            0x21, 0x1e, 0x21, 0x1e, 
            0x1d, 0x1d, 0x1d, 0x1d, 
            0x2c, 0x29, 0x24, 0x28, 
            0x2c, 0x29, 0x28, 0x24, 
            0x22, 0x21, 0x1e, 0x22, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte LogoX = (WindowWidth - LogoLength * 4)  * VramStep / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + LogoX;
        p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 20 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}


void DrawGround()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 23;
    repeat (WindowWidth) {
        pVram = Put(pVram, Char_Fence);
    }
}