#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte ScoreLeft = 17;
constexpr byte Char_Remain = Char_Man;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p, byte shift)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c, shift);
        ++p;
        shift ^= 1;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 * VramRowSize + ScoreLeft / 2, "SCORE", 1);   
    PrintS(Vram + 1 * VramRowSize + ScoreLeft / 2, "STAGE", 1);
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 10) / 2, CurrentStage + 1, 1);
    {
        ptr<byte> pVram;
        pVram = Vram + 3 * VramRowSize + ScoreLeft / 2;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put(pVram, Char_Remain, 1);
                pVram = PrintC(pVram, i + 0x30, 1);
                pVram = PrintC(pVram, ' ', 0);
            }
            else {
                do {
                    pVram = Put(pVram, Char_Remain, 1);
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
    ptr<byte> pVram = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 6) / 2, Score, 1);
    PrintC(pVram, '0', 0);
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put(Vram + 2 * VramRowSize + ScoreLeft / 2, Char_Food, 1);
    PrintC(pVram, FoodCount + '0', 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 2 + (ScoreLeft - 9) / 2 / 2, "GAME OVER", 1);
    PresentVram();
}

void Title()
{
    static const byte[] TitleBytes = {
		0x18, 0x1d, 0x1f, 0x1a, 0x18, 0x18, 0x18, 0x00, 
		0xc0, 0xd8, 0xc1, 0xdb, 0xdb, 0xdb, 0xd9, 0x00, 
		0x00, 0x00, 0xcd, 0x6d, 0xe7, 0x01, 0xcf, 0x00, 
		0x00, 0x00, 0x9c, 0xb6, 0xbe, 0xb0, 0x1e, 0x00, 
		0x00, 0x00, 0xf0, 0xd8, 0xd8, 0xd8, 0xd8, 0x00, 
    };
    constexpr byte TitleLength = 5;
    constexpr byte TitleLeft = (ScoreLeft - TitleLength * 2) / 2;
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> pVram = Vram + VramRowSize * 0 + TitleLeft / 2;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength) {
            repeat (8) {
                *pVram = *p;
                ++p;
                pVram += VramWidth;
            }
            pVram -= VramWidth * 8 - 1;
        }
        PrintS(Vram + VramRowSize * 1 + (TitleLeft + TitleLength * 2 - 4) / 2, "NANO", 0);
    }
    PrintS(Vram + VramRowSize * 2 + 1 / 2, "PUSH SPACE KEY", 1);
    PrintS(Vram + VramRowSize * 3 + 1 / 2, "OR SHIFT KEY", 1);

    PresentVram();
}