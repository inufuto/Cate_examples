#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"
#include "CopyMemory.h"


constexpr byte StatusHeight = 2;

byte[VVramWidth * StatusHeight] Status;


ptr<byte> SPrintC(ptr<byte> pStatus, byte c)
{
    *pStatus = c - 0x20;
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
    c = Char_Fighter;
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
                Status[29] = Char_Space;
                Status[30] = Char_Space;
                Status[VVramWidth + 29] = i + 0x10;
                Status[VVramWidth + 30] = Char_Space;
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


void PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    VLocate(x, y);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
}


void PrintGameOver()
{
    PrintS(11, 12, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(12, 12, "TIME UP");
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
    PrintStatus();
    StatusToVram();
    {
        ptr<byte> p;
        byte x, y;
        x = 2;
        y = 7;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                VLocate(x, y);
                repeat (4) {
                    VPut1(*p);
                    ++p;
                }
                ++y;
            }
            y -= 4;
            x += 4;
        }
    }
    PrintS(7, 19, "PUSH TRIGGER BUTTON");
}