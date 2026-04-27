#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 0, "SC");
    PrintS(Vram + 9, "HI");
    PrintS(Vram + 18, "ST");
    PrintByteNumber2(Vram + 20, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + 2 * VramStep , Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + 11 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + 28 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Sprite);
            Erase2(pVram);
            PrintC(pVram, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Sprite);
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
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x00, 0x0e, 0x05, 0x0b, 
		0x00, 0x0d, 0x0a, 0x02, 
		0x00, 0x0a, 0x00, 0x0f, 
		0x00, 0x04, 0x05, 0x01, 
		0x0c, 0x03, 0x02, 0x0f, 
		0x0c, 0x03, 0x03, 0x0f, 
		0x04, 0x05, 0x05, 0x01, 
		0x00, 0x00, 0x00, 0x00, 
		0x08, 0x07, 0x0b, 0x0c, 
		0x0c, 0x03, 0x0f, 0x0c, 
		0x00, 0x05, 0x01, 0x04, 
		0x00, 0x00, 0x00, 0x00, 
		0x07, 0x0b, 0x0c, 0x07, 
		0x0b, 0x07, 0x0c, 0x03, 
		0x01, 0x05, 0x04, 0x05, 
		0x00, 0x00, 0x00, 0x00, 
		0x0b, 0x00, 0x0f, 0x08, 
		0x0f, 0x00, 0x0f, 0x0c, 
		0x01, 0x00, 0x0f, 0x0c, 
		0x00, 0x00, 0x05, 0x05, 
		0x0c, 0x03, 0x00, 0x00, 
		0x0c, 0x03, 0x0e, 0x0d, 
		0x0c, 0x03, 0x0f, 0x0c, 
		0x05, 0x00, 0x04, 0x05, 
		0x00, 0x00, 0x00, 0x00, 
		0x02, 0x0f, 0x0d, 0x02, 
		0x03, 0x0f, 0x0e, 0x01, 
		0x00, 0x05, 0x04, 0x01, 
		0x00, 0x00, 0x00, 0x00, 
		0x0f, 0x08, 0x07, 0x00, 
		0x0f, 0x0d, 0x02, 0x00, 
		0x05, 0x00, 0x05, 0x00, 
    };

    HideAllSprites();
    ClearScreen(); 
    // UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7;
        p = TitleBytes;
        repeat (8) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 16 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 18 + 9, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 22 + VramWidth - 12, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     do {
    //         Put(pVram, c);
    //         ++pVram;
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16;
    //         }
    //     } while (c != 0);
    // }
}