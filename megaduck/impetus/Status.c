#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"

byte[WindowWidth * StatusHeight] Status;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

ptr<byte> SPrintC(ptr<byte> pStatus, byte c)
{
    *pStatus = c - ' ';
    return pStatus + 1;
}

static ptr<byte> SPrintS(ptr<byte> pStatus, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pStatus = SPrintC(pStatus, c);
        ++p;
    }
    return pStatus;
}


static void PrintRemain(ptr<byte> pStatus)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            *pStatus = c;
            c += 2;
            ++pStatus;
        }
        c += 1 - 4;
        pStatus += WindowWidth - 2;
    }
}

void PrintStatus() 
{
    FillMemory(Status, WindowWidth * StatusHeight, Char_Space);
    SPrintS(Status + 1, "SCORE");
    // SPrintS(Status + 8, "HI-SCORE");
    SPrintS(Status + 7, "STAGE");
    {
        ptr<byte> pStatus;
        pStatus = Status + 15;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pStatus);
                Status[17] = 0;
                Status[18] = 0;
                Status[WindowWidth + 17] = i + 0x10;
                Status[WindowWidth + 18] = 0;
            }
            else {
                do {
                    PrintRemain(pStatus);
                    pStatus += 2;
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
    ptr<byte> pStatus;
    pStatus = PrintNumber5(Status + WindowWidth, Score);
    SPrintC(pStatus, '0');
    // pStatus = PrintNumber5(Status + WindowWidth + 9, HiScore);
    // SPrintC(pStatus, '0');
}

void PrintStage()
{
    PrintByteNumber3(Status + WindowWidth + 9, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    StatusToVram(CurrentPage);
    {
        static const byte[] TitleBytes = {
            0x4d, 0x47, 0x4c, 0x47, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x45, 0x45, 0x44, 0x41, 
            0x47, 0x4b, 0x4c, 0x47, 
            0x43, 0x4f, 0x4c, 0x4b, 
            0x43, 0x4f, 0x4c, 0x43, 
            0x41, 0x45, 0x44, 0x41, 
            0x4b, 0x4c, 0x47, 0x41, 
            0x47, 0x4c, 0x4b, 0x42, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x45, 0x41, 
            0x4d, 0x47, 0x4c, 0x43, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x44, 0x41, 0x40, 0x45, 
            0x4f, 0x48, 0x47, 0x4b, 
            0x4f, 0x44, 0x4b, 0x42, 
            0x4f, 0x48, 0x42, 0x4f, 
            0x41, 0x40, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 4 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 8 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 15 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 17 + 8 * VramStep, "INUFUTO 2024");
}
