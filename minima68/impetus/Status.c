#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"
        // #include "Stage.h"
        // #include "Fort.h"

constexpr byte StatusHeight = 2;

byte[VramWidth * StatusHeight] Status;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
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
        pStatus += VramWidth - 2;
    }
}

void PrintStatus() 
{
    FillMemory(Status, VramWidth * StatusHeight, Char_Space);
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
                Status[VramWidth + 29] = i + 0x10;
                Status[VramWidth + 30] = 0;
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
    
    pStatus = PrintNumber5(Status + VramWidth, Score);
    SPrintC(pStatus, '0');

    pStatus = PrintNumber5(Status + VramWidth + 9, HiScore);
    SPrintC(pStatus, '0');
}

void PrintStage()
{
    PrintByteNumber3(Status + VramWidth + 20, CurrentStage + 1);
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
    SwitchPage();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + (32 - 4 * 7) / 2 * VramStep;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 21 + 10 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 22 + 10 * VramStep, "X:CONTINUE");
    // {
    //     FortCharOffset = 0;
    //     FortY = 0;
    //     UpdateFortChars();
    //     FortCharOffset = 42;
    //     FortY = 2;
    //     UpdateFortChars();
    //     {
    //         ptr<byte>pVram = Vram;
    //         byte c = Char_Fort;
    //         repeat (7 * 2) {
    //             repeat (6) {
    //                 pVram = Put(pVram, c);
    //                 ++c;
    //             }
    //             pVram += VramRowSize - 6;
    //         }
    //     }


    //     // GroundOffset = 0;
    //     // UpdateGroundChars();
    //     // byte c;
    //     // ptr<byte> pVram;
    //     // pVram = Vram;
    //     // c = 0;
    //     // repeat (Char_FortEnd) {
    //     //     pVram = Put(pVram, c);
    //     //     ++c;
    //     //     if ((c & 15) == 0) {
    //     //         pVram += VramRowSize - 16;
    //     //     }
    //     // }
    // }
}
