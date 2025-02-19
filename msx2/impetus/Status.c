#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"

constexpr byte StatusHeight = 2;

byte[VVramWidth * StatusHeight] Status;

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

ptr<byte> SPrintC(ptr<byte> pStatus, byte c)
{
    *pStatus = c - ' ';
    ++pStatus;
    return pStatus;
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
            ++c;
            ++pStatus;
        }
        pStatus += VVramWidth - 2;
    }
}

void PrintStatus() 
{
    FillMemory(Status, VVramWidth * StatusHeight, Char_Space);
    SPrintS(Status + 1, "SCORE");
    SPrintS(Status + 8, "HI-SCORE");
    SPrintS(Status + 18, "STAGE");
    {
        ptr<byte> pStatus;
        pStatus = Status + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pStatus);
                Status[29] = 0;
                Status[30] = 0;
                Status[VVramWidth + 29] = i + 0x10;
                Status[VVramWidth + 30] = 0;
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
    
    pStatus = PrintNumber5(Status + VVramWidth, Score);
    SPrintC(pStatus, '0');

    pStatus = PrintNumber5(Status + VVramWidth + 9, HiScore);
    SPrintC(pStatus, '0');
}

void PrintStage()
{
    PrintByteNumber3(Status + VVramWidth + 20, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	M
        0x4c, 0x47, 0x47, 0x4b, 
        0x4c, 0x43, 0x43, 0x4f, 
        0x4c, 0x43, 0x43, 0x4f, 
        0x44, 0x41, 0x41, 0x45, 
        //	P
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x41, 
        0x44, 0x41, 0x40, 0x40, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
        //	U
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
        //	S
        0x48, 0x47, 0x45, 0x4b, 
        0x44, 0x4b, 0x4a, 0x42, 
        0x48, 0x42, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
    };

    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    StatusToVram();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 4 * 7) / 2 * VramStep;
        p = TitleBytes;
        repeat (7) {
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
}
