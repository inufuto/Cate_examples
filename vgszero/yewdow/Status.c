#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr ptr<byte> Status = VramFront + VramStep;

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
    PrintS(Status + 1 * VramStep, "SCORE");
    PrintS(Status + 7 * VramStep, "HI-SCORE");
    PrintS(Status + 16 * VramStep, "STAGE");
    PrintByteNumber2(Status + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Status + 22 * VramStep, "TIME");
    {
        ptr<byte> pVram;
        pVram = VramFront + 28 * VramStep;
        if (RemainCount > 1) {
            Put2C(pVram, Char_Remain);
            if (RemainCount > 2) {
                Put(pVram + VramRowSize + 2 * VramStep, RemainCount + 0x0f);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Status + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Status + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Status + VramRowSize + 23 * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramBack + VramRowSize * 12 + 12 * VramStep, "TIME UP");
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
    HScroll = 0;
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> vram;
        vram = VramBack + VramRowSize * 7 + (32 - 5 * 4) / 2 * VramStep;
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
    PrintS(VramBack + VramRowSize * 19 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2025");
}