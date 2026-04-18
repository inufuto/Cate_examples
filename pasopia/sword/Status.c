#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte Char_Remain = Char_Sprite;

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 6 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 11 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 11 + 38 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}


void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 8 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + VramRowSize * 22 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            PrintC(vram, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    word vram;

    vram = Vram + VramWidth * 10 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = Put(vram, Char_Space);
        }
        vram += VramWidth - width * 2;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
		0x00, 0x0e, 0x05, 0x0b, 
		0x00, 0x0d, 0x0a, 0x02, 
		0x00, 0x0a, 0x00, 0x0f, 
		0x00, 0x04, 0x05, 0x01, 
		0x0c, 0x03, 0x02, 0x0f, 
		0x0c, 0x03, 0x03, 0x0f, 
		0x04, 0x05, 0x05, 0x01, 
		0x00, 0x00, 0x00, 0x00, 
		0x08, 0x07, 0x0b, 0x0c, 
		0x0c, 0x03, 0x0f, 0x0c, 
		0x00, 0x05, 0x01, 0x04, 
		0x00, 0x00, 0x00, 0x00, 
		0x07, 0x0b, 0x0c, 0x07, 
		0x0b, 0x07, 0x0c, 0x03, 
		0x01, 0x05, 0x04, 0x05, 
		0x00, 0x00, 0x00, 0x00, 
		0x0b, 0x00, 0x0f, 0x08, 
		0x0f, 0x00, 0x0f, 0x0c, 
		0x01, 0x00, 0x0f, 0x0c, 
		0x00, 0x00, 0x05, 0x05, 
		0x0c, 0x03, 0x00, 0x00, 
		0x0c, 0x03, 0x0e, 0x0d, 
		0x0c, 0x03, 0x0f, 0x0c, 
		0x05, 0x00, 0x04, 0x05, 
		0x00, 0x00, 0x00, 0x00, 
		0x02, 0x0f, 0x0d, 0x02, 
		0x03, 0x0f, 0x0e, 0x01, 
		0x00, 0x05, 0x04, 0x01, 
		0x00, 0x00, 0x00, 0x00, 
		0x0f, 0x08, 0x07, 0x00, 
		0x0f, 0x0d, 0x02, 0x00, 
		0x05, 0x00, 0x05, 0x00, 
        };
        constexpr byte LogoLength = 8;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
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
    PrintS(Vram + VramRowSize * 18 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR GRAPH KEY");
    PrintS(Vram + VramRowSize * 22 + 20 * VramStep, "INUFUTO 2026");
}


void DrawFence()
{
    word top = Vram + VramRowSize * 1;
    word bottom = Vram + VramRowSize * 24;
    repeat(VVramWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}