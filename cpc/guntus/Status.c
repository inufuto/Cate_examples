#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + VramRowSize * 0 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 4 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 7 + WindowWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 7 + VramWidth - 2 * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + VramWidth - 6 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + VramWidth - 6 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + VramRowSize * 22 + (WindowWidth + 1) * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Fighter);
            vram = Erase2(vram);
            vram += VramRowSize - 2;
            vram = PrintC(vram, i + 0x30);
            vram += 1 - VramRowSize;
        }
        else {
            do {
                vram = Put2C(vram, Char_Fighter);
                --i;
            } while (i > 0);
        }
    }
    if (RemainCount < 3) {
        vram = Erase2(vram);
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
            0x00, 0x00, 0x02, 0x03, 0x01, 0x01, 0x03, 0x02, 
            0x00, 0x03, 0x03, 0x00, 0x02, 0x02, 0x02, 0x02, 
            0x00, 0x01, 0x03, 0x02, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 
            //	U
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 
            //	N
            0x00, 0x03, 0x03, 0x02, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x00, 0x01, 0x03, 0x03, 0x03, 
            0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x01, 0x01, 
            //	T
            0x00, 0x01, 0x01, 0x03, 0x03, 0x01, 0x01, 0x00, 
            0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 
            //	U
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x03, 0x03, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 
            //	S
            0x00, 0x02, 0x03, 0x01, 0x01, 0x01, 0x03, 0x02, 
            0x00, 0x01, 0x03, 0x02, 0x02, 0x02, 0x02, 0x00, 
            0x00, 0x02, 0x02, 0x00, 0x00, 0x00, 0x03, 0x03, 
            0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 6;
        constexpr byte LogoX = (WindowWidth - LogoLength * 4)  * VramStep / 2;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + LogoX;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (8) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 18 + (WindowWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + (WindowWidth - 12) * VramStep, "INUFUTO 2022");
    // {
    //     byte c;
    //     word vram;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16;
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
