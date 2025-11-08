#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"
#include "Stage.h"
                        #include "Fort.h"

extern void _deb();

byte[VramWidth * StatusHeight] Status;

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
    *pStatus = FromAscii(c);
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


void PrintStatus() 
{
    FillMemory(Status, VramWidth * StatusHeight, Char_Space);
    SPrintS(Status + 1, "SCORE");
    SPrintS(Status + 8, "HI-SCORE");
    SPrintS(Status + 18, "STAGE");

    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pStatus;
    
    pStatus = PrintNumber5(Status + VramWidth, Score);
    SPrintC(pStatus, '0');

    pStatus = PrintNumber5(Status + VramWidth + 10, HiScore);
    SPrintC(pStatus, '0');
}

void PrintStage()
{
    PrintByteNumber3(Status + VramWidth + 20, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pStatus = Status + 26;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 5) {
            *pStatus = Char_Remain; ++pStatus;
            *pStatus = i + 0x02; ++pStatus;
            i -= 2;
            while (i != 0) {
                *pStatus = Char_Space; ++pStatus;
                --i;
            }
        }
        else {
            do {
                *pStatus = Char_Remain; ++pStatus;
                --i;
            } while (i != 0);
        }
    }
    *pStatus = Char_Space;
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x29, 0x23, 0x00, 0x00, 
		0x28, 0x1f, 0x28, 0x27, 
		0x28, 0x1f, 0x28, 0x23, 
		0x21, 0x21, 0x20, 0x1d, 
		0x00, 0x00, 0x00, 0x00, 
		0x24, 0x2b, 0x28, 0x23, 
		0x23, 0x2b, 0x28, 0x27, 
		0x00, 0x21, 0x20, 0x1d, 
		0x00, 0x00, 0x00, 0x00, 
		0x27, 0x28, 0x23, 0x21, 
		0x23, 0x28, 0x23, 0x1d, 
		0x00, 0x20, 0x21, 0x21, 
		0x00, 0x00, 0x00, 0x00, 
		0x20, 0x2b, 0x1d, 0x2b, 
		0x00, 0x2b, 0x00, 0x2b, 
		0x00, 0x21, 0x00, 0x20, 
		0x00, 0x00, 0x00, 0x00, 
		0x28, 0x1f, 0x2a, 0x21, 
		0x28, 0x1f, 0x21, 0x29, 
		0x21, 0x00, 0x21, 0x21, 
		0x00, 0x00, 0x1f, 0x00, 
		0x1d, 0x21, 0x23, 0x1d, 
		0x1e, 0x00, 0x1d, 0x00, 
		0x00, 0x00, 0x00, 0x00, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    StatusToVram();
    {
        // InitLogo();
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramRowSize * 19 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     // UpdateGroundChars(false);
    //     word vram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     FortDotOffset = 1;
    //     UpdateFortChars();
    //     word vram = Vram + VramRowSize * 2 + 16 * VramStep;
    //     byte c = Char_Fort;
    //     repeat (7 * 2) {
    //         repeat (6) {
    //             vram = Put(vram, c);
    //             ++c;
    //         }
    //         vram += VramRowSize - 6 * VramStep;
    //     }
    // }
}
