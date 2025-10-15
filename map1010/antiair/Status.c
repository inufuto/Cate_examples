#include "Status.h"
#include "Vram.h"
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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + 26 * VramStep;
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
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
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
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
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
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2024");
    // {
    //     byte c;
    //     word v;
    //     // UfoRowLeft = 0;
    //     UpdateChars();
    //     SwitchChars();
    //     UpdateChars();
    //     SwitchChars();
    //     v = Vram;
    //     c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             v += VramRowSize - 16 * VramStep;
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
