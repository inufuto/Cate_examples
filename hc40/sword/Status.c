#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Sprite;

extern bool JoystickAvailable;

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
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 2 / 2, Score, false);
    PrintByteNumberC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + 20 / 2;
    bool right = false;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain, right);
            Erase2(pVram, right);
            PrintByteNumberC(pVram, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain, right);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram, right);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 7 / 2, "GAME OVER", true);
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
			0x0e, 0x05, 0x0b, 0x0c, 0x03, 0x02, 0x0f, 0x08, 0x07, 0x0b, 0x0c, 0x07, 0x0b, 0x0c, 0x07, 0x0b, 
			0x0d, 0x0a, 0x02, 0x0c, 0x03, 0x03, 0x0f, 0x0c, 0x03, 0x0f, 0x0c, 0x0b, 0x07, 0x0c, 0x03, 0x0f, 
			0x0a, 0x00, 0x0f, 0x04, 0x05, 0x05, 0x01, 0x00, 0x05, 0x01, 0x04, 0x01, 0x05, 0x04, 0x05, 0x01, 
			0x04, 0x05, 0x01, 0x0a, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x0f, 0x0c, 0x0c, 0x03, 0x08, 0x0a, 0x00, 0x0a, 0x0a, 0x00, 0x0a, 0x00, 0x0a, 
			0x00, 0x00, 0x00, 0x0f, 0x0c, 0x0c, 0x03, 0x0f, 0x0c, 0x03, 0x0f, 0x0c, 0x03, 0x0f, 0x0e, 0x01, 
			0x00, 0x00, 0x00, 0x0f, 0x0e, 0x0e, 0x01, 0x0d, 0x0e, 0x01, 0x0f, 0x0d, 0x02, 0x0f, 0x04, 0x0b, 
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoWidth = 4 * 4;
        constexpr byte LogoHeight = 4 * 2;
        constexpr byte LogoLeft = (24 - LogoWidth) / 2;
        ptr<byte> pVram = Vram + VramRowSize * 2 + LogoLeft / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            bool right = false;
            repeat (LogoWidth) {
                pVram = Put(pVram, *p, right);
                ++p;
                right = !right;
            }
            pVram += VramRowSize - LogoWidth / 2;
        }
        PrintS(Vram + VramRowSize * 8 + 20 / 2, "MINI", false);
    }
    if (JoystickAvailable) {
        PrintS(Vram + VramRowSize * 10 + 1, "PUSH TRIGGER BUTTON", false);    
    }
    else {
        PrintS(Vram + VramRowSize * 10 + 2, "PUSH SHIFT KEY", false);
        PrintS(Vram + VramRowSize * 12 + 2, "OR CTRL KEY", false);
    }
    PrintS(Vram + VramRowSize * 14 + 12 / 2, "INUFUTO 2026", false);
    // {
    //     ptr<byte> pVram = Vram+VramRowSize*2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 / 2;
    //         }
    //     }
    // }
}