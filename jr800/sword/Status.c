#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Sprite;

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
    PrintS(Vram + 0 * VramStep, "SC");   
    PrintS(Vram + 9 * VramStep, "ST");
    PrintByteNumber2(Vram + 11 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 2 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + 20 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            Erase2(pVram);
            PrintC(pVram, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 4 + 8 * VramStep, "GAME OVER");
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
        constexpr byte LogoLeft = (VramWidth - LogoWidth) / 2;
        ptr<byte> pVram = Vram + VramRowSize * 1 + LogoLeft * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight / 2) {
            repeat (LogoWidth) {
                pVram = PutU(pVram, *p);
                ++p;
            }
            pVram -= LogoWidth * VramStep;
            repeat (LogoWidth) {
                pVram = PutL(pVram, *p);
                ++p;
            }
            pVram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 4 + 20 * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 5 + 5 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 6 + 5 * VramStep, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 7 + 12 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram+VramRowSize*2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}