#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");
    {
        ptr<byte> pVram;
        pVram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
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
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (24 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    HScroll = 0;
    VScroll = 0;
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x48, 0x4f, 0x42, 0x48, 
            0x4f, 0x40, 0x4f, 0x44, 
            0x4f, 0x45, 0x4f, 0x48, 
            0x45, 0x40, 0x45, 0x40, 
            0x47, 0x4d, 0x42, 0x4e, 
            0x4b, 0x4a, 0x40, 0x4f, 
            0x42, 0x4c, 0x43, 0x4f, 
            0x45, 0x45, 0x40, 0x44, 
            0x45, 0x4b, 0x4c, 0x47, 
            0x40, 0x40, 0x4c, 0x4b, 
            0x40, 0x4a, 0x4c, 0x43, 
            0x45, 0x41, 0x44, 0x45, 
            0x45, 0x4c, 0x43, 0x4c, 
            0x4a, 0x4c, 0x4f, 0x4e, 
            0x40, 0x4c, 0x43, 0x4d, 
            0x45, 0x44, 0x41, 0x44, 
            0x43, 0x4f, 0x45, 0x4b, 
            0x43, 0x4f, 0x40, 0x4f, 
            0x43, 0x4f, 0x40, 0x4f, 
            0x41, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 4 + (20 - 4 * LogoLength) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 10 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 15 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 17 + 8 * VramStep, "INUFUTO 2024");
}