#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Cannon;

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
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + VramWidth - 6 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + VramWidth - 6 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 8 + VramWidth - 2 * VramStep, CurrentStage + 1);
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
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4e, 0x45, 0x4b, 0x4c, 
            0x4f, 0x40, 0x4f, 0x4c, 
            0x4f, 0x45, 0x4f, 0x44, 
            0x45, 0x40, 0x45, 0x40, 
            
            0x4b, 0x4c, 0x43, 0x45, 
            0x47, 0x4f, 0x43, 0x40, 
            0x41, 0x44, 0x41, 0x40, 
            0x40, 0x40, 0x40, 0x40, 
            
            0x4f, 0x45, 0x4c, 0x43, 
            0x4f, 0x40, 0x4c, 0x43, 
            0x45, 0x40, 0x44, 0x41, 
            0x40, 0x40, 0x40, 0x40, 
            
            0x48, 0x47, 0x4d, 0x42, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x4c, 0x47, 0x4d, 0x43, 
            0x44, 0x41, 0x44, 0x41, 
            
            0x40, 0x40, 0x40, 0x40, 
            0x4f, 0x4c, 0x47, 0x4b, 
            0x4f, 0x4c, 0x4b, 0x47, 
            0x45, 0x44, 0x41, 0x45, 
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
    PrintS(Vram + VramRowSize * 19 + (WindowWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 22 + (WindowWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
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