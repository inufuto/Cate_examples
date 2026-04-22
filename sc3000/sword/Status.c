#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

extern bool KeyboardAvialable;

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
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);

    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + 28 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            Put(vram + VramRowSize, i + 0x10);
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
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x00, 0x4d, 0x44, 0x4a, 
		0x00, 0x4c, 0x49, 0x41, 
		0x00, 0x49, 0x00, 0x4e, 
		0x00, 0x43, 0x44, 0x40, 
		0x4b, 0x42, 0x41, 0x4e, 
		0x4b, 0x42, 0x42, 0x4e, 
		0x43, 0x44, 0x44, 0x40, 
		0x00, 0x00, 0x00, 0x00, 
		0x47, 0x46, 0x4a, 0x4b, 
		0x4b, 0x42, 0x4e, 0x4b, 
		0x00, 0x44, 0x40, 0x43, 
		0x00, 0x00, 0x00, 0x00, 
		0x46, 0x4a, 0x4b, 0x46, 
		0x4a, 0x46, 0x4b, 0x42, 
		0x40, 0x44, 0x43, 0x44, 
		0x00, 0x00, 0x00, 0x00, 
		0x4a, 0x00, 0x4e, 0x47, 
		0x4e, 0x00, 0x4e, 0x4b, 
		0x40, 0x00, 0x4e, 0x4b, 
		0x00, 0x00, 0x44, 0x44, 
		0x4b, 0x42, 0x00, 0x00, 
		0x4b, 0x42, 0x4d, 0x4c, 
		0x4b, 0x42, 0x4e, 0x4b, 
		0x44, 0x00, 0x43, 0x44, 
		0x00, 0x00, 0x00, 0x00, 
		0x41, 0x4e, 0x4c, 0x41, 
		0x42, 0x4e, 0x4d, 0x40, 
		0x00, 0x44, 0x43, 0x40, 
		0x00, 0x00, 0x00, 0x00, 
		0x4e, 0x47, 0x46, 0x00, 
		0x4e, 0x4c, 0x41, 0x00, 
		0x44, 0x00, 0x44, 0x00, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 8 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (8) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    if (KeyboardAvialable) {
        PrintS(Vram + VramWidth * 19 + 9, "PUSH SPACE KEY");
        PrintS(Vram + VramWidth * 20 + 9, "OR GRAPH KEY");
    }
    else {
        PrintS(Vram + VramWidth * 19 + 6, "PUSH TRIGGER BUTTON");
    }
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram + VramRowSize * 2;
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