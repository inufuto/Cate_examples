#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus()
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain);
                Erase2(vram);
                vram = Put(vram + VramRowSize, i + 0x10);
            }
            else {
                do {
                    vram = Put2C(vram, Char_Remain);
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
    word address;
    
    address = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + VramRowSize * 11 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x4f, 0x40, 0x4f, 0x40, 
		0x4d, 0x4a, 0x47, 0x48, 
		0x40, 0x4f, 0x40, 0x4c, 
		0x40, 0x45, 0x40, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x47, 0x4b, 0x4c, 0x43, 
		0x47, 0x45, 0x4c, 0x43, 
		0x45, 0x41, 0x44, 0x45, 
		0x40, 0x40, 0x40, 0x40, 
		0x43, 0x4f, 0x48, 0x47, 
		0x43, 0x4f, 0x4c, 0x43, 
		0x45, 0x41, 0x40, 0x45, 
		0x4f, 0x40, 0x40, 0x40, 
		0x4f, 0x48, 0x47, 0x4b, 
		0x4f, 0x4c, 0x43, 0x4f, 
		0x45, 0x40, 0x45, 0x41, 
		0x40, 0x40, 0x40, 0x40, 
		0x4c, 0x43, 0x43, 0x4f, 
		0x4c, 0x43, 0x43, 0x4f, 
		0x44, 0x45, 0x45, 0x41, 
   };

    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 5 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (5) {
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
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2024");
}