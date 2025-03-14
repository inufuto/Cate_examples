#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

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
    PrintS(Vram + AsciiRowHeight * 0 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + AsciiRowHeight * 3 + VVramWidth * VramStep, "HIGH");
    PrintS(Vram + AsciiRowHeight * 4 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + AsciiRowHeight * 7 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight * 8 + VramWidth - 2 * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + AsciiRowHeight * 1 + VramWidth - 6 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight * 5 + VramWidth - 6 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + VramRowSize * (VVramHeight - 2) + (VVramWidth + 1) * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            vram = Erase2(vram);
            vram += VramWidth - 2;
            vram = Put(vram, i + 0x10);
            vram += 1 - VramWidth;
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
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
    constexpr byte Left = (VVramWidth - 8) / 2;
    PrintS(Vram + VramRowSize * (VVramHeight / 2) + Left * VramStep, "GAME OVER");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	G
            0x00, 0x0e, 0x05, 0x0b, 
            0x0c, 0x03, 0x0a, 0x0a, 
            0x04, 0x0b, 0x00, 0x0f, 
            0x00, 0x04, 0x05, 0x05, 
            //	U
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x00, 0x05, 0x05, 0x01, 
            //	N
            0x0c, 0x0b, 0x00, 0x0f, 
            0x0c, 0x0f, 0x0b, 0x0f, 
            0x0c, 0x03, 0x0d, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
            //	T
            0x04, 0x0d, 0x07, 0x01, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
            //	U
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x00, 0x05, 0x05, 0x01, 
            //	S
            0x08, 0x07, 0x05, 0x0b, 
            0x04, 0x0b, 0x0a, 0x02, 
            0x08, 0x02, 0x00, 0x0f, 
            0x00, 0x05, 0x05, 0x01, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 9 + (VVramWidth - LogoLength * 4)  * VramStep / 2;
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
    PrintS(Vram + AsciiRowHeight * 14 + (VVramWidth - 7) * VramStep / 2, "S:START");
    PrintS(Vram + AsciiRowHeight * 15 + (VVramWidth - 7) * VramStep / 2, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 17 + (VVramWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
