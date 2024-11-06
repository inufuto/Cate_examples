#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "VVram.h"

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
    PrintS(Vram + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 4 + (VVramWidth + 4) * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word yx;
        yx = Vram + VramRowSize * RaderTop + VVramWidth * VramStep;
        repeat(8) {
            repeat(6) {
                yx = Put(yx, Char_Map);
            }
            yx += VramRowSize - 6 * VramStep;
        }
    }
}

void PrintScore()
{
    word yx;
    yx = PrintNumber5(Vram + VramRowSize + VVramWidth * VramStep, Score);
    PrintC(yx, '0');
}


void PrintRemain()
{
    word yx;
    byte i;
    yx = Vram + VramRowSize * (RaderTop - 2) + VVramWidth * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            yx = Put2C(yx, Char_Remain);
            ++i;
        }
    }
    else {
        yx = Put2C(yx, Char_Remain);
        yx = Erase2(yx);
        PrintByteNumber2(Vram + VramRowSize * (RaderTop - 2) + (VVramWidth + 2) * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        yx = Erase2(yx);
        ++i;
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + (18 - 9) / 2 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4f, 0x49, 0x4c, 0x43, 
            0x43, 0x4f, 0x49, 0x4d, 
            0x47, 0x4c, 0x43, 0x43, 
            0x4e, 0x49, 
            0x4f, 0x46, 0x4c, 0x43, 
            0x43, 0x4f, 0x4c, 0x4c, 
            0x43, 0x4c, 0x43, 0x43, 
            0x4d, 0x42, 
            0x4f, 0x4c, 0x4c, 0x43, 
            0x43, 0x4f, 0x41, 0x4c, 
            0x43, 0x4c, 0x43, 0x43, 
            0x4a, 0x4c, 
            0x45, 0x44, 0x40, 0x45, 
            0x40, 0x45, 0x40, 0x44, 
            0x41, 0x40, 0x45, 0x40, 
            0x44, 0x41, 
        };
        constexpr byte LogoWidth = 14;
        ptr<byte> p;
        word yx;
        yx = Vram + VramRowSize * 4 + (18 - LogoWidth) / 2 * VramStep;
        p = TitleBytes;
        repeat (4) {
            repeat (LogoWidth) {
                yx = Put(yx, *p);
                ++p;
            }
            yx += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 8 + ((18 + LogoWidth) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 0 * VramStep, "PUSH TRIGGER");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "BUTTON");
    PrintS(Vram + VramRowSize * 17 + 6 * VramStep, "INUFUTO 2024");
    // {
    //     word yx = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             yx += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
