#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 12 * VramStep, "STAGE");
    {
        word yx;
        yx = Vram + 20 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                yx = Put2C(yx, Char_Remain);
                Erase2(yx);
                yx = Put(yx + VramRowSize, i + 0x10);
            }
            else {
                do {
                    yx = Put2C(yx, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    word yx;
   
    yx = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(yx, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize + 14 * VramStep, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (VramWidth - 9) / 2 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4e, 0x45, 0x4b, 0x4c, 
            0x4f, 0x40, 0x4f, 0x4c, 
            0x4f, 0x45, 0x4f, 0x44, 
            0x45, 0x40, 0x45, 0x40, 
            
            0x4b, 0x4c, 0x43, 0x45, 
            0x47, 0x4f, 0x43, 0x40, 
            0x41, 0x44, 0x41, 0x40, 
            0x40, 0x40, 0x40, 0x40, 
            
            0x4f, 0x45, 0x4c, 0x43, 
            0x4f, 0x40, 0x4c, 0x43, 
            0x45, 0x40, 0x44, 0x41, 
            0x40, 0x40, 0x40, 0x40, 
            
            0x48, 0x47, 0x4d, 0x42, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x4c, 0x47, 0x4d, 0x43, 
            0x44, 0x41, 0x44, 0x41, 
            
            0x40, 0x40, 0x40, 0x40, 
            0x4f, 0x4c, 0x47, 0x4b, 
            0x4f, 0x4c, 0x4b, 0x47, 
            0x45, 0x44, 0x41, 0x45, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word yx;
        yx = Vram + VramRowSize * 6 + (VramWidth - LogoLength * 4) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 10 + 18 * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 15 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 17 + 12 * VramStep, "INUFUTO 2024");
    // {
    //     word yx;
    //     byte c;
    //     yx = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
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
