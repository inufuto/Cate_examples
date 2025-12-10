#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "CopyMemory.h"
                    #include "Stage.h"

byte[WindowWidth * StatusHeight] Status;

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
    FillMemory(Status, WindowWidth * StatusHeight, Char_Space);
    SPrintS(Status + 1, "SCORE");
    SPrintS(Status + 7, "STAGE");

    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pStatus = PrintNumber5(Status + WindowWidth, Score);
    SPrintC(pStatus, '0');
}

void PrintStage()
{
    PrintByteNumber2(Status + WindowWidth + 10, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pStatus = Status + 15;
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
    PrintS(Vram + VramRowSize * 9 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    StatusToVram();
    {
        static const byte[] TitleBytes = {
            0x28, 0x22, 0x00, 0x00, 
            0x27, 0x1e, 0x27, 0x1d, 
            0x27, 0x1e, 0x27, 0x2a, 
            0x20, 0x20, 0x1f, 0x1c, 
            0x00, 0x00, 0x00, 0x00, 
            0x29, 0x27, 0x22, 0x26, 
            0x2a, 0x27, 0x26, 0x22, 
            0x20, 0x1f, 0x1c, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x27, 0x22, 0x1c, 0x28, 
            0x27, 0x22, 0x1c, 0x27, 
            0x1f, 0x20, 0x1c, 0x1f, 
            0x00, 0x00, 0x00, 0x00, 
            0x22, 0x27, 0x1e, 0x2a, 
            0x1e, 0x27, 0x1e, 0x2a, 
            0x1c, 0x00, 0x20, 0x1c, 
            0x00, 0x00, 0x00, 0x1d, 
            0x23, 0x22, 0x1f, 0x22, 
            0x1f, 0x28, 0x1d, 0x00, 
            0x1f, 0x20, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 5 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 9 + 15 * VramStep, "MICRO");
    }
    PrintS(Vram + VramRowSize * 14 + 5 * VramStep, "1:START");
    PrintS(Vram + VramRowSize * 15 + 5 * VramStep, "2:CONTINUE");
    PrintS(Vram + VramRowSize * 17 + 8 * VramStep, "INUFUTO 2025");
    // {
    //     UpdateGroundChars(false);
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
}