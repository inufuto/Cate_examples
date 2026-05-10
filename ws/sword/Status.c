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
    PrintS(VramFront + 1 * VramStep, "SCORE");
    PrintS(VramFront + 7 * VramStep, "STAGE");
    PrintByteNumber2(VramFront + VramRowSize + 10 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(VramFront + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = VramFront + 20 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            Erase2(pVram);
            Put(pVram + VramRowSize, i + 0x10);
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
    PrintS(VramFront + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
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
        constexpr byte LogoLeft = (VramWidth - LogoWidth) / 2;
        ptr<byte> pVram = VramFront + VramRowSize * 3 + LogoLeft * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoHeight) {
            repeat (LogoWidth) {
                pVram = Put(pVram, *p);
                ++p;
            }
            pVram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(VramFront + VramRowSize * 10 + (LogoLeft + LogoWidth - 4) * VramStep, "MINI");
    }
    PrintS(VramFront + VramRowSize * 13 + 3 * VramStep, "PUSH START BUTTON");
    PrintS(VramFront + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = VramFront+VramRowSize*2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}