#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

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
    PrintS(Vram + 1, "SCORE");   
    PrintS(Vram + 7, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 1 + 10, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = Vram + 19;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, ManChars);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    pVram = Put2S(pVram, ManChars);
                    pVram += VramStep;
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
    pVram = PrintNumber5(Vram + VramRowSize * 1 + 0, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    static const byte[] Chars = {
        0xc2, 0xc3, 0x91, 0x91,
    };
    ptr<byte> pVram = Put2S(Vram + 14 * VramStep, Chars);
    PrintC(pVram + VramRowSize, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + 8, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x20, 0x83, 0x80, 0xa9, 
            0x20, 0x83, 0x80, 0x80, 
            0x20, 0x83, 0x82, 0x20, 
            0x20, 0xab, 0xac, 0x20, 
            0x80, 0xa9, 0xaa, 0x20, 
            0x80, 0xa9, 0xaa, 0x80, 
            0x80, 0x83, 0x82, 0x80, 
            0x90, 0xab, 0xac, 0xab, 
            0x20, 0x20, 0x20, 0x20, 
            0x80, 0xaa, 0x80, 0x83, 
            0x90, 0xac, 0xab, 0x80, 
            0x90, 0x20, 0x90, 0x90, 
            0x20, 0x20, 0x20, 0x20, 
            0x82, 0x80, 0x80, 0xaa, 
            0x82, 0x80, 0x90, 0xac, 
            0x20, 0xab, 0x90, 0xac, 
            0x20, 0x20, 0x20, 0x20, 
            0x80, 0x80, 0xaa, 0x20, 
            0x80, 0x83, 0x82, 0x20, 
            0x90, 0xab, 0xac, 0x20, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 3 + (24 - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 7 + 18, "MINI");
    }

    PrintS(Vram + VramRowSize * 12 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 13 + 5, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 15 + 12, "INUFUTO 2025");
}