#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Cannon;

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
    PrintS(Vram + VramRowSize * 1 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + WindowWidth * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 7 + WindowWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 11 + WindowWidth * VramStep, "STAGE");
    {
        word vram;
        vram = Vram + VramRowSize * 21 + (WindowWidth + 1) * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain);
                Erase2(vram);
                vram = Put(vram + VramRowSize, i + 0x10);
            }
            else {
                do {
                    vram = Put2C(vram, Char_Remain);
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
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + (WindowWidth + 2) * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 9 + (WindowWidth + 2) * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 13 + (WindowWidth + 6) * VramStep, CurrentStage + 1);
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
            0x0e, 0x05, 0x0b, 0x0c, 
            0x0f, 0x00, 0x0f, 0x0c, 
            0x0f, 0x05, 0x0f, 0x04, 
            0x05, 0x00, 0x05, 0x00, 
            0x0b, 0x0c, 0x03, 0x05, 
            0x07, 0x0f, 0x03, 0x00, 
            0x01, 0x04, 0x01, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x05, 0x0c, 0x03, 
            0x0f, 0x00, 0x0c, 0x03, 
            0x05, 0x00, 0x04, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x08, 0x07, 0x0d, 0x02, 
            0x0c, 0x03, 0x0c, 0x03, 
            0x0c, 0x07, 0x0d, 0x03, 
            0x04, 0x01, 0x04, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x0c, 0x07, 0x0b, 
            0x0f, 0x0c, 0x0b, 0x07, 
            0x05, 0x04, 0x01, 0x05, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte LogoX = (WindowWidth - LogoLength * 4)  * VramStep / 2;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + LogoX;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 18 + (WindowWidth - 14) * VramStep / 2, "PUSH SLOW KEY");
    PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) * VramStep / 2, "OR HTAB KEY");
    PrintS(Vram + VramRowSize * 22 + (WindowWidth - 12) * VramStep, "INUFUTO 2026");
    // {
    //     byte c;
    //     word vram;
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
    word vram;
    vram = Vram + VramRowSize * 23;
    repeat (WindowWidth) {
        vram = Put(vram, Char_Fence);
    }
}