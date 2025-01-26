#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Man;
constexpr byte ScoreLeft = 18 + 1;

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
    PrintS(Vram + VramRowSize * 0 + ScoreLeft * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 1 + ScoreLeft * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 1 + (ScoreLeft + 9) * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 5 + ScoreLeft * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                Erase2(pVram);
                pVram = PrintC(pVram, i + '0');
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
                    ++pVram;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 0 + (ScoreLeft + 5) * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + VramRowSize * 3 + ScoreLeft * VramStep, Char_Food);
    pVram += VramStep;
    PrintC(pVram, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 3 + 3 * VramStep, "GAME OVER");
    PresentVram();
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x0c, 0x0b, 0x08, 
            0x00, 0x0c, 0x07, 0x07, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
            0x0f, 0x08, 0x02, 0x00, 
            0x0f, 0x08, 0x02, 0x0e, 
            0x0f, 0x0c, 0x03, 0x0f, 
            0x05, 0x04, 0x01, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x0d, 0x02, 0x0f, 0x0c, 
            0x05, 0x01, 0x04, 0x0d, 
            0x05, 0x00, 0x05, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0e, 0x0d, 0x02, 
            0x03, 0x0f, 0x05, 0x01, 
            0x00, 0x04, 0x05, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x0d, 0x02, 0x00, 
            0x0f, 0x0c, 0x03, 0x00, 
            0x05, 0x04, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 0 + (24 - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            byte shift;
            shift = 3;
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p, shift);
                    ++p;
                }
                pVram -= 4 * CharWidth;
                shift += 3;
                if (shift >= 8) {
                    shift -= 8;
                    pVram += VramRowSize;
                }
            }
            pVram += 4 * CharWidth - VramRowSize;
        }
        PrintS(Vram + VramRowSize * 2 + (24 - 8) * CharWidth, "MINI");
    }
    PrintS(Vram + VramRowSize * 3 + 1 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 4 + 1 * VramStep, "OR KANA KEY");
    PrintS(Vram + VramRowSize * 5 + 4 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = Char_Wall;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c, 0);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}
