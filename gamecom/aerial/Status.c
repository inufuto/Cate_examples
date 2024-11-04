#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
                   #include "Fort.h"     

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
    PrintStage();
    PrintScore();
}

void PrintScore()
{
    word yx;
    yx = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(yx, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize + 12 * VramStep, CurrentStage + 1);
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
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	E
            0x4c, 0x47, 0x45, 0x41, 
            0x4c, 0x4b, 0x4a, 0x42, 
            0x4c, 0x43, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
            //	R
            0x4c, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x48, 0x4f, 
            0x4c, 0x47, 0x4f, 0x42, 
            0x44, 0x41, 0x44, 0x45, 
            //	I
            0x44, 0x4d, 0x47, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x4c, 0x43, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	L
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word yx;
        yx = Vram + VramRowSize * 4 + (VramWidth - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 8 + ((VramWidth + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2024");
    // {
    //     word c;
    //     word yx;
    //     yx = Vram;
    //     c = 0x100;
    //     repeat (0) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             yx += VramRowSize - 16 * 2;
    //         }
    //     }
    // }
}