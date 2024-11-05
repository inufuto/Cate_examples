#include "Status.h"
#include "Vram.h"
#include "Main.h"
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
    PrintS(Vram + 7 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 10 * VramStep, CurrentStage + 1);
    PrintS(Vram + 13 * VramStep, "TIME");
    {
        word yx;
        yx = Vram + 20 * VramStep;
        if (RemainCount > 1) {
            static const byte[] RemainChars = {
                Char_MyFort + 2, 
                Char_MyFort + 3,
                Char_MyFort + 6,
                Char_MyFort + 7,
            };
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2S(yx, RemainChars);
                yx += 2 * VramStep;
                yx = Put(yx, Char_Space);
                yx = Put(yx, Char_Space);
                yx += VramRowSize - 2 * VramStep;
                yx = Put(yx, i + 0x10);
                yx = Put(yx, Char_Space);
            }
            else {
                do {
                    Put2S(yx, RemainChars);
                    yx += 2 * VramStep;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word yx;
    yx = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(yx, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 14 * VramStep, StageTime);
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
            0x4f, 0x45, 0x4b, 0x40, 
            0x4f, 0x4a, 0x47, 0x4c, 
            0x4f, 0x40, 0x4f, 0x4c, 
            0x45, 0x45, 0x41, 0x44, 
            //
            0x4e, 0x4b, 0x40, 0x4d, 
            0x43, 0x4c, 0x43, 0x4c, 
            0x47, 0x4d, 0x43, 0x4c, 
            0x41, 0x44, 0x41, 0x44, 
            //
            0x47, 0x44, 0x4f, 0x41, 
            0x43, 0x40, 0x4f, 0x40, 
            0x43, 0x40, 0x4f, 0x40, 
            0x41, 0x40, 0x45, 0x40, 
            //
            0x4f, 0x40, 0x48, 0x47, 
            0x4f, 0x40, 0x4c, 0x43, 
            0x4f, 0x40, 0x4c, 0x43, 
            0x45, 0x45, 0x40, 0x45, 
            //
            0x4d, 0x42, 0x4d, 0x47, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x45, 0x40, 0x44, 0x41, 
        };
        constexpr byte LogoLength = 5;
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
    //     byte c;
    //     word yx;
    //     yx = Vram;
    //     c = 0;
    //     repeat (0) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             yx += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}