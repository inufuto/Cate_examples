#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

extern bool JoystickAvailable;

constexpr byte Char_Remain = Char_Man;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p, bool right)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c, right);
        right = !right;
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 / 2, "SC", false);   
    PrintS(Vram + 9 / 2, "ST", true);
    PrintByteNumber2(Vram + 11 / 2, CurrentStage + 1, true);
    {
        ptr<byte> pVram;
        bool right;
        pVram = Vram + 20 / 2;
        right = false;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain, right);
                right =!right;
                pVram = Put(pVram, Char_Space, right);
                ++pVram;
                pVram = PrintC(pVram, i + 0x30, right);
                right =!right;
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain, right);
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
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + 2 / 2, Score, false);
    PrintByteNumberC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + 14 / 2, Char_Food, false);
    PrintC(pVram, FoodCount + '0', true);
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
        ptr<byte> pVram = Vram + VramRowSize * 2 + (32 - LogoLength * 4) / 8;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                bool right;
                right = false;
                repeat (4) {
                    pVram = Put(pVram, *p, right);
                    right = !right;
                    ++p;
                }
                pVram += VramRowSize - 2;
            }
            pVram += 2 - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 6 + 18 / 2, "MINI", false);
    }
    if (JoystickAvailable) {
        PrintS(Vram + VramRowSize * 10 + 1, "PUSH TRIGGER BUTTON", false);    
    }
    else {
        PrintS(Vram + VramRowSize * 10 + 2, "PUSH SHIFT KEY", false);
        PrintS(Vram + VramRowSize * 12 + 2, "OR CTRL KEY", false);
    }
    PrintS(Vram + VramRowSize * 14 + 6, "INUFUTO 2025", false);
}