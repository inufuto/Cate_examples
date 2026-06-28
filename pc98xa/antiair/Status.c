#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus()
{
    PrintS(Vram + 0, "SCORE");
    PrintS(Vram + 14, "HI-SCORE");
    PrintS(Vram + 32, "STAGE");
    {
        word vram;
        vram = Vram + 60;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put(vram, Char_Remain);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram -= 2;
                vram = PrintC(vram, i + '0');
            }
            else {
                do {
                    vram = Put(vram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
        vram = Put(vram, Char_Space);
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + 6, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + 23, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramWidth + 38, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 27, "GAME OVER");
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
        word vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 19 + 25, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 25, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 22 + 52, "INUFUTO 2026");
}

void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
