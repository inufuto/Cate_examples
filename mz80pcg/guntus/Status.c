#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + VramRowSize * 0 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 4 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 7 + WindowWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 8 + (VramWidth - 2) * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
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
    pVram = Vram + VramRowSize * 21 + (WindowWidth + 1) * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
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
    if (RemainCount < 3) {
        pVram = Erase2(pVram);
    }
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
            //	G
            0x00, 0x87, 0x7a, 0x85, 
            0x3b, 0x7b, 0x3a, 0x3a, 
            0x82, 0x85, 0x00, 0x43, 
            0x00, 0x82, 0x7a, 0x7a, 
            //	U
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x00, 0x7a, 0x7a, 0x80, 
            //	N
            0x3b, 0x85, 0x00, 0x43, 
            0x3b, 0x43, 0x85, 0x43, 
            0x3b, 0x7b, 0x86, 0x43, 
            0x82, 0x80, 0x00, 0x7a, 
            //	T
            0x82, 0x86, 0x83, 0x80, 
            0x00, 0x3b, 0x7b, 0x00, 
            0x00, 0x3b, 0x7b, 0x00, 
            0x00, 0x82, 0x80, 0x00, 
            //	U
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x00, 0x7a, 0x7a, 0x80, 
            //	S
            0x84, 0x83, 0x7a, 0x85, 
            0x82, 0x85, 0x3a, 0x81, 
            0x84, 0x81, 0x00, 0x43, 
            0x00, 0x7a, 0x7a, 0x80, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (WindowWidth - LogoLength * 4)  * VramStep / 2;
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
    PrintS(Vram + VramRowSize * 19 + (WindowWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR CR KEY");
    PrintS(Vram + VramRowSize * 23 + (WindowWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         *pVram = c; ++vram;
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16;
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
