#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Sprite;

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
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    word vram = PrintNumber5(Vram + 2 / 2, Score, false);
    PrintByteNumberC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + 20 / 2;
    bool right = false;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain, right);
            Erase2(vram, right);
            PrintByteNumberC(vram, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain, right);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram, right);
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
        word vram = Vram + VramRowSize * 2 + LogoLeft / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            bool right = false;
            repeat (LogoWidth) {
                vram = Put(vram, *p, right);
                ++p;
                right = !right;
            }
            vram += VramRowSize - LogoWidth / 2;
        }
        PrintS(Vram + VramRowSize * 8 + 20 / 2, "MINI", false);
    }
    PrintS(Vram + VramRowSize * 10 + 5 / 2, "PUSH SPACE KEY", false);
    PrintS(Vram + VramRowSize * 12 + 5 / 2, "OR RETURN KEY", false);
    PrintS(Vram + VramRowSize * 14 + 12 / 2, "INUFUTO 2026", false);
    // {
    //     word vram = Vram+VramRowSize*2;
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