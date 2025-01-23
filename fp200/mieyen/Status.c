#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

static word PrintS(word vram, ptr<byte> p, bool right)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c, right);
        right = !right;
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 / 2, "SC", false);   
    PrintS(Vram + 9 / 2, "ST", true);
    PrintByteNumber2(Vram + 11 / 2, CurrentStage + 1, true);
    {
        word vram;
        bool right;
        vram = Vram + 20 / 2;
        right = false;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain, right);
                right =!right;
                vram = Put(vram, Char_Space, right);
                ++vram;
                vram = PrintC(vram, i + 0x30, right);
                right =!right;
            }
            else {
                do {
                    vram = Put2C(vram, Char_Remain, right);
                    right =!right;
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
    word vram;
    vram = PrintNumber5(Vram + 2 / 2, Score, false);
    PrintByteNumberC(vram, '0');
}

void PrintFoodCount()
{
    word vram = Put2C(Vram + 14 / 2, Char_Food, false);
    PrintC(vram, FoodCount + '0', true);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 7 / 2, "GAME OVER", true);
    // PresendVram();
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
        word vram = Vram + VramRowSize * 2 + (32 - LogoLength * 4) / 8;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                bool right;
                right = false;
                repeat (4) {
                    vram = Put(vram, *p, right);
                    right = !right;
                    ++p;
                }
                vram += VramRowSize - 2;
            }
            vram += 2 - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 6 + 18 / 2, "MINI", false);
    }

    PrintS(Vram + VramRowSize * 10 + 2, "PUSH SPACE KEY", false);
    PrintS(Vram + VramRowSize * 12 + 2, "OR RETURN KEY", false);
    PrintS(Vram + VramRowSize * 14 + 6, "INUFUTO 2025", false);
    // PresendVram();
}