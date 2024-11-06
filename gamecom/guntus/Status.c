#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static word PrintS(word yx, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        yx = PrintC(yx, c);
        ++p;
    }
    return yx;
}

void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 9 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 12 * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    word yx;
    yx = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(yx, '0');
}

void PrintRemain()
{
    word yx;
    yx = Vram + 20 * VramStep;
    if (RemainCount > 1) {
        byte n;
        n = RemainCount - 1;
        if (n > 2) {
            yx = Put2C(yx, Char_Remain);
            yx = Erase2(yx);
            Put(yx - VramStep * 2, n + 0x10);
        }
        else {
            byte i;
            i = 0;
            while (i < n) {
                yx = Put2C(yx, Char_Remain);
                ++i;
            }
            while (i < 2) {
                yx = Erase2(yx);
                ++i;
            }
        }
    }
    else {
        yx = Erase2(yx);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + (24 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 8 + (24 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	G
            0x40, 0x4e, 0x45, 0x4b, 
            0x4c, 0x43, 0x4a, 0x4a, 
            0x44, 0x4b, 0x40, 0x4f, 
            0x40, 0x44, 0x45, 0x45, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	T
            0x44, 0x4d, 0x47, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	S
            0x48, 0x47, 0x45, 0x4b, 
            0x44, 0x4b, 0x4a, 0x42, 
            0x48, 0x42, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word yx;
        yx = Vram + VramRowSize * 6 + (VramWidth - 4 * LogoLength) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    yx = Put(yx, *p);
                    ++p;
                }
                yx += VramRowSize - 4 * VramStep;
            }
            yx += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 10 + ((VramWidth + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 17 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 19 + 12 * VramStep, "INUFUTO 2024");
    // {
    //     word yx = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             yx += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}
