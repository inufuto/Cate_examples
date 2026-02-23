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
    PrintS(TVram + VramRowSize * 0 + WindowWidth * VramStep, "SCORE");
    PrintS(TVram + VramRowSize * 3 + WindowWidth * VramStep, "HIGH");
    PrintS(TVram + VramRowSize * 4 + WindowWidth * VramStep, "SCORE");
    PrintS(TVram + VramRowSize * 7 + WindowWidth * VramStep, "STAGE");
    PrintByteNumber2(TVram + VramRowSize * 7 + VramWidth - 2 * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(TVram + VramRowSize * 1 + VramWidth - 6 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(TVram + VramRowSize * 5 + VramWidth - 6 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = TVram + VramRowSize * 22 + (WindowWidth + 1) * VramStep;
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
    PrintS(TVram + VramRowSize * (VramHeight / 2) + Left * VramStep, "GAME OVER");
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
            0x80, 0x80, 0x82, 0x83, 0x81, 0x81, 0x83, 0x82, 
            0x80, 0x83, 0x83, 0x80, 0x82, 0x82, 0x82, 0x82, 
            0x80, 0x81, 0x83, 0x82, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x81, 
            //	U
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x81, 0x80, 
            //	N
            0x80, 0x83, 0x83, 0x82, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x83, 0x83, 0x82, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x80, 0x81, 0x83, 0x83, 0x83, 
            0x80, 0x81, 0x81, 0x80, 0x80, 0x80, 0x81, 0x81, 
            //	T
            0x80, 0x81, 0x81, 0x83, 0x83, 0x81, 0x81, 0x80, 
            0x80, 0x80, 0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 
            0x80, 0x80, 0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 
            0x80, 0x80, 0x80, 0x81, 0x81, 0x80, 0x80, 0x80, 
            //	U
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x83, 0x83, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x81, 0x80, 
            //	S
            0x80, 0x82, 0x83, 0x81, 0x81, 0x81, 0x83, 0x82, 
            0x80, 0x81, 0x83, 0x82, 0x82, 0x82, 0x82, 0x80, 
            0x80, 0x82, 0x82, 0x80, 0x80, 0x80, 0x83, 0x83, 
            0x80, 0x80, 0x81, 0x81, 0x81, 0x81, 0x81, 0x80, 
        };
        constexpr byte LogoLength = 6;
        constexpr byte LogoX = (WindowWidth - LogoLength * 4)  * VramStep / 2;
        ptr<byte> p;
        word vram;
        vram = TVram + VramRowSize * 7 + LogoX;
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
    PrintS(TVram + VramRowSize * 18 + (WindowWidth - 14) * VramStep / 2, "PUSH SPACE KEY");
    PrintS(TVram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR RETURN KEY");
    PrintS(TVram + VramRowSize * 23 + (WindowWidth - 12) * VramStep, "INUFUTO 2022");
    // {
    //     byte c;
    //     word vram;
    //     vram = TVram;
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
