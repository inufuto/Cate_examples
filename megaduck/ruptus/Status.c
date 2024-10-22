#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"

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
    // ClearScreen();

    PrintS(Vram + 14 * VramStep, "SCORE");
    // PrintS(Vram + VramRowSize * 3 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 3 + 14 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 4 + 18 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word vram;
        vram= Vram + VramRowSize * 10 + 14 * VramStep;
        repeat(8) {
            repeat(6) {
                vram = Put(vram, Char_Map);
            }
            vram += VramRowSize - 6 * VramStep;
        }
    }
}

void PrintScore()
{
    word vram;
    vram = PrintNumber5(Vram + VramRowSize + 14 * VramStep, Score);
    PrintC(vram, '0');
    // vram = PrintNumber5(Vram + VramRowSize * 4 + 26 * VramStep, HiScore);
    // PrintC(vram, '0');
}


void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram + VramRowSize * 8 + 14 * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            vram = Put2C(vram, Char_Remain);
            ++i;
        }
    }
    else {
        vram = Put2C(vram, Char_Remain);
        vram = Erase2(vram);
        PrintByteNumber2(Vram + VramRowSize * 10 + 26 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        vram = Erase2(vram);
        ++i;
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 8 + (14 - 9) / 2 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
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
        word vram;
        vram = Vram + VramRowSize * 4 + (14 - LogoWidth) / 2 * VramStep;
        p = TitleBytes;
        repeat (4) {
            repeat (LogoWidth) {
                vram = Put(vram, *p);
                ++p;
            }
            vram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 8 + ((14 + LogoWidth) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 0 * VramStep, "PUSH START");
    PrintS(Vram + VramRowSize * 15 + 8 * VramStep, "BUTTON");
    PrintS(Vram + VramRowSize * 17 + 2 * VramStep, "INUFUTO 2024");
}

void PrintRader(byte x, byte y, byte c)
{
    x = (x - 8) >> 4;
    y = (y - 8) >> 4;
    word vram = VramOffset(x + WindowWidth, y + (WindowHeight - 8)) + Vram;
    Put(vram, c);
}