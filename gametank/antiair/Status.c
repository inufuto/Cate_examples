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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    {
        word vram;
        vram = Vram + 26 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain);
                Erase2(vram);
                vram = Put(vram + AsciiRowHeight, i + 0x10);
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
    
    vram = PrintNumber5(Vram + AsciiRowHeight, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + AsciiRowHeight + 18 * VramStep, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    DrawAll();
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
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
    PrintS(Vram + AsciiRowHeight * 13 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 14 + 11 * VramStep, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 16 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram + VramWidth * CharHeight * 8;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramWidth * CharHeight - CharWidth * 16;
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
