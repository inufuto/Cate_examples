#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + 7 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 10 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    word vram;
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + 20 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            PrintC(vram + VramRowSize, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
			0x4d, 0x44, 0x4a, 0x4b, 0x42, 0x41, 0x4e, 0x47, 0x46, 0x4a, 0x4b, 0x46, 0x4a, 0x4b, 0x46, 0x4a, 
			0x4c, 0x49, 0x41, 0x4b, 0x42, 0x42, 0x4e, 0x4b, 0x42, 0x4e, 0x4b, 0x4a, 0x46, 0x4b, 0x42, 0x4e, 
			0x49, 0x00, 0x4e, 0x43, 0x44, 0x44, 0x40, 0x00, 0x44, 0x40, 0x43, 0x40, 0x44, 0x43, 0x44, 0x40, 
			0x43, 0x44, 0x40, 0x49, 0x00, 0x47, 0x41, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x4e, 0x4b, 0x4b, 0x42, 0x47, 0x49, 0x00, 0x49, 0x49, 0x00, 0x49, 0x00, 0x49, 
			0x00, 0x00, 0x00, 0x4e, 0x4b, 0x4b, 0x42, 0x4e, 0x4b, 0x42, 0x4e, 0x4b, 0x42, 0x4e, 0x4d, 0x40, 
			0x00, 0x00, 0x00, 0x4e, 0x4d, 0x4d, 0x40, 0x4c, 0x4d, 0x40, 0x4e, 0x4c, 0x41, 0x4e, 0x43, 0x4a, 
			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoWidth = 4 * 4;
        constexpr byte LogoHeight = 4 * 2;
        constexpr byte LogoLeft = (24 - LogoWidth) / 2;
        word vram = Vram + VramRowSize * 3 + LogoLeft * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            repeat (LogoWidth) {
                vram = Put(vram, *p);
                ++p;
            }
            vram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 10 + (LogoLeft + LogoWidth - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram+VramRowSize*2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}