#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    {
        word vram;
        vram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                byte c;
                c = Char_Remain;
                repeat (2) {
                    repeat (2) {
                        vram = Put(vram, c);
                        ++c;
                    }
                    vram += VramWidth - 2;
                }
                vram += 2 - VramWidth * 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramWidth, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth + 9, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth + 23, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + VramWidth * 11 + 10;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x4f, 0x45, 0x4d, 0x42, 
		0x4f, 0x4a, 0x4e, 0x41, 
		0x4f, 0x40, 0x4c, 0x43, 
		0x45, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4e, 0x4d, 0x42, 0x4e, 
		0x4f, 0x4c, 0x43, 0x4f, 
		0x44, 0x45, 0x40, 0x44, 
		0x40, 0x40, 0x48, 0x42, 
		0x4d, 0x42, 0x4d, 0x47, 
		0x4c, 0x43, 0x4c, 0x43, 
		0x45, 0x40, 0x40, 0x45, 
		0x40, 0x40, 0x40, 0x4c, 
		0x48, 0x47, 0x45, 0x4c, 
		0x40, 0x45, 0x4b, 0x4c, 
		0x44, 0x45, 0x41, 0x44, 
		0x43, 0x40, 0x40, 0x40, 
		0x4b, 0x47, 0x48, 0x47, 
		0x4f, 0x42, 0x4c, 0x47, 
		0x41, 0x45, 0x40, 0x45, 
		0x40, 0x4c, 0x43, 0x4f, 
		0x4b, 0x4c, 0x43, 0x4f, 
		0x45, 0x4c, 0x43, 0x4f, 
		0x41, 0x44, 0x41, 0x45, 
    };

    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + (32 - 4 * 6) / 2;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramWidth - 4;
            }
            vram += 4 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramWidth * 20 + 6, "PUSH TRIGGER BUTTON");
}