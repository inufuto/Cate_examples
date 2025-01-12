#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "CopyMemory.h"

constexpr byte Pattern_Remain = Pattern_Man;

extern byte[] Chars;

static void PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    Locate(pVram);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
    EndPrint();
}

void PrintStatus() 
{
    CurrentChar(Char_Score);
    PrintS(Vram + 1, " SCORE");
    PrintS(Vram + 6, "HI-SCORE");
    PrintS(Vram + 11, " STAGE");
    EndPrint();

    CurrentChar(Char_StageValue);
    PrintByteNumber2(Vram + VramRowSize + 13, CurrentStage + 1);
    EndPrint();

    Put2C(Vram + 15, Char_Food, Pattern_Food, 15);
    {
        ptr<byte> pVram;
        byte c;
        pVram = Vram + 18;
        c = Char_Remain;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, c, Pattern_Man, 9);
                pVram += 2;
                Erase2(pVram);
                CurrentChar(Char_RemainValue);
                Locate(Vram + VramRowSize + 21);
                PrintC(i + 0x30);
                EndPrint();
            }
            else {
                while (i > 0) {
                    Put2C(pVram, c, Pattern_Man, 9);
                    c += 4;
                    pVram += 2;
                    --i;
                }
                Erase2(pVram);
            }
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    CurrentChar(Char_ScoreValue);
    PrintNumber5(Vram + VramRowSize + 1, Score);
    PrintC('0');
    EndPrint();

    CurrentChar(Char_HiScoreValue);
    PrintNumber5(Vram + VramRowSize + 7, HiScore);
    PrintC('0');
    EndPrint();
}

void PrintFoodCount()
{
    CurrentChar(Char_FoodValue);
    Locate(Vram + VramRowSize + 17);
    PrintC(FoodCount + '0');
    EndPrint();
}

void PrintGameOver()
{
    CurrentChar(Char_Message);
    PrintS(Vram + VramRowSize * 12 + 10, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
        constexpr byte left = (32 - 4 * LogoLength) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        byte c;

        pVram = Vram + VramRowSize * 7 + left * 3 / 4;
        c = Char_Logo;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                LocatePattern(pVram, 0, c);
                repeat (4) {
                    ptr<byte> pPattern;
                    PutPattern(*p);
                    ++p;
                }
                PutColor(pVram, 3, 3);
                pVram += VramRowSize;
                c += 3;
            }
            pVram += 3 - VramRowSize * 4;
        }
        // FillMemory(ColorMap + VramRowSize * 7, 4 * VramRowSize, 6);
    }
    CurrentChar(Char_Message2);
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 23 + 18, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = Char_Background & 0xf0;
    //     while (c < Char_End) {
    //         PutColor(pVram, 7 + 0, 1);
    //         *pVram = c; ++pVram;
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}