#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte Char_Remain = Char_Man_Left_Stop;

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
    PrintS(Vram + VramRowSize * 1 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + VVramWidth * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + (VVramWidth + 6) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + VVramWidth * VramStep, "TIME");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 2 + (VVramWidth + 2) * VramStep, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 6 + (VVramWidth + 2) * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + (VVramWidth + 5) * VramStep, StageTime);
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + VramRowSize * 22 + (VVramWidth + 1) * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;
    byte y;

    pVram = Vram + VramRowSize * 10 + 10 * VramStep;
    y = 10;
    repeat (height) {
        byte x;
        x = 10;
        repeat (width) {
            pVram = Put(pVram, Char_Space);
            SetColorXY(x, y, 0xe8);
            ++x;
        }
        pVram += VramRowSize - width * VramStep;
        ++y;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0xff, 0x00, 0xff, 0x00, 
            0xff, 0x00, 0xff, 0xc0, 
            0xff, 0x00, 0xff, 0xf0, 
            0x30, 0x33, 0x03, 0x00, 
            0x00, 0x00, 0xf0, 0x0f, 
            0x3f, 0xcf, 0xf0, 0x3f, 
            0x0f, 0xcc, 0x30, 0x03, 
            0x33, 0x03, 0x00, 0x00, 
            0xff, 0x00, 0x00, 0x30, 
            0xff, 0xc0, 0x3f, 0xcf, 
            0x33, 0xf0, 0x0f, 0xff, 
            0x00, 0x00, 0x33, 0x03, 
            0xf3, 0x3f, 0x03, 0x00, 
            0xf0, 0x0f, 0xfc, 0xf3, 
            0x30, 0x03, 0xff, 0xf0, 
            0x00, 0x00, 0x30, 0x33, 
            0x00, 0xfc, 0x33, 0x03, 
            0x0c, 0x30, 0xf3, 0x0f, 
            0x0f, 0x33, 0x33, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte Left = (32 - LogoLength * 4) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        byte x, y;
        pVram = Vram + VramRowSize * 8 + Left * VramStep;
        y = 8; x = Left;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    SetColorXY(x, y, 0xd8);
                    ++p;
                    ++x;
                }
                pVram += VramRowSize - 4 * VramStep;
                x -= 4; ++y;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
            x += 4; y -= 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0x80;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
