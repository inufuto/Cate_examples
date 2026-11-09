#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"
#include "Stage.h"

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
    PrintS(StagePane, "STAGE");
    PrintByteNumber2(StagePane + 6, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = ScorePane + 10;
        if (RemainCount > 1) {
            static const byte[] Chars = {
                0x3c, 0xcc, 0x3c, 0xc3,
            };
            byte i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, Chars, false);
                pVram = PrintC(pVram, i + '0');
            }
            else {
                do {
                    pVram = Put2S(pVram, Chars, false);
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
    ptr<byte> pVram;
    pVram = PrintNumber5(ScorePane, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2S(ScorePane + 7, FoodChars, false);
    PrintC(pVram, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (12 - 9) / 2, "GAME OVER");
    DrawAll();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (12 - 7) / 2, "TIME UP");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x02, 0x80, 0x02, 0xa2, 0x02, 0xaa, 0x02, 0x88, 0x02, 0x80, 0x02, 0x80, 0x02, 0x80, 0x00, 0x00, 
            0xa0, 0x00, 0xa2, 0x80, 0xa0, 0x02, 0xa2, 0x8a, 0xa2, 0x8a, 0xa2, 0x8a, 0xa2, 0x82, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 0xa0, 0xa2, 0x28, 0xa2, 0xa8, 0x2a, 0x00, 0x02, 0xa0, 0xaa, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 0x82, 0xa0, 0x8a, 0x28, 0x8a, 0xa8, 0x8a, 0x00, 0x02, 0xa8, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 0xaa, 0x00, 0xa2, 0x80, 0xa2, 0x80, 0xa2, 0x80, 0xa2, 0x80, 0x00, 0x00, 
        };
        constexpr byte TitleLength = 5;
        constexpr byte TitleLeft = (12 - TitleLength * 2) / 2;
        ptr<byte> pVram = Vram + VramWidth * 6 + TitleLeft;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength) {
            repeat (8) {
                repeat (2) {
                    *pVram = *p; ++pVram;
                    ++p;
                }
                pVram += VramWidth - 2;
            }
            pVram += -VramWidth * 8 + 2;
        }
        PrintS(Vram + VramRowSize * 7 + TitleLeft + TitleLength * 2 - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 0, "PUSH START");
    SwitchStatus(0);
    DrawAll();
}